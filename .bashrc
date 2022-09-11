# .bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

python .space.py

# exports
export VISUAL=nano
export EDITOR="$VISUAL"
export BROWSER=google-chrome-stable
export PATH=$PATH:$HOME/.local/bin:$HOME/bin
export XDG_CURRENT_DESKTOP=spectrwm

# history
shopt -s histappend
export HISTCONTROL=ignoreboth:erasedups
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s expand_aliases dotglob gnu_errfmt histreedit nocasematch autocd globstar checkwinsize cdspell dirspell  

bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set colored-stats on'

# aliases
alias ls='ls --color=auto'
alias ll='ls --color=auto -al'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias key="nano ~/.config/sxhkd/sxhkdrc"
alias wm="nano ~/.config/bspwm/bspwmrc"
alias f="ranger"
alias weather="wttr Novosibirsk"
alias py="/usr/bin/python"
alias pi="ping 1.1.1.1 -c 1"
alias m="cmus"
alias n="nano"
alias z="bash"
alias shrc="nano ~/.bashrc"
alias c="clear"
alias q="exit"
alias logout="pkill -9 -u babara"
alias mine="java -jar .tl.jar"
alias vi="subl"
alias reboot="sudo reboot"
alias off="sudo shutdown now"
alias _="cd"
alias clock="tty-clock -c -n"
alias root="sudo -i"
alias pac="yay -S"
alias syu="yay -Syu"
alias repo="yay -Syy"
alias pkg="yay -Suu"
alias ht="htop"
alias untar="tar -zxvf"
alias cm="cmatrix"
alias gc="git clone"
alias bird="./.bird"
alias monke="./.monke_bild"
alias gameboy="./.gameboy"
alias ascii="figlet"
alias power="py .power.py"
alias wood="cbonsai -l"
alias h="history"
alias termrc="nano ~/.config/alacritty/alacritty.yml"

up() {
    curl -F "file=@$*" https://0x0.st | xclip -selection clipboard
}

dict() {
    curl dict://dict.org/d:$* | less
}

sip() {
    curl https://ipinfo.io/$*
}

# prompt
red="\e[31m"
green="\e[32m"
yellow="\e[33m"
cyan="\e[36m"
blue="\e[34m"
magenta="\e[35m"
white="\e[37m"
gray="\e[38;5;241m"
gray1="\e[38;5;239m"
gray2="\e[38;5;237m"
reset="\e[0m"

# stolen from https://github.com/icyphox/dotfiles/blob/master/bash/.bashrc.d/99-prompt.bash
git_branch() {
    [[ -d "$PWD/.git" ]] && {
        local git_status="$(git status 2> /dev/null)"
        local on_branch="On branch ([^${IFS}]*)"
        local on_commit="HEAD detached at ([^${IFS}]*)"
        status="$(git status --porcelain 2> /dev/null)"
        local exit="$?"
        color=""
        if [[ "$exit" -eq 0 ]]; then
            if [[ "${#status}" -eq 0 ]]; then
                color="${green}"  
            else
                color="${red}"
            fi
        else
            printf ''
        fi
        if [[ $git_status =~ $on_branch ]]; then
            local branch=${BASH_REMATCH[1]}
            printf '%b'  "$color$branch$reset"
        elif [[ $git_status =~ $on_commit ]]; then
            local commit=${BASH_REMATCH[1]}
            printf '%b' "$color$commit$reset"
        fi
    }
}

function prompt_right() {
    echo -e "$(git_branch)"
}

function prompt_left() {
  echo -e "${gray}\h${reset} ${white}(${reset}${red}\w${reset}${white})${reset}"
}

function prompt() {
    compensate=9
    PS1=$(printf "%*s\r%s\n\$ " "$(($(tput cols)+${compensate}))" "$(prompt_right)" "$(prompt_left)")
}
PROMPT_COMMAND=prompt
