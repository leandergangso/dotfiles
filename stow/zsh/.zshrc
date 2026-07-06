# shellcheck disable=SC2034

# init profiling
#zmodload zsh/zprof

# variables
Z_PLUGIN_DIR="$HOME/.local/share/zsh/plugins"
Z_COMP_DUMP="$HOME/.zcompdump"

# plugin manager
function plugin-load {
    local repo name plugdir candidate
    local -a candidates
    for repo in "$@"; do
        name=${repo:t:r}
        plugdir=$Z_PLUGIN_DIR/$name
        candidates=(
            "$plugdir/$name.plugin.zsh"
            "$plugdir/$name.zsh"
            "$plugdir/$name.sh"
            "$plugdir/$name.zsh-theme"
        )
        if [[ ! -d $plugdir ]]; then
            echo "Cloning $repo..."
            git clone -q --depth 1 --recursive --shallow-submodules "$repo" "$plugdir" || continue
        fi

        fpath=("$plugdir" "${fpath[@]}")
        [[ -d "$plugdir/src" ]] && fpath=("$plugdir/src" "${fpath[@]}")

        for candidate in "${candidates[@]}"; do
            [[ -r $candidate ]] || continue
            builtin source "$candidate"
            break
        done
    done
}

# exports
if command -v nvim >/dev/null; then
    export EDITOR="nvim"
else
    export EDITOR="vim"
fi
export WORDCHARS="${WORDCHARS/\/}"
export TERM="xterm-256color"
export PATH="$HOME/.nix-profile/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.cargo/bin"
#export PATH="$PATH:$HOME/.local/share/gem/ruby/3.4.0/bin"

# zstyles
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle -e ":completion:*" list-colors "reply=(\${(s.:.)LS_COLORS})"
zstyle ":completion:*" menu no
zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color \$realpath"
zstyle ":fzf-tab:complete:__zoxide_z:*" fzf-preview "ls --color \$realpath"

# completion plugins
completion_repos=(
    https://github.com/zsh-users/zsh-completions
)
plugin-load "${completion_repos[@]}"

# completions
autoload -Uz compinit
compinit -d "$Z_COMP_DUMP"
{
    if [[ -s "$Z_COMP_DUMP" && (! -s "${Z_COMP_DUMP}.zwc" || "$Z_COMP_DUMP" -nt "${Z_COMP_DUMP}.zwc") ]]; then
        zcompile "$Z_COMP_DUMP"
    fi
}

# interactive plugins
repos=(
    https://github.com/Aloxaf/fzf-tab
    https://github.com/zsh-users/zsh-history-substring-search
    https://github.com/zsh-users/zsh-autosuggestions
    https://github.com/zsh-users/zsh-syntax-highlighting
)
plugin-load "${repos[@]}"

# history
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=100000

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

# keybinds
bindkey -e
bindkey "^y" autosuggest-accept
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey "^[[1;5D" backward-word # key: ctrl+arrow-left
bindkey "^[[1;5C" forward-word # key: ctrl+arrow-right
bindkey "^[[H" beginning-of-line # key: end
bindkey "^[[F" end-of-line # key: home
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
alias cat="bat --paging=never"
alias grep="grep --color"
alias tree="tree -C"
alias work="cd /work && ll"

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
command -v fzf >/dev/null && eval "$(fzf --zsh)"
command -v task >/dev/null && eval "$(task --completion zsh)"
command -v zoxide >/dev/null && eval "$(zoxide init --cmd cd zsh)"
command -v oh-my-posh >/dev/null && eval "$(oh-my-posh init zsh --config "$HOME/.config/ohmyposh/catppuccin-mocha.json")"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

# run profiling (remember to init zprof when used)
#zprof
