#!/bin/bash


log () {
    for arg in "$@"
    do
        echo $arg >> $HOME/.config/hypr/scripts/test.log
    done
}

args=("$@")
desc=""
for ((i=0; i<=$#; i++)); do
    desc+="${args[$i]} "
done

log "$desc"


monitor_names=$(hyprctl monitors | grep '^Monitor' | awk '{print $2}')
monitor_desc=$(hyprctl monitors | grep 'description')

log "${monitor_desc[*]}"


input='description: BNQ BenQ GL2480 ETB3L01311SL0 description: BNQ BenQ GL2480 ET91L00974SL0 description: Samsung Display Corp. 0x4208'

# Add newlines before each "description:" and trim leading space
formatted=$(sed 's/description:/\ndescription:/g' <<< "$input" | sed '/^$/d')

# Read into an array
readarray -t descriptions <<< "$formatted"

# Print to verify
# for des in "${descriptions[@]}"; do
#     log "$des"
# done

