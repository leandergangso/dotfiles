Z_PLUGIN_DIR="$HOME/.local/share/zsh/plugins"

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
        fpath+=$plugdir
        source $initfile
    done
}

# exports
export EDITOR="$(command -v nvim &>/dev/null && echo nvim || echo vim)"
export WORDCHARS=${WORDCHARS/\/}
export PATH=$PATH:$HOME/go/bin

# plugins
repos=(
  https://github.com/zsh-users/zsh-history-substring-search
  https://github.com/zsh-users/zsh-syntax-highlighting   
  https://github.com/zsh-users/zsh-autosuggestions
  https://github.com/zsh-users/zsh-completions
  https://github.com/Aloxaf/fzf-tab
)
plugin-load $repos

# completions
autoload -U compinit && compinit

# zstyles
zstyle ':completion:*' matcher-list "m:{a-z}={A-Za-z}"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# options
setopt auto_cd
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt pushd_ignore_dups

# keybinds
bindkey -e
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey "^[[1;5D" backward-word # key: ctrl+arrow-left
bindkey "^[[1;5C" forward-word # key: ctrl+arrow-right
bindkey "^[[H" beginning-of-line # key: end
bindkey "^[[F" end-of-line # key: home

# aliases
alias _='sudo'
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

alias ls='ls --color'
alias la='ls -ah --color'
alias ll='ls -lh --color'
alias l='ls -lah --color'

alias gst='git status'
alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gac='git add . && git commit'

# integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/catppuccin-mocha.json)"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
