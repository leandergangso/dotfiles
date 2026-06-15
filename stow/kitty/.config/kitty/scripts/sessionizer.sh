#!/usr/bin/env bash

SESSION_DIR="$HOME/.config/kitty/sessions"
SEARCH_PATHS=("/work" "$HOME/dotfiles")

PROJECTS=()

session_name() {
    local project=$1
    local name path_id

    name=${project##*/}
    path_id=$(printf "%s" "$project" | sha256sum | cut -c1-8)
    printf "%s-%s\n" "$name" "$path_id"
}

load_projects() {
    mapfile -t PROJECTS < <(
        fd --hidden --type directory --max-depth 4 --glob .git "${SEARCH_PATHS[@]}" --exec dirname
    )
}

active_projects() {
    local session name project
    local -A seen=()

    kitten @ ls 2>/dev/null |
        jq -r '.[].tabs[].windows[].session_name // empty' |
        while IFS= read -r session; do
            if [[ -z "$session" || -n "${seen[$session]:-}" ]]; then
                continue
            fi
            seen[$session]=1

            name=${session%-*}

            for project in "${PROJECTS[@]}"; do
                if [[ "${project##*/}" != "$name" ]]; then
                    continue
                fi

                if [[ "$(session_name "$project")" == "$session" ]]; then
                    printf "%s\n" "$project"
                    break
                fi
            done
        done
}

open_project() {
    local project=$1
    local session_file

    session_file="$SESSION_DIR/$(session_name "$project").session"

    if [[ ! -f "$session_file" ]]; then
        cat <<EOF >"$session_file"
layout tall

cd $project
launch

focus_tab 0
EOF
    fi

    kitten @ action goto_session "$session_file"
}

jump_to_project() {
    local number=$1
    local project

    project=$(active_projects | sed -n "${number}p")
    if [[ -n "$project" ]]; then
        open_project "$project"
    fi
}

list_projects() {
    local project
    local active=()
    local -A is_active=()

    mapfile -t active < <(active_projects)

    for project in "${active[@]}"; do
        is_active[$project]=1
        printf '⚡ %s\n' "$project"
    done

    for project in "${PROJECTS[@]}"; do
        if [[ -z "${is_active[$project]:-}" ]]; then
            printf '📁 %s\n' "$project"
        fi
    done
}

run_ui() {
    local selected

    selected=$(
        list_projects |
            fzf \
                --ansi \
                --reverse \
                --ignore-case \
                --header "ENTER: Open | CTRL-J/K: Navigate" \
                --bind "ctrl-k:up" \
                --bind "ctrl-j:down"
    )

    if [[ -n "$selected" ]]; then
        open_project "${selected#* }"
    fi
}

main() {
    load_projects

    case "${1:-ui}" in
    ui) run_ui ;;
    jump) jump_to_project "${2:-}" ;;
    *) return 1 ;;
    esac
}

main "$@"
