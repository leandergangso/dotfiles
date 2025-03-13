# zinit manuall install
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# exports
export EDITOR="$(command -v nvim &>/dev/null && echo nvim || echo vim)"
export WORDCHARS=${WORDCHARS/\/}

# source
source "${ZINIT_HOME}/zinit.zsh"

# plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::gpg-agent
zinit snippet OMZP::ssh-agent
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# completions
autoload -U compinit && compinit
zinit cdreplay -q # recommended by zinit

# zstyles
zstyle ':completion:*' matcher-list "m:{a-z}={A-Za-z}"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# history
HISTSIZE=5000
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
alias work='cd /work && l'
alias gac='git add . && git commit'

alias cat='bat --paging=never'
alias grep='grep --color'
alias tree='tree -C'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias ls='ls --color'
alias l='ls -lah --color'
alias ll='ls -lh --color'
alias la='ls -lAh --color'
alias lsa='ls -lah --color'

# integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.toml)"

