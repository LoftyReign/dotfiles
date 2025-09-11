#!/bin/bash

log () {
    for arg in "$@"
    do
        echo $arg >> $HOME/.config/hypr/scripts/test.log
    done
}

args=("$@")
arg_i=0
mon_start_indexes=()
for arg in "$@"
do
    if [[ $arg == *"monitor:"* ]]; then
        mon_start_indexes+=($arg_i) 
    fi
    ((arg_i++))
done

if [[ ${#mon_start_indexes[*]} > 2 ]]; then
    log "This won't work. More than 2 monitors passed"
fi

mon_1=""
mon_2=""

for ((i=0; i<=${mon_start_indexes[1]}-1; i++)); do
    mon_1+="${args[$i]} "
done

for ((i=${mon_start_indexes[1]};i<=${#args[*]}-1;i++));
do
    mon_2+="${args[$i]} "
done

log "$mon_1"
log "$mon_2"

# echo $(hyprctl monitors) >> $HOME/.config/hypr/test.log

monitor_names=$(hyprctl monitors | grep '^Monitor' | awk '{print $2}')
monitor_desc=$(hyprctl monitors | grep 'description')

log ${monitor_names[*]}
log "${monitor_desc[*]}"
log ${#monitor_desc[*]}



# for name in $monitor_names; do
#     echo "Monitor name: $name" >> $HOME/.config/hypr/test.log
# done
#
# for name in $monitor_desc; do
#     echo "Monitor name: $name" >> $HOME/.config/hypr/test.log
# done

# log ${mon_start_indexes[*]}
# log ${#mon_start_indexes[*]}
# log ${mon_start_indexes[0]}
# log ${mon_start_indexes[1]}
