#!/usr/bin/env zsh
# ZSH History Debug and Protection

# Function to check history file size
check_history_size() {
  local hist_file="${HISTFILE:-$HOME/.zsh_history}"
  local current_size=$(wc -l < "$hist_file" 2>/dev/null || echo 0)
  local backup_dir="$HOME/.zsh_history_backups"
  
  # Create backup directory if it doesn't exist
  [[ ! -d "$backup_dir" ]] && mkdir -p "$backup_dir"
  
  # If history file is suspiciously small (less than 1000 lines)
  if [[ $current_size -lt 1000 ]] && [[ -f "$hist_file" ]]; then
    echo "WARNING: ZSH history file has only $current_size lines!"
    
    # Look for the most recent backup
    local latest_backup=$(ls -t "$backup_dir"/*.zsh_history.* 2>/dev/null | head -1)
    if [[ -n "$latest_backup" ]]; then
      local backup_size=$(wc -l < "$latest_backup")
      echo "Found backup with $backup_size lines: $latest_backup"
      
      # If backup is significantly larger, offer to restore
      if [[ $backup_size -gt $((current_size * 2)) ]]; then
        echo "Backup is significantly larger. Consider restoring:"
        echo "  cp '$latest_backup' '$hist_file'"
      fi
    fi
  fi
  
  # Log current history size
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] History size: $current_size lines" >> "$HOME/.zsh_history_size.log"
}

# Function to backup history periodically
backup_history() {
  local hist_file="${HISTFILE:-$HOME/.zsh_history}"
  local backup_dir="$HOME/.zsh_history_backups"
  local backup_file="$backup_dir/$(date '+%Y%m%d_%H%M%S').zsh_history.bak"
  
  if [[ -f "$hist_file" ]]; then
    cp "$hist_file" "$backup_file" 2>/dev/null
    
    # Keep only last 10 backups
    ls -t "$backup_dir"/*.zsh_history.* 2>/dev/null | tail -n +11 | xargs rm -f 2>/dev/null
  fi
}

# Check on shell startup
check_history_size

# Create automatic backup every 4 hours
if [[ ! -f "$HOME/.zsh_last_backup" ]] || [[ $(find "$HOME/.zsh_last_backup" -mmin +240 2>/dev/null) ]]; then
  backup_history
  touch "$HOME/.zsh_last_backup"
fi