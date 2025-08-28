#!/usr/bin/env bash

# these two are your gap sizes
DEFAULT_GAP=10
MAX_GAP=5

# where Hyprland publishes events
SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# function to react to events
handle_event() {
    # Get the fullscreen state of the currently active window
    local is_fullscreen
    is_fullscreen=$(hyprctl activeworkspace -j | jq -r ".hasfullscreen")

    if [[ "$is_fullscreen" =~ "true" ]]; then
        # The focused window is fullscreen
        hyprctl keyword general:gaps_out $MAX_GAP
    else
        # The focused window is not fullscreen
        hyprctl keyword general:gaps_out $DEFAULT_GAP
    fi
}

# subscribe to the socket for activewindowv2 and dispatch to handler
socat - UNIX-CONNECT:"$SOCKET" | while read -r ev; do
    case $ev in
    "activewindowv2"*)
        handle_event
        ;;
    "fullscreen>>"*)
        handle_event
        ;;
    *)
        ;;
    esac
done
