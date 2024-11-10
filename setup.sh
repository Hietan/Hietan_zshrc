#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_FILE=".zshrc"
TARGET_PATH="$SCRIPT_DIR/$TARGET_FILE"

ln -sf "$TARGET_PATH" "$HOME/.zshrc"
