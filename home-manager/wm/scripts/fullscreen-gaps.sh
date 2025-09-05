#!/usr/bin/env bash

DEFAULT_GAP=10
MAX_GAP=5

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

handle_event() {
    local is_fullscreen
    is_fullscreen=$(hyprctl activeworkspace -j | jq -r ".hasfullscreen")

    if [[ "$is_fullscreen" =~ "true" ]]; then
        hyprctl keyword general:gaps_out $MAX_GAP
    else
        hyprctl keyword general:gaps_out $DEFAULT_GAP
    fi
}

# subscribe to the socket, and update gap size if relevant event is dispatched
socat - UNIX-CONNECT:"$SOCKET" | while read -r ev; do
    case $ev in
    "activewindowv2>>"*)
        handle_event
        ;;
    "fullscreen>>"*)
        handle_event
        ;;
    *)
        ;;
    esac
done
