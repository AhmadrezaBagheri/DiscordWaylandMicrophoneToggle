#!/bin/bash

# In The Name of ALLAH
# Script for System Global shortcut to mute/unmute microphone when using discord on wayland.

# Method 1: Toggle System Microphone.
# Use If Noise Suppression Enabled
var="$(pactl get-source-mute 0)"
if [[ $var =~ "Mute: yes" ]]; then
  pactl set-source-mute 0 0 # Unmute PulseAudio Microphone.
  notify-send -e -i audio-input-microphone PulseAudio 'Microphone Unmuted!'
  paplay /usr/share/sounds/freedesktop/stereo/device-added.oga
else
  pactl set-source-mute 0 1 # Mute PulseAudio Microphone.
  notify-send -e -i microphone-disabled PulseAudio 'Microphone Muted!'
  paplay /usr/share/sounds/freedesktop/stereo/device-removed.oga
fi

# # Method 2: Toggle Discord Microphone.
# # Use if better-discord and wayland-discord-push-to-talk installed
# # https://github.com/BetterDiscord/BetterDiscord
# # https://github.com/stanley2058/wayland-discord-push-to-talk
#
# LOCKFILE=/tmp/discordismute_forpptserver.lock
# if [[ -f "$LOCKFILE" ]]; then
#   curl localhost:3030/start
#   notify-send -e -i discord Discord 'Microphone Unmuted.'
#   rm -f $LOCKFILE
# else
#   curl localhost:3030/stop
#   notify-send -e -i discord Discord 'Microphone Muted!'
#   touch $LOCKFILE
# fi

# # Method 3: Toggle Discord and System Microphone.
# # Use if better-discord and wayland-discord-push-to-talk installed
# # https://github.com/BetterDiscord/BetterDiscord
# # https://github.com/stanley2058/wayland-discord-push-to-talk
#
# var="$(pactl get-source-mute 0)"
# if [[ $var =~ "Mute: yes" ]]; then
#   nid="$(notify-send -p -i discord -e Discord 'Unmuting Microphone ...')"
#   pactl set-source-mute 0 0 # Unmute PulseAudio Microphone.
#   sleep 1 # Prevent the sound of the pipewire mute/unmute from being heard by others.
#   curl localhost:3030/start
#   notify-send -r "$nid" -i discord -e Discord 'Microphone Unmuted.'
# else
#   nid="$(notify-send -p -i discord -e Discord 'Muting Microphone ...')"
#   curl localhost:3030/stop
#   sleep 1 # Prevent the sound of the pipewire mute/unmute from being heard by others.
#   pactl set-source-mute 0 1 # Mute PulseAudio Microphone.
#   notify-send -r "$nid" -i discord -e Discord 'Microphone Muted!'
# fi

# Exit Current Terminal After Running This Script
kill -9 $PPID
