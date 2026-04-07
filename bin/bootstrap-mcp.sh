#!/bin/bash

claude mcp remove everything
claude mcp remove fetch
claude mcp remove filesystem
claude mcp remove git
claude mcp remove memory
claude mcp remove playwright
claude mcp remove sequential-thinking
claude mcp remove marionette

claude mcp add everything npx '@modelcontextprotocol/server-everything'
claude mcp add fetch uvx 'mcp-server-fetch'
claude mcp add filesystem npx '@modelcontextprotocol/server-filesystem'
claude mcp add git uvx 'mcp-server-git'
claude mcp add memory npx '@modelcontextprotocol/server-memory'
claude mcp add playwright npx '@playwright/mcp@latest'
claude mcp add sequential-thinking npx '@modelcontextprotocol/server-sequential-thinking'
claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project "$(pwd)"

# Flutter/Dart
# NOTE: dart mcp-server requires Dart 3.9+ (Flutter 3.33+). Currently on Dart 3.8.1.
# marionette_mcp: runtime interaction with Flutter apps (tap, type, screenshot)
# Requires: dart pub global activate marionette_mcp && flutter pub add marionette_flutter (in extremo/)
claude mcp add --transport stdio marionette -- "$HOME/bin/marionette-mcp-wrapper.sh"
