#!/usr/bin/env zsh
# Optimized ZSH history configuration for tmux concurrent sessions

# Function to setup tmux-aware history
setup_tmux_history() {
    # If in tmux, use session-specific history to avoid conflicts
    if [[ -n "$TMUX" ]]; then
        # Create tmux history directory
        local tmux_hist_dir="$HOME/.zsh_history_tmux"
        [[ ! -d "$tmux_hist_dir" ]] && mkdir -p "$tmux_hist_dir"
        
        # Get tmux session info
        local session_name=$(tmux display-message -p "#{session_name}")
        local window_index=$(tmux display-message -p "#{window_index}")
        local pane_index=$(tmux display-message -p "#{pane_index}")
        
        # Use session-specific history file
        export HISTFILE="$tmux_hist_dir/${session_name}_${window_index}_${pane_index}.hist"
        
        # Create the history file if it doesn't exist
        [[ ! -f "$HISTFILE" ]] && touch "$HISTFILE"
        
        # Disable share_history to prevent conflicts between panes
        setopt no_share_history
        
        # Enable immediate append with locking
        setopt inc_append_history_time
        
        # Enable fcntl locking if available
        setopt hist_fcntl_lock 2>/dev/null || true
    else
        # Standard history configuration for non-tmux sessions
        export HISTFILE="$HOME/.zsh_history"
        
        # Enable history sharing for non-tmux sessions
        setopt share_history
    fi
    
    # Common history settings
    setopt extended_history       # Save timestamp and duration
    setopt hist_expire_dups_first # Expire duplicates first
    setopt hist_ignore_dups       # Don't record duplicate commands
    setopt hist_ignore_space      # Don't record commands starting with space
    setopt hist_verify            # Show command before executing from history
    setopt hist_reduce_blanks     # Remove extra blanks from commands
    
    # Increase history sizes
    export HISTSIZE=100000000
    export SAVEHIST=100000000
}

# Function to merge tmux histories into main history
merge_tmux_histories() {
    local main_hist="$HOME/.zsh_history"
    local tmux_hist_dir="$HOME/.zsh_history_tmux"
    local temp_file="$HOME/.zsh_history_merge.tmp"
    local lock_file="$HOME/.zsh_history.lock"
    
    # Use flock for exclusive access during merge
    exec 200>"$lock_file"
    if flock -n 200; then
        # Create backup before merge
        cp "$main_hist" "$main_hist.before_merge_$(date +%Y%m%d_%H%M%S)"
        
        # Collect all tmux history files
        if [[ -d "$tmux_hist_dir" ]]; then
            # Combine all histories, sort by timestamp, remove duplicates
            cat "$main_hist" "$tmux_hist_dir"/*.hist 2>/dev/null | \
                awk -F':' '!seen[$0]++ && NF >= 2' | \
                sort -t ':' -k2 -n > "$temp_file"
            
            # Replace main history with merged version
            if [[ -s "$temp_file" ]]; then
                mv "$temp_file" "$main_hist"
                echo "Merged tmux histories into main history"
                
                # Optional: Clean up old tmux history files
                find "$tmux_hist_dir" -name "*.hist" -mtime +7 -delete
            fi
        fi
        
        # Release lock
        exec 200>&-
    else
        echo "Could not acquire lock for history merge" >&2
        return 1
    fi
}

# Function to protect history with file locking
safe_history_write() {
    local lock_file="$HISTFILE.lock"
    local max_wait=5
    local waited=0
    
    # Try to acquire lock with timeout
    while [[ $waited -lt $max_wait ]]; do
        if mkdir "$lock_file" 2>/dev/null; then
            # Got the lock, write history
            fc -W
            
            # Release lock
            rmdir "$lock_file" 2>/dev/null
            return 0
        else
            # Wait and retry
            sleep 0.1
            waited=$((waited + 1))
        fi
    done
    
    # Timeout reached, force write (risky but better than losing history)
    echo "Warning: Could not acquire history lock, forcing write" >&2
    fc -W
}

# Hook for safe history writes
add-zsh-hook precmd safe_history_write 2>/dev/null || true

# Initialize tmux-aware history
setup_tmux_history

# Alias to manually merge histories
alias zsh-merge-histories='merge_tmux_histories'