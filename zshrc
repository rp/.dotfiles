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
# fix backspace
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word 
bindkey "^H" backward-delete-char # Control-h also deletes the previous char
bindkey "^U" backward-kill-line
# fix Ctrl + <left/right arrow key>
bindkey "Oc" forward-word
bindkey "Od" backward-word

## }}}

## ENVIRONMENT {{{
export EDITOR=vim
export PAGER=less
export TERM=rxvt-256color

# virtualenv stuff
source /usr/bin/virtualenvwrapper.sh

# OPAM stuff
. ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

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
alias dq='disown; exit'

alias s='sudo'

alias vi='vim'

# stole these git aliases from some fool on reddit
alias gs='git status'
alias ga='git add -u'
alias gaa='git add -A'
alias gc='git commit'
alias gr='git checkout --' # gr means "git revert"
alias gu='git reset HEAD'  # gu means "git unstage"
alias gch='git checkout'
alias gst='git stash save'
alias gmm='git fetch && git merge origin/master'
alias glf="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # "git log full"
alias gl='glf | head'
alias gd='git diff'
alias gdc='git diff --cached'

## }}}

## FUNCTIONS {{{

cd () {
    builtin cd $@ && ls -CF
}
## }}}
