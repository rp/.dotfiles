## MAIN {{{
                       
# auto completion
autoload -U compinit && compinit

# enable colors
autoload -U colors && colors

# prompts
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
export PAGER=less
export TERM=rxvt-256color

# virtualenv stuff
source /usr/bin/virtualenvwrapper.sh

# OPAM stuff
. ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export PATH=/usr/local/texlive/2015/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2015/texmf-dist/doc/man:$MATHPATH
export INFOPATH=/usr/local/texlive/2015/texmf-dist/doc/info:$INFOPATH
# remove path duplicates cuz it bothers me
export PATH=`echo -n $PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`

alias ls='ls --color=auto'
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

## }}}

## FUNCTIONS {{{

cd () {
    builtin cd $@ && ls -CF
}
## }}}

#export LC_ALL=en_US.UTF-8
#export LANG=en_US.UTF-8
#export LANGUAGE=en_US.UTF-8
