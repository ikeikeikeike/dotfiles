#!/bin/bash
# Wrapper for marionette_mcp that resolves dart from the extremo nix flake.
# Reads the nix-direnv cached PATH from the .rc file.

CLAUDE_ROOT="$HOME/src/threecorp/claude"

# Find a direnv flake profile .rc file from extremo project (main or any worktree)
find_dart_path() {
  local rc_file
  for extremo_dir in "$CLAUDE_ROOT/extremo" "$CLAUDE_ROOT"/.worktrees/*/extremo; do
    rc_file=$(ls "$extremo_dir"/.direnv/flake-profile-*.rc 2>/dev/null | head -1)
    if [ -n "$rc_file" ]; then
      # Extract PATH from the rc file and find the dart-containing entry
      local nix_path
      nix_path=$(grep "^PATH=" "$rc_file" | sed "s/^PATH='//" | sed "s/'$//" | tr ':' '\n' | grep "dart" | head -1)
      if [ -n "$nix_path" ]; then
        echo "$nix_path"
        return 0
      fi
    fi
  done
  return 1
}

DART_DIR=$(find_dart_path)
if [ -n "$DART_DIR" ]; then
  export PATH="$DART_DIR:$PATH"
fi

exec "$HOME/.pub-cache/bin/marionette_mcp" "$@"
