#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]]
source ~/Documents/ble.sh/out/ble.sh --noattach
#PS1='[\u@\h \W]\$ '

export PS1="\[$(tput bold)\]\[\033[38;5;129m\]\u\[$(tput sgr0)\]@\h \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;129m\]\W\[$(tput sgr0)\] \$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')> \[$(tput sgr0)\]"

export PATH=$PATH:"~/.nix-profile/bin:~/.cargo/bin"
export NIXPKGS_ALLOW_UNFREE=1

# aliases

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias la='ls -A'
alias vi='nvim'

#functions
## nx keyword and simpler api, update as needed
nx () {
  if [[ $1 == "-i" ]]; then
    nix-env -iA "nixpkgs.${2}"
    ln -s /home/$USER/.nix-profile/share/applications/* /home/$USER/.local/share/applications/ 2>&- 
    return 1
  elif [[ $1 == "-e" ]]; then
    file=$(ls ~/.local/share/applications | grep ${2} 2>&-)
    rm ~/.local/share/applications/${file}
  fi
  nix-env ${1} ${2}
}



[[ ${BLE_VERSION-} ]] && ble-attach
