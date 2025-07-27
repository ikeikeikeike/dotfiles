#!/usr/bin/env zsh
# Advanced file locking for ZSH history to prevent corruption

# Enable ZSH's built-in fcntl locking if available
setopt hist_fcntl_lock 2>/dev/null || {
    # Fallback: Implement custom locking mechanism
    
    # Override history write with locking
    _locked_history_write() {
        local histfile="${HISTFILE:-$HOME/.zsh_history}"
        local lockfile="$histfile.lock"
        local lockdir="$histfile.lockdir"
        local timeout=10
        local elapsed=0
        
        # Try directory-based lock (atomic on most filesystems)
        while ! mkdir "$lockdir" 2>/dev/null; do
            if [[ $elapsed -ge $timeout ]]; then
                # Check if lock is stale
                if [[ -d "$lockdir" ]]; then
                    local lock_age=$(($(date +%s) - $(stat -f %m "$lockdir" 2>/dev/null || stat -c %Y "$lockdir" 2>/dev/null || echo 0)))
                    if [[ $lock_age -gt 30 ]]; then
                        # Stale lock, remove it
                        rmdir "$lockdir" 2>/dev/null
                        continue
                    fi
                fi
                echo "Warning: History lock timeout, proceeding without lock" >&2
                break
            fi
            sleep 0.1
            elapsed=$((elapsed + 1))
        done
        
        # Write history
        builtin fc -W "$histfile" || builtin fc -A "$histfile"
        
        # Release lock
        rmdir "$lockdir" 2>/dev/null
    }
    
    # Hook into ZSH's history mechanism
    if [[ -n "$TMUX" ]]; then
        # In tmux, be more aggressive about saving history
        add-zsh-hook precmd _locked_history_write 2>/dev/null
        add-zsh-hook zshexit _locked_history_write 2>/dev/null
    fi
}

# Additional protection: Monitor for concurrent writes
_monitor_concurrent_writes() {
    local histfile="${HISTFILE:-$HOME/.zsh_history}"
    local last_size_file="$histfile.last_size"
    local current_size=$(wc -c < "$histfile" 2>/dev/null || echo 0)
    
    if [[ -f "$last_size_file" ]]; then
        local last_size=$(cat "$last_size_file" 2>/dev/null || echo 0)
        
        # If file size decreased significantly, it might be corrupted
        if [[ $current_size -lt $((last_size * 8 / 10)) ]]; then
            echo "Warning: History file size decreased significantly!" >&2
            echo "Last size: $last_size, Current size: $current_size" >&2
            
            # Create emergency backup
            local backup="$histfile.emergency_$(date +%Y%m%d_%H%M%S)"
            cp "$histfile" "$backup" 2>/dev/null
            echo "Emergency backup created: $backup" >&2
        fi
    fi
    
    echo "$current_size" > "$last_size_file"
}

# Enable concurrent write monitoring
if [[ -n "$TMUX" ]]; then
    add-zsh-hook precmd _monitor_concurrent_writes 2>/dev/null
fi

# Function to repair corrupted history
repair_history() {
    local histfile="${HISTFILE:-$HOME/.zsh_history}"
    local backup="$histfile.repair_backup_$(date +%Y%m%d_%H%M%S)"
    
    echo "Creating backup: $backup"
    cp "$histfile" "$backup"
    
    echo "Removing null bytes and invalid entries..."
    # Remove null bytes and fix common corruption patterns
    perl -i -pe 's/\x00//g' "$histfile"
    
    # Remove lines that don't match history format
    local temp_file="$histfile.cleaned"
    grep -E '^: [0-9]+:[0-9]+;' "$histfile" > "$temp_file" 2>/dev/null || true
    
    if [[ -s "$temp_file" ]]; then
        local orig_lines=$(wc -l < "$histfile")
        local clean_lines=$(wc -l < "$temp_file")
        echo "Original lines: $orig_lines, Clean lines: $clean_lines"
        
        if [[ $clean_lines -gt 0 ]]; then
            mv "$temp_file" "$histfile"
            echo "History repaired successfully"
        else
            echo "Error: No valid history entries found"
            rm -f "$temp_file"
        fi
    else
        echo "Error: Could not clean history file"
        rm -f "$temp_file"
    fi
}

# Alias for manual history repair
alias zsh-repair-history='repair_history'

# Informational message
if [[ -n "$TMUX" ]]; then
    echo "ZSH history locking enabled for tmux session"
fi