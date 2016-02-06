#  ________   ________   ___  ___     
# |\_____  \ |\   ____\ |\  \|\  \    
#  \|___/  /|\ \  \___|_\ \  \\\  \   
#      /  / / \ \_____  \\ \   __  \  
#     /  /_/__ \|____|\  \\ \  \ \  \ 
#    |\________\ ____\_\  \\ \__\ \__\
#     \|_______||\_________\\|__|\|__|
#               \|_________|          
#
#			-- Rahul Parhi

## MAIN {{{
                       
# auto completion
autoload -U compinit && compinit

# enable colors
autoload -U colors && colors

# prompts
#PROMPT="
#%{$fg_bold[black]%}  ───  "
PROMPT="
%{$fg_bold[black]%}  »  "
RPROMPT="%{$fg_bold[blue]%}%~%{$reset_color%}  "

# vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word 
bindkey "^H" backward-delete-char # Control-h also deletes the previous char
bindkey "^U" backward-kill-line

## }}}

## ENVIRONMENT {{{
export EDITOR=vim
export PAGER=more
export TERM=rxvt-256color

# OPAM stuff
. /Users/rahul/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# remove path duplicates cuz it bothers me
export PATH=`echo -n $PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`

alias ls='ls -G'
alias grep='grep --color=auto'

alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -pv'

alias q='exit'
alias :q='exit'
alias c='clear'

alias s='sudo'

alias vi='vim'
alias sv='sudo vim'

## }}}

## FUNCTIONS {{{

cd () {
    builtin cd $@ && ls -CF
}
## }}}
