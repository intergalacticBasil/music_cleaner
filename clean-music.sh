#!/bin/bash

# Path to unsorted music
UNSORTED_DIR="$HOME/Music/_unsorted"

# Activate virtual environment
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/venv/bin/activate"

echo "Cleaning and organizing music with beets..."
beet import -mq "$UNSORTED_DIR"

echo "Music cleaning complete!"
deactivate
