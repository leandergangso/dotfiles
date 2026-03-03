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
    # 1. 📌 Pinned
    [[ -s "$PINNED_FILE" ]] && rg -v '^$' "$PINNED_FILE" | sed 's/^/📌 /'

    # 2. ⚡ Active
    local active_paths
    active_paths=$(rg -IN -. -o "^cd\s+['\"]?([^'\"]+)['\"]?" --replace '$1' "$SESSION_DIR"/*.session 2>/dev/null | sed 's#/$##' | sort -u)

    if [[ -n "$active_paths" ]]; then
        if [[ -s "$PINNED_FILE" ]]; then
            echo "$active_paths" | rg -v -F -x -f "$PINNED_FILE" 2>/dev/null | sed 's/^/⚡ /'
        else
            printf '⚡ %s\n' "$active_paths"
        fi
    fi

    # 3. 📁 Potential
    local exclude_patterns
    exclude_patterns=$(
        [[ -s "$PINNED_FILE" ]] && rg -v '^$' "$PINNED_FILE"
        [[ -n "$active_paths" ]] && echo "$active_paths"
    )

    fd -H -t d -d 3 '.git$' "${SEARCH_PATHS[@]}" --path-separator / --exec printf "{//}\n" |
        sed 's#/$##' |
        sort -u |
        rg -v -F -x -f <(echo "$exclude_patterns") 2>/dev/null |
        sed 's/^/📁 /'
}

open_session() {
    local input
    local project_path
    input="$1"

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
    local session_file
    project_path=$(clean_path "$1")
    session_file=$(get_session_file "$project_path")
    kitten @ action close_session "$session_file" && rm -f "$session_file"
}

toggle_pin() {
    local path
    local tmp
    path=$(clean_path "$1")

    if rg -qFx "$path" "$PINNED_FILE"; then
        tmp=$(rg -vFx "$path" "$PINNED_FILE")
        echo "$tmp" | rg -v '^$' >"$PINNED_FILE"
    else
        echo "$path" >>"$PINNED_FILE"
    fi
}

move_pin() {
    local path direction i idx target tmp pins

    # NOTE: bug? can move line down into active sessions, but not other projects...

    path=$(clean_path "$1")
    direction="$2"

    mapfile -t pins < <(rg -v '^$' "$PINNED_FILE")

    idx=-1
    for i in "${!pins[@]}"; do
        if [[ "${pins[i]}" == "$path" ]]; then
            idx=$i
            break
        fi
    done

    [[ idx -eq -1 ]] && return

    target=-1
    if [[ "$direction" == "up" && idx -gt 0 ]]; then
        target=$((idx - 1))
    elif [[ "$direction" == "down" && idx -lt ${#pins[@]}-1 ]]; then
        target=$((idx + 1))
    fi

    if [[ "$target" -ne -1 ]]; then
        tmp="${pins[target]}"
        pins[target]="${pins[idx]}"
        pins[idx]="$tmp"

        printf "%s\n" "${pins[@]}" | rg -v '^$' >"$PINNED_FILE"
    fi
}

jump_to_pin() {
    local index
    local target_path
    index="$1"
    target_path=$(awk "NF { count++; if (count == $index) print }" "$PINNED_FILE")
    [[ -n "$target_path" ]] && open_session "$target_path"
}

run_ui() {
    local selected
    selected=$(
        "$PROG" list | fzf \
            --ansi \
            --reverse \
            --ignore-case \
            --header "ENTER: Open | CTRL-P: Pin | CTRL-K/J: Move | CTRL-X: Close" \
            --bind "ctrl-p:execute($PROG toggle {})+reload($PROG list)" \
            --bind "ctrl-x:execute($PROG close {})+reload($PROG list)" \
            --bind "ctrl-k:execute($PROG move {} up)+reload($PROG list)+up" \
            --bind "ctrl-j:execute($PROG move {} down)+reload($PROG list)+down" \
            --bind "k:up" \
            --bind "j:down"
    )
    [[ -n "$selected" ]] && open_session "$selected"
}

case "$1" in
"list") list_sessions ;;
"close") close_session "$2" ;;
"toggle") toggle_pin "$2" ;;
"move") move_pin "$2" "$3" ;;
"jump") jump_to_pin "$2" ;;
"ui" | *) run_ui ;;
esac
