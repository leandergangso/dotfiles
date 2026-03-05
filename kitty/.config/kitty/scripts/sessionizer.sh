#!/usr/bin/env bash

SESSION_DIR="$HOME/.config/kitty/sessions"
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
    # Pinned Sessions
    local pinned=""
    if [[ -f "$PINNED_FILE" ]]; then
        pinned=$(cat "$PINNED_FILE")
        sed 's/^/📌 /' "$PINNED_FILE"
    fi

    # Active Sessions
    local active=""
    if [[ -d "$SESSION_DIR" ]]; then
        active=$(
            rg --no-filename --no-line-number --max-count 1 "^cd\s+(.*)" \
                --glob "*.session" --glob "!keep-*" \
                --replace "\$1" "$SESSION_DIR"
        )
        if [[ -n "$active" ]]; then
            echo "$active" | rg -vxFf <(echo -e "$pinned") | sed 's/^/⚡ /' | sort -u
        fi
    fi

    # Potential Sessions
    fd --hidden --type directory --max-depth 4 --glob '.git' "${SEARCH_PATHS[@]}" --exec dirname |
        rg -vxFf <(echo -e "$pinned\n$active") |
        sed 's/^/📁 /' |
        sort -u
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
    path=$(clean_path "$1")
    if rg -qFx "$path" "$PINNED_FILE" 2>/dev/null; then
        local filtered
        filtered=$(rg -vFx "$path" "$PINNED_FILE" | rg -v '^$')
        if [[ -n "$filtered" ]]; then
            printf "%s\n" "$filtered" >"$PINNED_FILE"
        else
            : >"$PINNED_FILE"
        fi
    else
        printf "%s\n" "$path" >>"$PINNED_FILE"
    fi
}

move_pin() {
    local path=$1 direction=$2 pins idx target
    path=$(clean_path "$path")

    # 1. Load ONLY pinned items (removes any accidental blanks)
    mapfile -t pins < <(rg -v '^$' "$PINNED_FILE" 2>/dev/null)

    # 2. Find the index (using a more modern Bash loop)
    idx=-1
    for i in "${!pins[@]}"; do
        if [[ "${pins[i]}" == "$path" ]]; then
            idx=$i
            break
        fi
    done

    # If the path isn't in the pinned file, we stop.
    # This prevents moving "Active" or "Potential" projects.
    [[ $idx -eq -1 ]] && return

    # 3. Calculate target
    if [[ "$direction" == "up" && $idx -gt 0 ]]; then
        target=$((idx - 1))
    elif [[ "$direction" == "down" && $idx -lt $((${#pins[@]} - 1)) ]]; then
        target=$((idx + 1))
    else
        return # Nowhere to move (already at top/bottom)
    fi

    # 4. Swap in the array
    local tmp="${pins[target]}"
    pins[target]="${pins[idx]}"
    pins[idx]="$tmp"

    printf "%s\n" "${pins[@]}" >"$PINNED_FILE"
}

jump_to_pin() {
    local target_path
    target_path=$(sed -n "${1}p" "$PINNED_FILE")
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
