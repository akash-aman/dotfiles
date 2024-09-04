export TERMINAL=alacritty
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


#*****************************************
# Zsh Configuration
#*****************************************
# https://www.youtube.com/watch?v=ud7YxC33Z3w&t=594s
#*****************************************

#-----------------------------------------
# Install/Load zinit plugin manager 
#-----------------------------------------
# https://github.com/zdharma-continuum/zinit
#-----------------------------------------

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"


#-----------------------------------------
# add starship prompt
#-----------------------------------------
# prereq: https://github.com/starship/starship
#-----------------------------------------

#eval "$(starship init zsh)"

#-----------------------------------------
# Load zinit
#-----------------------------------------
source "${ZINIT_HOME}/zinit.zsh"

#-----------------------------------------
# Add Powerlevel10k prompt
#-----------------------------------------
zinit ice depth=1; zinit light romkatv/powerlevel10k

#-----------------------------------------
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#-----------------------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


#-----------------------------------------
# Add plugin
#-----------------------------------------
#zinit light zsh-users/zsh-syntax-highlighting
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab


#-----------------------------------------
# Add Snippets
#-----------------------------------------
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found


#-----------------------------------------
# Load completions
#-----------------------------------------
autoload -U compinit && compinit

zinit cdreplay -q
#-----------------------------------------
# key bindings
#-----------------------------------------
bindkey -e


#-----------------------------------------
# History Size
#-----------------------------------------
HISTSIZE=10000
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

#-----------------------------------------
# Completions style
#-----------------------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


#-----------------------------------------
# shell integration
#-----------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

#-----------------------------------------
# Aliases
#-----------------------------------------
alias ls='ls --color=auto'
alias ll='ls -alh'
alias la='ls -ah'

#-----------------------------------------
# Personal Tweaks
#-----------------------------------------
# Move to the parent folder.
alias ..='cd ..'

# Move up two parent folders.
alias ...='cd ../..'

# Move up three parent folders.
alias ....='cd ../../..'

alias c='clear'

# Press h to view the bash history.
alias h='history'

# Display the directory structure better.
alias tree='tree --dirsfirst -F'

# Make a directory and all parent directories with verbosity.
alias mkdir='mkdir -p -v'


function hg() {
    history | grep "$1";
}



#----------Quadcast Mic Alias----------------------#
alias qc="sudo quadcastrgb -a cycle"

#----------------- NVM ----------------------------#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#-----------------PHPCS / PHPCBF ------------------#
export PATH=$PATH:/home/chief/.config/composer/vendor/bin/phpcbf
export PATH=$PATH:/home/chief/.config/composer/vendor/bin/phpcs
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/.bun/bin/bun

WPCS="/home/chief/phpcs-standards/phpcs.xml"

function cs {
    if [ -z "$1" ]; then
        Path="./"
    else
        Path=$1
    fi

    /home/chief/.config/composer/vendor/bin/phpcs --standard="$WPCS" "$Path"; 
}

function cf {
    if [ -z "$1" ]; then
        Path="./"
    else
        Path=$1
    fi

    /home/chief/.config/composer/vendor/bin/phpcbf --standard="$WPCS" "$Path"; 
}

# pnpm
export PNPM_HOME="/home/chief/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
export PATH="/usr/bin/flutter/bin:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin

# bun completions
[ -s "/home/chief/.bun/_bun" ] && source "/home/chief/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export ZSHRC=$HOME/.zshrc