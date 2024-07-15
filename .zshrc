# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git/ "$ZINIT_HOME"
fi


ZSH_THEME="powerlevel10k/powerlevel10k"
#plugins=(git)

#keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

#paths
PATH=$PATH:$HOME/.cargo/bin
export ZSH="$HOME/.oh-my-zsh"

# evals
eval "$(zoxide init zsh)"
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fdfind --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_CMMAND"
export FZF_ALT_C_COMMAND="fdfind --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
    fdfind --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
    fdfind --type=d --hidden --exclude .git . "$1"
}

source $HOME/.local/bin/fzf-git

#plugins
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git
zinit snippet OMZP::sudo
#zinit snippet OMZP::ubuntu

autoload -Uz compinit && compinit

zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# compleation styling
ZSH_AUTOSUGGEST_HISTORY=(completion)
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=gray,bold"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'


#aliases
alias cd="z"
alias v="nvim"
alias mouse="echo F9:27:93:86:52:6F"
alias headphones="echo AC:80:0A:F8:C9:92"
alias omm="$HOME/go/bin/omm"

# Better LS
alias lss="eza --color --icons --group-directories-first --long --no-time --no-permissions --no-user --no-filesize"
alias l="eza --color --long --icons --all --group-directories-first"
alias ls="eza --color --long --icons --group-directories-first --no-time --no-permissions --no-user --no-filesize --all"
alias lt="eza --color --long --icons --group-directories-first --no-time --no-permissions --no-user --no-filesize --all --tree --level=3"

alias bat="batcat"

[ -f "/home/ben/.ghcup/env" ] && . "/home/ben/.ghcup/env" # ghcup-env
export PATH=$PATH:/home/ben/.spicetify
