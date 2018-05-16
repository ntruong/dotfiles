#!/bin/bash

MUSIC_DIR=~/Music/Library

main () {
  # Find the image
  album="$(mpc --format %album% current)"
  file="$(mpc --format %file% current)"
  album_dir="${file%/*}"
  [[ -z "$album_dir" ]] && exit 1
  album_dir="$MUSIC_DIR/$album_dir"
  covers="$(find "$album_dir" -type d -exec find {} -maxdepth 1 -type f \; )"
  covers="$(echo -n "$covers" | grep ".*\(${album}\|cover\|folder\|artwork\|front\).*.\(jpg\|jpeg\|png\)")"
  src="$(echo -n "$covers" | head -n1)"

  # Display it
  if [[ -e "$src" ]]; then
    if pgrep feh; then
      pkill feh
    fi
    feh "$src" --geometry=407x407+80+80 -x -Z &
  fi
}

while true; do
  main > /dev/null
  mpc idle player > /dev/null
done
