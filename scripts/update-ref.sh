#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cp $HOME/.wezterm.lua "$PROJECT_ROOT/wezterm/"
cp -r $HOME/.wezterm/. "$PROJECT_ROOT/wezterm/.wezterm/"
