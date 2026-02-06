# init profiling
#zmodload zsh/zprof

# variables
Z_PLUGIN_DIR="$HOME/.local/share/zsh/plugins"
Z_COMP_DUMP="$HOME/.zcompdump"

# simple plugin manager
function plugin-load {
    local repo plugdir initfile initfiles=()
    for repo in $@; do
        plugdir=$Z_PLUGIN_DIR/${repo:t}
        initfile=$plugdir/${repo:t}.plugin.zsh
        if [[ ! -d $plugdir ]]; then
            echo "Cloning $repo..."
            git clone -q --depth 1 --recursive --shallow-submodules $repo $plugdir
        fi
        if [[ ! -e $initfile ]]; then
            initfiles=($plugdir/*.{plugin.zsh,zsh-theme,zsh,sh}(N))
            (( $#initfiles )) || { echo >&2 "No init file found '$repo'." && continue }
            ln -sf $initfiles[1] $initfile
        fi
        fpath+=("$plugdir")
        source "$initfile"
    done
}

# exports
export EDITOR="$(command -v nvim &>/dev/null && echo nvim || echo vim)"
export WORDCHARS=${WORDCHARS/\/}
export GOPRIVATE=github.com/leandergangso
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.local/share/gem/ruby/3.4.0/bin

# zstyles
zstyle ':completion:*' matcher-list "m:{a-z}={A-Za-z}"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# plugins
repos=(
    https://github.com/Aloxaf/fzf-tab
    https://github.com/zsh-users/zsh-syntax-highlighting
    https://github.com/zsh-users/zsh-history-substring-search
    https://github.com/zsh-users/zsh-autosuggestions
    https://github.com/zsh-users/zsh-completions
)
plugin-load "${repos[@]}"

# completions
autoload -Uz compinit
compinit -d "$Z_COMP_DUMP"
{
    if [[ -s "$Z_COMP_DUMP" && (! -s "${Z_COMP_DUMP}.zwc" || "$Z_COMP_DUMP" -nt "${Z_COMP_DUMP}.zwc") ]]; then
        zcompile "$Z_COMP_DUMP"
    fi
} &!

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
#setopt HIST_VERIFY
setopt PUSHD_IGNORE_DUPS
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY_TIME

# keybinds
bindkey -e
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[[1;5D" backward-word # key: ctrl+arrow-left
bindkey "^[[1;5C" forward-word # key: ctrl+arrow-right
bindkey "^[[H" beginning-of-line # key: end
bindkey "^[[F" end-of-line # key: home
bindkey " " magic-space

# buffer line in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# aliases
alias fix_history='mv ~/.zsh_history ~/.zsh_history_bad && strings ~/.zsh_history_bad > ~/.zsh_history && rm ~/.zsh_history_bad && fc -R ~/.zsh_history'
alias hist='history -i'
alias cls='clear'
alias vim='nvim'
alias cat='bat --paging=never'
alias grep='grep --color'
alias tree='tree -C'
alias work='cd /work && ll'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias ls='ls --color --group-directories-first'
alias la='ls -ah --color --group-directories-first'
alias ll='ls -lh --color --group-directories-first'
alias l='ls -lah --color --group-directories-first'

alias gst='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gac='git add . && git commit'
alias gp='git push'
alias gl='git pull'
alias glo='git log --all --oneline --decorate --graph'

alias bruno='flatpak run com.usebruno.Bruno'

# integrations
eval "$(fzf --zsh)"
eval "$(task --completion zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/catppuccin-mocha.json)"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# run profiling (remember to init zprof when used)
#zprof
