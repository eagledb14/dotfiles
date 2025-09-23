#
# ~/.bashrc
#

# If running from tty1 start sway
[ "$(tty)" = "/dev/tty1" ] && ssh-agent Hyprland

# If not running interactively, don't do anything
[[ $- != *i* ]] 
source /usr/share/blesh/ble.sh --noattach


export PS1="\[$(tput bold)\]\[\033[38;5;129m\]\u\[$(tput sgr0)\]@\h \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;129m\]\W\[$(tput sgr0)\] \$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')> \[$(tput sgr0)\]"

# new paths
export PATH=/home/eagledb14/.cargo/bin:$PATH

# new env
export _JAVA_AWT_WM_NONREPARENTING=1
export GOPATH=~/.config/go
export EDITOR=nvim
export VISUAL=nvim

export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:$(go env GOPATH)/bin

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias la='ls -A'
alias vi='nvim'
alias gp='git push'
alias gs='git status'
alias yay='yay --sudoloop'


function gc {
  git add .
  git commit 
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

function sf {
  cd $(find ~ -type d 2> /dev/null | fzf --preview "ls {}")
}

function init {
    tmux new-session -d
    name=$(tmux list-sessions -F '#{session_name}' | tail -n 1)

    tmux new-window -t "$name:2"
    tmux new-window -t "$name:3"

    tmux select-window -t "$name:1"
    tmux attach-session -t "$name"
}

[[ ${BLE_VERSION-} ]] && ble-attach
