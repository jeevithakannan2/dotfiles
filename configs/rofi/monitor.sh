#!/bin/env bash

# This is script is configured to run on single monitor setup only...

# Get all available refresh rates and format them for rofi
modes=$(wlr-randr --dryrun | grep "px" | awk -F 'px' '{print $1 $2}' | sort | uniq)
monitor=$(wlr-randr --dryrun | awk '/^[^ ]/{print $1}' | sort | uniq)

# Use rofi to display the refresh rates
selected_mode=$(echo "$modes" | rofi -dmenu -p "Select Mode: ")
mode=$(echo "$selected_mode" | awk '{print $1}')
rate=$(echo "$selected_mode" | awk '{print $3"Hz"}')

# Check if a rate was selected
if [ -n "$selected_mode" ]; then
  wlr-randr --output $monitor --mode "$mode@$rate"
fi
