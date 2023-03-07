. ~/.nix-profile/etc/profile.d/nix.sh
neofetch
# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt adam1

# keyboard scroll speed
xset r rate 300 50

#enable glob syntax
setopt extended_glob

# Enable colors 
autoload -U colors && colors

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lh' 
alias hello='echo hello'
alias v='nvim'
alias vi='nvim'
alias g='git'
alias ip='ip --color=auto'

# git
# autoload -Uz vcs_info
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# setopt prompt_subst
# RPROMPT='${vcs_info_msg_0_}'
# #PROMPT='${vcs_info_msg_0_}%# '
# zstyle ':vcs_info:git:*' formats '%b'

#PS1='%n@%m %~$ '
#PS1=$'\e[0;31m$ \e[0m'
PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

#vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Use modern completion system
autoload -Uz compinit
compinit
#
#zstyle ':completion:*' auto-description 'specify: %d'
#zstyle ':completion:*' completer _expand _complete _correct _approximate
#zstyle ':completion:*' format 'Completing %d'
#zstyle ':completion:*' group-name ''
#zstyle ':completion:*' menu select=2
#eval "$(dircolors -b)"
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
#zstyle ':completion:*' menu select=long
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
#zstyle ':completion:*' use-compctl false
#zstyle ':completion:*' verbose true
##
#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
#zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
#zle -N zle-line-init
#echo -ne '\e[5 q' # Use beam shape cursor on startup.
#preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


_fix_cursor() {
   echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor)

source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/.zsh/plugins/formarks/formarks.plugin.zsh
source ~/.zsh/plugins/agkozak-zsh-prompt/agkozak-zsh-prompt.plugin.zsh



export PATH=~/.local/bin:"$PATH"
export TERM=screen-256color
