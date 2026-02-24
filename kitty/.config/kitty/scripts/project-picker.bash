#!/usr/bin/env bash

# 1. Define your project roots, separated by a space ' '
PROJECT_DIRS=("/work/projects" "/work/clients/")

# 2. Select the project directory to start session
SELECTED_DIR=$(find "${PROJECT_DIRS[@]}" -maxdepth 1 -type d 2>/dev/null | fzf --reverse --header="Select project: ")
[ -z "$SELECTED_DIR" ] && exit

# 3. Select session template to use
SESSION_TYPE=$(printf "Default\nCode\nLogs\nEmpty" | fzf --reverse --header="Select session type: ")

# 4. Create a temporary session file based on selection
TEMP_SESSION=$(mktemp)

case $SESSION_TYPE in
    "Coding")
        cat <<EOF > "$TEMP_SESSION"
layout tall
cd $SELECTED_DIR
launch nvim .
launch zsh
new_tab logs
cd $SELECTED_DIR
launch tail -f /var/log/syslog
EOF
        ;;

    "Monitoring")
        cat <<EOF > "$TEMP_SESSION"
layout grid
cd $SELECTED_DIR
launch htop
launch btm
launch watch -n 1 ls -R
EOF
        ;;

    *) 
        cat <<EOF > "$TEMP_SESSION"
layout tall
cd $SELECTED_DIR
launch zsh
launch btop
EOF
        ;;
esac

TITLE="$(basename "$SELECTED_DIR")"

# 5. Launch the dynamic session in a new OS Window
kitty --session "$TEMP_SESSION" --detach --title="$TITLE"

# 6. Focus on newly created session
sleep 0.5
kitty @ focus-window --match title:"$TITLE"

# 7. Cleanup
rm "$TEMP_SESSION"
