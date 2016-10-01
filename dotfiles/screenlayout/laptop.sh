#!/bin/sh
xrandr \
  --output DisplayPort-1 --off \
  --output DisplayPort-0 --off \
  --output eDP --primary --mode 2880x1800 --pos 0x0 --rotate normal \
  --output HDMI-0 --off
