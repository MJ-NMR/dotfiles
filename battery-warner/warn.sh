#!/bin/bash

while true; do
  battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
  status=$(acpi -b | grep -o 'Charging\|Discharging')

  if [[ "$status" == "Discharging" && "$battery_level" -le 15 ]]; then
    notify-send -u critical "Battery Low" "Battery is at ${battery_level}%!"
	sleep 60
  fi
  sleep 60
done

