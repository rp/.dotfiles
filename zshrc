## MAIN {{{

# auto completion
autoload -U compinit && compinit

# enable colors
autoload -U colors && colors

# prompts
PROMPT_CHAR="»"
PROMPT="
 "
if [[ ! -z $SSH_CLIENT ]]; then
	host=$(hostname -s)
	PROMPT="$PROMPT%{$fg[red]%}($host[1,5])"
fi
PROMPT="$PROMPT %{$fg_bold[black]%}$PROMPT_CHAR  "

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
#fix delete
bindkey "^[[3~" delete-char

## }}}

## ENVIRONMENT {{{
export EDITOR=vim
export PAGER=less
export TERM=rxvt-256color

# virtualenv stuff
if [[ -f /usr/bin/virtualenvwrapper.sh ]] then;
	source /usr/bin/virtualenvwrapper_lazy.sh
fi

# OPAM stuff
. ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# remove path duplicates cuz it bothers me
PATH=~/bin:$PATH
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

#alias glf="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # "git log full"

alias pacclean='sudo pacman -Rns $(pacman -Qqtd)'

## }}}

## FUNCTIONS {{{

cd () {
	builtin cd $@ && ls -CF
}
## }}}
