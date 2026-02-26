#!/usr/bin/env bash

PROJECT_ROOTS=("/work")
SESSIONS_DIR="$HOME/.cache/kitty-sessions"
HARPOON_LIST="$SESSIONS_DIR/harpoon.list"
mkdir -p "$SESSIONS_DIR"
touch "$HARPOON_LIST"

get_session_name() {
    echo "$selected" | rev | cut -d '/' -f 1-2 | rev | tr / _
}

get_session_file() {
    local name
    name=$(get_session_name "$1")
    echo "$SESSIONS_DIR/$name.session"
}

ensure_session_template() {
    local path=$1
    local file=$2
    local name
    name=$(get_session_name "$path")
    if [[ ! -f "$file" ]]; then
        cat <<EOF > "$file"
layout tall
cd $selected
launch --hold nvim
new_tab
launch --cwd=current
focus_tab 0
EOF
    fi
}

case $1 in
    --add)
        curr_path=$(pwd)
        # Move to bottom if exists (most recent at bottom)
        sed -i "\|^$curr_path$|d" "$HARPOON_LIST"
        echo "$curr_path" >> "$HARPOON_LIST"
        # Keep only the last 4 for Harpoon slots
        tail -n 4 "$HARPOON_LIST" > "$HARPOON_LIST.tmp" && mv "$HARPOON_LIST.tmp" "$HARPOON_LIST"
        notify-send "󰀱 Kitty Harpoon" "Marked $(basename "$curr_path")"
        ;;

    --nav)
        # sed -n "${2}p" gets the Nth line
        target=$(sed -n "${2}p" "$HARPOON_LIST")
        if [[ -z "$target" ]]; then
            exec "$0" # Fallback to fzf picker
        else
            session_file=$(get_session_file "$target")
            ensure_session_template "$target" "$session_file"
            kitty @ action goto_session "$session_file"
        fi
        ;;

    --list)
        # Manage Harpoon list: Enter to Jump, Alt+d to Remove
        selected=$(cat "$HARPOON_LIST" | nl -w2 -s'. ' | \
            fzf --reverse --height 40% --prompt '󰀱 Harpoon Slots: ' \
            --header 'Enter: Jump | Alt-D: Remove' \
            --expect=alt-d \
            --bind 'alt-d:execute(sed -i "{n}d" '"$HARPOON_LIST"')+reload(cat '"$HARPOON_LIST"' | nl -w2 -s". ")')
        
        if [[ -z $selected ]]; then
            kitty @ close-window
            exit 0
        fi
        
        # Clean the "1. " prefix to get the path
        path=$(echo "$selected" | cut -d ' ' -f 2)
        session_file=$(get_session_file "$path")
        ensure_session_template "$path" "$session_file"
        kitty @ action goto_session "$session_file"
        ;;

    *)
        # The main fzf interface
        # Includes a header showing your current Harpoon slots
        header_info=$(cat "$HARPOON_LIST" | rev | cut -d '/' -f 1 | rev | tr '\n' ' ' | sed 's/ $//')

        selected=$(fd --hidden --max-depth=5 --type=directory '^.git$' "${PROJECT_ROOTS[@]}" -x echo "{//}" | \
            fzf --reverse --height 40% --prompt '󱂬 Project: ' --header "󰀱 Harpoon: [ $header_info ]")

        if [[ -z $selected ]]; then
            kitty @ close-window
            exit 0
        fi

        session_file=$(get_session_file "$selected")
        ensure_session_template "$selected" "$session_file"
        kitty @ action goto_session "$session_file"
        ;;
esac

# -------------------

#selected=$(fd --hidden --max-depth=5 --type=directory '.git$' "${PROJECT_ROOTS[@]}" | \
#    fzf --reverse --prompt '󱂬 Session: ' --header 'Jump to project')
#
#if [[ -z $selected ]]; then
#    kitty @ close-window
#    exit 0
#fi
#
##session_name=$(basename "$selected")
#session_name=$(echo "$selected" | rev | cut -d '/' -f 1-2 | rev | tr / _)
#session_file="$SESSIONS_DIR/$session_name.session"
#
#if [[ ! -f "$session_file" ]]; then
#    cat <<EOF > "$session_file"
#layout tall
#cd $selected
#launch --hold nvim .
#new_tab
#launch
#focus_tab 0
#EOF
#fi
#
#kitty @ action goto_session "$session_file"
