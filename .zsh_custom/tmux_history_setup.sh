#!/bin/bash
# Setup script to configure tmux history settings

echo "Setting up tmux-aware ZSH history configuration..."

# Check if in tmux
if [[ -n "$TMUX" ]]; then
    echo "Currently in tmux session"
    
    # Source the new configuration
    source ~/.zsh_history_lock.zsh
    source ~/.zsh_tmux_history.zsh
    
    echo "New history file: $HISTFILE"
    echo "History locking: Enabled"
    echo "Share history: $(setopt | grep -q sharehistory && echo 'Disabled for tmux' || echo 'Already disabled')"
else
    echo "Not in tmux session. Configuration will apply to new tmux sessions."
fi

# Show current settings
echo ""
echo "Current history settings:"
echo "HISTFILE: ${HISTFILE:-$HOME/.zsh_history}"
echo "HISTSIZE: $HISTSIZE"
echo "SAVEHIST: $SAVEHIST"
echo ""
echo "History options:"
setopt | grep -i hist | sort

echo ""
echo "Available commands:"
echo "  zsh-repair-history  - Repair corrupted history file"
echo "  zsh-merge-histories - Merge tmux session histories into main history"
echo ""
echo "To apply to all new shells, restart your terminal or run: source ~/.zshrc"