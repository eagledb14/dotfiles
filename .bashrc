#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]]
source ~/.local/share/blesh/ble.sh
#PS1='[\u@\h \W]\$ '

export PS1="\[$(tput bold)\]\[\033[38;5;129m\]\u\[$(tput sgr0)\]@\h \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;129m\]\W\[$(tput sgr0)\] \$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')> \[$(tput sgr0)\]"

# new paths
export PATH=/home/eagledb14/.cargo/bin:$PATH

set -o vi

# aliases
alias torify='torsocks'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias la='ls -A'
alias vi='nvim'
alias sx='sx i3'


#functions
#go to class folder
function class {
  cd ~/Sync/classes
}

#split tmux and start a coding session
function edit {
  tmux new-session -d
  tmux split-window -h -p 75
  tmux attach-session
}

# go to project folder
function proj {
  cd ~/Sync/projects
}



[[ ${BLE_VERSION-} ]] && ble-attach
