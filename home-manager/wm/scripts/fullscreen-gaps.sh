#!/usr/bin/env bash

# these two are your gap sizes
DEFAULT_GAP=10
MAX_GAP=5

# where Hyprland publishes events
SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# function to react to events
handle_event() {
  line="$1"
  if [[ "$line" =~ "fullscreen>>1" ]]; then
    hyprctl keyword general:gaps_out $MAX_GAP
  elif [[ "$line" =~ "fullscreen>>0" ]]; then
    hyprctl keyword general:gaps_out $DEFAULT_GAP
  fi
}

# subscribe to the socket and dispatch each line
socat - UNIX-CONNECT:"$SOCKET" | while read -r ev; do
  handle_event "$ev"
done

