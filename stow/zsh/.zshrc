# shellcheck disable=SC2034

# init profiling
#zmodload zsh/zprof

# variables
Z_PLUGIN_DIR="$HOME/.local/share/zsh/plugins"
Z_COMP_DUMP="$HOME/.zcompdump"
Z_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

# plugin manager
plugin_load() {
    local repo="$1"
    local name dir file

    name=$(basename "$repo")
    dir="$Z_PLUGIN_DIR/$name"

    if [ ! -d "$dir" ]; then
        echo "Cloning $repo..."
        git clone -q --depth 1 --recursive --shallow-submodules "$repo" "$dir" || return 0
    fi

    fpath=("$dir" "$dir/src" $fpath)

    for file in "$dir/$name.plugin.zsh" "$dir/$name.zsh" "$dir/$name.sh" "$dir/$name.zsh-theme"; do
        if [ -f "$file" ]; then
            . "$file"
            break
        fi
    done
}

# exports
if command -v nvim >/dev/null 2>&1; then
    EDITOR=nvim
else
    EDITOR=vim
fi
export EDITOR
export SUDO_EDITOR="$EDITOR"

export PATH="$HOME/.nix-profile/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export WORDCHARS="${WORDCHARS/\//}"
#export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export TERM="${TERM:-xterm-256color}"
export DEFAULT_SHELL="$SHELL"
export BAT_PAGING=never

# zstyles
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle -e ":completion:*" list-colors "reply=(\${(s.:.)LS_COLORS})"
zstyle ":completion:*" menu no
zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color \$realpath"
zstyle ":fzf-tab:complete:__zoxide_z:*" fzf-preview "ls --color \$realpath"

# completion plugins
plugin_load https://github.com/zsh-users/zsh-completions

# completions
autoload -Uz compinit
if [ -f "$Z_COMP_DUMP" ] && [ "$Z_COMP_DUMP" -nt "$HOME/.zshrc" ]; then
    compinit -C -d "$Z_COMP_DUMP"
else
    compinit -d "$Z_COMP_DUMP"
    touch "$Z_COMP_DUMP"
fi

# interactive plugins
plugin_load https://github.com/Aloxaf/fzf-tab
plugin_load https://github.com/zsh-users/zsh-history-substring-search
plugin_load https://github.com/zsh-users/zsh-autosuggestions

# history
SAVEHIST=100000
HISTSIZE=50000
HISTFILE="$HOME/.zsh_history"

# options
setopt AUTO_CD
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_STORE
setopt PUSHD_IGNORE_DUPS
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP

# keybinds
bindkey -e
bindkey "^y" autosuggest-accept
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey "^[[OA" history-substring-search-up
bindkey "^[[OB" history-substring-search-down
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey " " magic-space

# buffer line in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^x^e" edit-command-line

# aliases
alias fix_history="mv ~/.zsh_history ~/.zsh_history_bad && strings ~/.zsh_history_bad > ~/.zsh_history && rm ~/.zsh_history_bad && fc -R ~/.zsh_history"
alias ssh="TERM=xterm-256color ssh"
alias hist="history -in"
alias cls="clear"
alias vim="nvim"
alias grep="grep --color"
alias tree="tree -C"
alias task="go-task"
alias repos="cd /repos && ll"

alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."
alias -g ......="../../../../.."

alias ls="ls --color --group-directories-first"
alias la="ls -ah --color --group-directories-first"
alias ll="ls -lh --color --group-directories-first"
alias l="ls -lah --color --group-directories-first"

alias gst="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"
alias gac="git add . && git commit"
alias gp="git push"
alias gl="git pull"
alias glo="git log --all --oneline --decorate --graph"

# integrations
if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init --cmd cd zsh)"
fi

if command -v oh-my-posh >/dev/null 2>&1; then
    eval "$(oh-my-posh init zsh --config "$HOME/.config/ohmyposh/catppuccin-mocha.json")"
fi

if command -v go-task >/dev/null 2>&1; then
    TASK_BIN=$(readlink -f "$(command -v go-task)")
    TASK_CACHE="$Z_CACHE_DIR/task-completion.zsh"
    if [ "$TASK_BIN" != "$(cat "$TASK_CACHE.bin" 2>/dev/null)" ]; then
        mkdir -p "$Z_CACHE_DIR"
        go-task --completion zsh > "$TASK_CACHE" && echo "$TASK_BIN" > "$TASK_CACHE.bin"
    fi
    . "$TASK_CACHE"
fi

plugin_load https://github.com/zsh-users/zsh-syntax-highlighting

# run profiling (remember to init zprof when used)
#zprof
