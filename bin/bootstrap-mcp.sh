#!/bin/bash

claude mcp remove everything
claude mcp remove fetch
claude mcp remove filesystem
claude mcp remove git
claude mcp remove memory
claude mcp remove playwright
claude mcp remove sequential-thinking

claude mcp add everything npx '@modelcontextprotocol/server-everything'
claude mcp add fetch uvx 'mcp-server-fetch'
claude mcp add filesystem npx '@modelcontextprotocol/server-filesystem'
claude mcp add git uvx 'mcp-server-git'
claude mcp add memory npx '@modelcontextprotocol/server-memory'
claude mcp add playwright npx '@playwright/mcp@latest'
claude mcp add sequential-thinking npx '@modelcontextprotocol/server-sequential-thinking'
claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project "$(pwd)"


