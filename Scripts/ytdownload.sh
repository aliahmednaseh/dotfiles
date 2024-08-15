#!/bin/bash

# Define the playlist URL
playlist_url='https://youtube.com/playlist?list=PLyhcQ07fSdXGVTfOLIHzRnuh6mHp2mWCd&si=4rltn812wLlNmBKv'

# Define the output directory
output_dir="/mnt/sdb/Music/linux/"

# Define the maximum number of retries
max_retries=3

# Define the command to run yt-dlp
yt_dlp_cmd="yt-dlp -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --ignore-errors --no-post-overwrites -o \"$output_dir%(title)s.%(ext)s\" $playlist_url"

# Function to run yt-dlp with retries
run_with_retries() {
    local retries=0
    while [ $retries -lt $max_retries ]; do
        echo "Attempt $((retries + 1))..."
        eval $yt_dlp_cmd
        if [ $? -eq 0 ]; then
            echo "Download completed successfully."
            return 0
        fi
        echo "Download failed. Retrying..."
        retries=$((retries + 1))
        sleep 5  # Wait for a while before retrying
    done
    echo "Failed after $max_retries attempts."
    return 1
}

# Run the yt-dlp command with retry logic
run_with_retries

