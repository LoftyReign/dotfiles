get_monitor_name_from_desc() {
    local desc="$1"
    hyprctl monitors -j | jq -r --arg desci "$desc" 'map(select(.description == $desci)) | .[].name'
}

echo $(get_monitor_name_from_desc "$1")
