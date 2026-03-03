#!/usr/bin/env bash

SESSION_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/kitty-sessionizer"
PINNED_FILE="$SESSION_DIR/pinned.list"
SEARCH_PATHS=("/work" "$HOME/dotfiles" "$HOME/.config")
PROG="$0"

mkdir -p "$SESSION_DIR"
touch "$PINNED_FILE"

clean_path() {
    echo "${1#* }"
}

get_session_file() {
    echo "$SESSION_DIR/${1##*/}.session"
}

list_sessions() {
    # 📌
    [[ -s "$PINNED_FILE" ]] && rg -v '^$' "$PINNED_FILE" | sed 's/^/📌 /'

    # ⚡
    local active_paths
    active_paths=$(rg --no-filename -. -o '(?<=^cd )[^\r\n]+' "$SESSION_DIR"/*.session 2>/dev/null | tr -d '"' | tr -d "'" | sort -u)

    if [[ -n "$active_paths" ]]; then
        echo "$active_paths" | rg -v -F -x -f "$PINNED_FILE" 2>/dev/null | sed 's/^/⚡ /'
    fi

    # 📁
    local exclude_file="$SESSION_DIR/.exclude_tmp"
    {
        [[ -s "$PINNED_FILE" ]] && rg -v '^$' "$PINNED_FILE"
        [[ -n "$active_paths" ]] && echo "$active_paths"
    } | sort -u >"$exclude_file"

    fd -H -t d -d 3 '.git$' "${SEARCH_PATHS[@]}" --path-separator / --exec printf "{//}\n" |
        sort -u |
        rg -v -F -x -f "$exclude_file" 2>/dev/null |
        sed 's/^/📁 /'
}

open_session() {
    local input="$1"
    local project_path

    if [[ "$input" == /* ]]; then
        project_path="$input"
    else
        project_path=$(clean_path "$input")
    fi

    [[ -z "$project_path" || ! -d "$project_path" ]] && return

    local session_file
    session_file=$(get_session_file "$project_path")

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
    local project_path
    project_path=$(clean_path "$1")
    local session_file
    session_file=$(get_session_file "$project_path")
    kitten @ action close_session "$session_file" && rm -f "$session_file"
}

toggle_pin() {
    local path
    path=$(clean_path "$1")

    if rg -qFx "$path" "$PINNED_FILE"; then
        local tmp
        tmp=$(rg -vFx "$path" "$PINNED_FILE")
        echo "$tmp" | rg -v '^$' >"$PINNED_FILE"
    else
        echo "$path" >>"$PINNED_FILE"
    fi
}

move_pin() {
    local path
    path=$(clean_path "$1")
    local direction="$2"

    mapfile -t pins < <(rg -v '^$' "$PINNED_FILE")

    local idx=-1
    for i in "${!pins[@]}"; do
        if [[ "${pins[$i]}" == "$path" ]]; then
            idx=$i
            break
        fi
    done

    [[ $idx -eq -1 ]] && return

    if [[ "$direction" == "up" && $idx -gt 0 ]]; then
        local prev=$((idx - 1))
        local tmp="${pins[$prev]}"
        pins[prev]="${pins[$idx]}"
        pins[idx]="$tmp"

    elif [[ "$direction" == "down" && $idx -lt $((${#pins[@]} - 1)) ]]; then
        local next=$((idx + 1))
        local tmp="${pins[$next]}"
        pins[next]="${pins[$idx]}"
        pins[idx]="$tmp"
    fi

    printf "%s\n" "${pins[@]}" | rg -v '^$' >"$PINNED_FILE"
}

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
    target_path=$(rg -v '^$' "$PINNED_FILE" | sed -n "${2}p")
    [[ -n "$target_path" ]] && open_session "$target_path"
    ;;
"ui")
    selected=$(
        "$PROG" list | fzf \
            --ansi \
            --reverse \
            --header "ENTER: Open | CTRL-P: Pin | CTRL-K/J: Move | CTRL-X: Close" \
            --bind "ctrl-p:execute($PROG toggle {})+reload($PROG list)" \
            --bind "ctrl-k:execute($PROG move {} up)+reload($PROG list)+up" \
            --bind "ctrl-j:execute($PROG move {} down)+reload($PROG list)+down" \
            --bind "ctrl-x:execute($PROG close {})+reload($PROG list)"
    )
    [[ -n "$selected" ]] && open_session "$selected"
    ;;
*)
    "$PROG" ui
    ;;
esac
