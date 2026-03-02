#!/usr/bin/env bash

SESSION_DIR="$HOME/.cache/kitty-sessions"
PINNED_FILE="$SESSION_DIR/pinned.list"
SEARCH_PATHS=("/work" "$HOME/dotfiles" "$HOME/.config")

mkdir -p "$SESSION_DIR"
touch "$PINNED_FILE"

get_project_name() {
    local base
    base=$(basename "$1")
    echo "$base" | sed -E 's/[-_]/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1'
}

get_active_paths() {
    # 1. Get all OS windows
    # 2. Filter for those that have a --session argument
    # 3. Extract the session file path
    # 4. Use grep to pull the 'cd' line from that session file
    kitten @ ls | jq -r '.[].tabs[].windows[].cmdline | select(. != null) | .[index("--session") + 1] // empty' 2>/dev/null |
        while read -r session_file; do
            if [ -f "$session_file" ]; then
                grep -oP '(?<=cd ).*' "$session_file"
            fi
        done | sort -u
}

list_sessions() {
    local active_list
    active_list=$(get_active_paths)

    # Pinned (📌)
    while IFS= read -r line; do
        [[ -n "$line" ]] && echo "📌 $line"
    done <"$PINNED_FILE"

    # Active but not pinned (⚡)
    echo "$active_list" | while read -r dir; do
        [[ -z "$dir" ]] && continue
        if ! grep -qFx "$dir" "$PINNED_FILE"; then
            echo "⚡ $dir"
        fi
    done

    # Rest of projects (📁)
    fd -H -t d -d 3 '.git$' "${SEARCH_PATHS[@]}" | xargs -I {} dirname {} | sort -u | while read -r dir; do
        if ! grep -qFx "$dir" "$PINNED_FILE" && ! echo "$active_list" | grep -qFx "$dir"; then
            echo "📁 $dir"
        fi
    done
}

open_session() {
    local project_path="$1"
    [[ -z "$project_path" ]] && return

    local session_file
    session_file="$SESSION_DIR/$(basename "$project_path").session"

    # Create session file on the fly if missing
    if [[ ! -f "$session_file" ]]; then
        cat <<EOF >"$session_file"
layout tall
cd $project_path
launch --hold nvim
new_tab
cd $project_path
launch
focus_tab 0
EOF
    fi

    kitten @ action goto_session "$session_file"
}

close_session() {
    kitten @ action close_session "$1.session"
}

toggle_pin() {
    local path="$1"
    if grep -qFx "$path" "$PINNED_FILE"; then
        grep -vFx "$path" "$PINNED_FILE" >"$PINNED_FILE.tmp" && mv "$PINNED_FILE.tmp" "$PINNED_FILE"
    else
        echo "$path" >>"$PINNED_FILE"
    fi
}

move_pin() {
    local path="$1"
    local direction="$2"
    local line_num
    line_num=$(grep -nFx "$path" "$PINNED_FILE" | cut -d: -f1)
    [[ -z "$line_num" ]] && return

    if [[ "$direction" == "up" && "$line_num" -gt 1 ]]; then
        local target=$((line_num - 1))
        sed -i "${target}{h;d;}; ${line_num}{G;}" "$PINNED_FILE"

    elif [[ "$direction" == "down" ]]; then
        local total
        total=$(wc -l <"$PINNED_FILE")
        if [[ "$line_num" -lt "$total" ]]; then
            local target=$((line_num + 1))
            sed -i "${line_num}{h;d;}; ${target}{G;}" "$PINNED_FILE"
        fi
    fi
}

prog="$0"

case "$1" in
"list")
    list_sessions
    ;;
"close")
    close_session "$2"
    ;;
"toggle")
    toggle_pin "$2"
    ;;
"move")
    move_pin "$2" "$3"
    ;;
"jump")
    target_path=$(sed -n "${2}p" "$PINNED_FILE")
    [ -n "$target_path" ] && open_session "$target_path"
    ;;
"ui")
    selected=$(
        "$prog" list | fzf \
            --header "ENTER: Open | CTRL-P: Pin | CTRL-K/J: Move | CTRL-X: Close" \
            --ansi \
            --reverse \
            --delimiter " " \
            --bind "ctrl-p:execute($prog toggle {2})+reload($prog list)" \
            --bind "ctrl-k:execute($prog move {2} up)+reload($prog list)" \
            --bind "ctrl-j:execute($prog move {2} down)+reload($prog list)" \
            --bind "ctrl-x:execute($prog close {2})" \
    )
        [[ -n "$selected" ]] && open_session "${selected#* }"
    ;;
*)
    "$prog" ui
    ;;
esac
