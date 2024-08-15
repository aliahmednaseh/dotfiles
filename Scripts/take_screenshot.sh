#!/bin/bash
# Create a directory if it doesn't exist
mkdir -p "$HOME/Pictures"

# Generate a timestamped filename
DATE=$(date +%Y-%m-%d_%H-%M-%S)
FILE="$HOME/Pictures/screenshot_$DATE.png"

# Capture screenshot with grim and save to file
grim -g "$(slurp)" "$FILE"

# Check if the file was created
if [ -f "$FILE" ]; then
  # Copy the screenshot to clipboard using wl-copy
  wl-copy <"$FILE"
  echo "Screenshot saved to $FILE"
  echo "Screenshot copied to clipboard"
else
  echo "Failed to save screenshot"
fi
