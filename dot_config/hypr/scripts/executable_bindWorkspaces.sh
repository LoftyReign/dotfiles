#!/bin/bash

declare -A MONS
MONS[center]="BNQ BenQ GL2480 ETB3L01311SL0"
MONS[right]="BNQ BenQ GL2480 ET91L00974SL0"
MONS[left]="Samsung Display Corp. 0x4208"

hyprctl keyword workspace "1, monitor:desc:${MONS[right]}"
hyprctl keyword workspace "2, monitor:desc:${MONS[center]}"
hyprctl keyword workspace "3, monitor:desc:${MONS[left]}"

readarray -t monitor_names < <(hyprctl monitors | jq -r '.[].name')
if [[ ${#monitor_names[@]} == 1 ]]; then
    hyprctl keyword workspace "1, monitor:desc:${MONS[left]}"
fi

