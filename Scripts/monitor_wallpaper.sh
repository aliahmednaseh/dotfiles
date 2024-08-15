#!/bin/bash

# Path to the file that stores the current wallpaper
current_wallpaper_file="/tmp/current_wallpaper_path.txt"

# Function to get the current wallpaper path
get_wallpaper_path() {
  swww query | awk -F'currently displaying: image: ' '{print $2}' | head -n 1
}

# Function to refresh feh image viewer
refresh_viewer() {
  # Path to the file storing the current wallpaper path
  local wallpaper_path
  wallpaper_path=$(cat "$current_wallpaper_file")

  # Use `feh` to reload the image
  # Check if `feh` is running and if so, send it a signal to reload
  if pgrep -x "feh" >/dev/null; then
    pkill -USR1 -x "feh"
  else
    # If `feh` is not running, start it with the current wallpaper
    feh --bg-scale "$wallpaper_path" &
  fi
}

# Get the initial wallpaper path
previous_wallpaper=$(get_wallpaper_path)
echo "$previous_wallpaper" >"$current_wallpaper_file"

while true; do
  sleep 5 # Check every 5 seconds (adjust as needed)

  # Get the current wallpaper path
  current_wallpaper=$(get_wallpaper_path)

  # Compare with the previously stored path
  if [[ "$current_wallpaper" != "$previous_wallpaper" ]]; then
    # Update the stored path and refresh the viewer
    echo "$current_wallpaper" >"$current_wallpaper_file"
    refresh_viewer
    previous_wallpaper="$current_wallpaper"
  fi
done
