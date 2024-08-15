#!/bin/sh

# Download and extract audio
yt-dlp --format "ba" \
  --verbose \
  --force-ipv4 \
  --ignore-errors \
  --no-continue \
  --no-overwrites \
  --add-metadata \
  --parse-metadata "%(title)s:%(title)s" \
  --parse-metadata "%(title)s:%(artist)s" \
  --check-formats \
  --concurrent-fragments 10 \
  --output "%(title)s.%(ext)s" \
  --audio-format opus \
  --audio-quality 160K \
  --throttled-rate 100K \
  --max-filesize 500m \
  --cookies-from-browser firefox \
  --retry 3 \
  $1 \
  --extract-audio \
  --embed-thumbnail \
  --no-warnings
