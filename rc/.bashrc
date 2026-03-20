# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Vimify my manpage
export MANPAGER='nvim +Man!'

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# If Debian
# set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# useful for aliasing real name in screenshots or streaming
#USERALIAS="anon"
LONGNAME="$USER"
if ! [ -z ${USERALIAS+x} ]; then
  LONGNAME="${USERALIAS}"
fi

SHORTNAME=${LONGNAME:0:4}
USERDISPLAY="${LONGNAME}"

#HOSTALIAS=debian
if ! [ -z ${HOSTALIAS+x} ]; then
  HOSTNAME="${HOSTALIAS}"
fi
LONGHOST="${HOSTNAME}"
SHORTHOST="${HOSTNAME:0:4}"
HOSTDISPLAY="${LONGHOST}"

alias short='USERDISPLAY=$SHORTNAME;HOSTDISPLAY=$SHORTHOST'
alias long='USERDISPLAY=$LONGNAME;HOSTDISPLAY=$LONGHOST'

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]$USERDISPLAY\[\033[01;31m\]@\[\033[01;36m\]$HOSTDISPLAY\[\033[00m\]:\[\033[01;34m\]\W \[\033[01;33m\]⚙ \[\[\033[00m\]'

# PROTON_EAC_RUNTIME="/home/$USER/.steam/steam/steamapps/common/Proton EasyAntiCheat Runtime/" %command%

# Alias definitions.
# You may want to put all your additions into a separate file like
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
if [ -f ~/.bash_env ]; then
  . ~/.bash_env
fi

export STEAM_ROOT=/home/ttrreevvoorr/.local/share/Steam

export PATH=$PATH:/usr/local/go/bin

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(mcfly init bash)"
