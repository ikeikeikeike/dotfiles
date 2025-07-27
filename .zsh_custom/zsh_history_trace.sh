#!/bin/bash
# Advanced zsh history monitoring with process tracking

HISTFILE="$HOME/.zsh_history"
TRACELOG="$HOME/.zsh_history_trace.log"
PIDLOG="$HOME/.zsh_history_pids.log"

# Function to get processes accessing the history file
track_access() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Use lsof to find processes accessing the file
    if command -v lsof &>/dev/null; then
        local procs=$(lsof "$HISTFILE" 2>/dev/null)
        if [ -n "$procs" ]; then
            echo "[$timestamp] Processes accessing history file:" >> "$TRACELOG"
            echo "$procs" >> "$TRACELOG"
            echo "---" >> "$TRACELOG"
        fi
    fi
    
    # Track PIDs of all zsh processes
    local zsh_pids=$(pgrep -x zsh)
    echo "[$timestamp] Active zsh PIDs: $zsh_pids" >> "$PIDLOG"
}

# Main monitoring
while true; do
    track_access
    sleep 300  # Check every 5 minutes
done