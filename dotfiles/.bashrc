#-------------------------------------------------------------
# If not running interactively
#-------------------------------------------------------------
case $- in
    *i*) ;;
      *) return;;
esac

#-------------------------------------------------------------
# Global color definitions
#-------------------------------------------------------------

# Normal Colors
BLACK='\e[0;30m'        # Black
RED='\e[0;31m'          # Red
GREEN='\e[0;32m'        # Green
YELLOW='\e[0;33m'       # Yellow
BLUE='\e[0;34m'         # Blue
PURPLE='\e[0;35m'       # Purple
CYAN='\e[0;36m'         # Cyan
WHITE='\e[0;37m'        # White

# Bold
BBLACK='\e[1;30m'       # Black
BRED='\e[1;31m'         # Red
BGREEN='\e[1;32m'       # Green
BYELLOW='\e[1;33m'      # Yellow
BBLUE='\e[1;34m'        # Blue
BPURPLE='\e[1;35m'      # Purple
BCYAN='\e[1;36m'        # Cyan
BWHITE='\e[1;37m'       # White

# Background
ON_BLACK='\e[40m'       # Black
ON_RED='\e[41m'         # Red
ON_GREEN='\e[42m'       # Green
ON_YELLOW='\e[43m'      # Yellow
ON_BLUE='\e[44m'        # Blue
ON_PURPLE='\e[45m'      # Purple
ON_CYAN='\e[46m'        # Cyan
ON_WHITE='\e[47m'       # White

NC="\e[m"               # Color Reset

#-------------------------------------------------------------
# Bash shell options
#-------------------------------------------------------------

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Update LINES and COLUMNS after each command
shopt -s checkwinsize

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#-------------------------------------------------------------
# PS1 Prompt
#-------------------------------------------------------------

USERCOL="${BLUE}"
[[ "$EUID" == "0" ]] && USERCOL="${RED}"

if getent group wheel | grep "$USER" &> /dev/null; then
        USERCOL="${YELLOW}"
elif getent group sudo | grep "$USER" &> /dev/null; then
        USERCOL="${YELLOW}"
fi

HOSTCOL=${BLUE}
[[ ! -z "${SSH_CONNECTION}" ]] && HOSTCOL=${RED}

export PS1="\n${USERCOL}\u ${WHITE}on${HOSTCOL} \h ${WHITE}in \w\n\\$ \[$(tput sgr0)\]"

#-------------------------------------------------------------
# Navi key bind (Ctrl + G)
#-------------------------------------------------------------
bind '"\C-g": " \C-u \C-a\C-k`printf \"\\e\" && NAVI_USE_FZF_ALL_INPUTS=true navi --path /home/$USER/.config/navi/ --print`\e\C-e\C-y\C-a\C-d\C-y\ey\C-h\C-e\C-b"'

#-------------------------------------------------------------
# PATH Modifications
#-------------------------------------------------------------
export PATH=$PATH:/usr/local/go/bin:/home/$USER/go/bin
export GOBIN="/home/tester/go/bin/"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

function volatility()
{
        [[ ! -d "$(pwd)/volatility-logs/" ]] && {
                if ! mkdir -p "$(pwd)/volatility-logs/"; then
                        echo "Failed to create a logs directory. Check permissions"
                        return 1
                fi
        }
        args=$@
        logfile="$(date "+%Y%m%d-%H%M%S")-volatility"
        for arg in $args
        do
                arg="$( echo "${arg}" | sed -r 's/-/_/g')"
                logfile="${logfile}-${arg}"
        done
        logdir="${logfile}.log"
        docker run --rm --volume "$(pwd)":"/host" --volume="$(pwd)/dumps":"/dumps:ro" misterturtlesec/volatility2 $@ | tee -a "$(pwd)/volatility-logs/${logfile}"

}
