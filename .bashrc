#
# ~/.bashrc
#

# If running from tty1 start sway
[ "$(tty)" = "/dev/tty1" ] && ssh-agent sway

# If not running interactively, don't do anything
[[ $- != *i* ]]
# source ~/.local/share/blesh/ble.sh
ble=${blesh-share}
source "${ble}/ble.sh" --attach=none

export PS1="\[$(tput bold)\]\[\033[38;5;129m\]\u\[$(tput sgr0)\]@\h \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;129m\]\W\[$(tput sgr0)\] \$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')> \[$(tput sgr0)\]"

# new paths
export PATH=/home/eagledb14/.cargo/bin:$PATH

# new env
export _JAVA_AWT_WM_NONREPARENTING=1
export GOPATH=~/.config/go
export EDITOR=nvim
export VISUAL=nvim

#vim keys
set -o vi

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias la='ls -A'
alias vi='nvim'
alias gp='git push'
alias gs='git status'


function gc {
  git add .
  git commit 
}

#functions
#go to class folder
function class {
  cd ~/sync/classes
}

# go to project folder
function proj {
  cd ~/sync/projects
}

function storage {
  cd /mnt/nvme1n1/
}

function new {
  nohup alacritty --working-directory "$PWD" &>/dev/null &
  disown
}

[[ ${BLE_VERSION-} ]] && ble-attach
