#!/usr/bin/env zsh
# Custom key bindings for ZSH

# History search with prefix matching
# Ctrl+P: Search backward in history for lines beginning with current line up to cursor
bindkey '^P' history-beginning-search-backward
# Ctrl+N: Search forward in history for lines beginning with current line up to cursor  
bindkey '^N' history-beginning-search-forward

# Alternative: up/down arrows for history search (optional)
# bindkey '^[[A' history-beginning-search-backward
# bindkey '^[[B' history-beginning-search-forward

# Additional useful history bindings
# Ctrl+R: Reverse incremental search (this is usually default)
bindkey '^R' history-incremental-search-backward
# Ctrl+S: Forward incremental search
bindkey '^S' history-incremental-search-forward

# Show all key bindings (for debugging)
# bindkey -L