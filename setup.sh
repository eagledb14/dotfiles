#!/bin/bash
# to use on cli, curl from
# https://raw.githubusercontent.com/eagledb14/dotfiles/main/setup.sh
# or
# https://blackman.zip/setup/

# getting git setup options
read -p "Enter git-username: " git_username
read -p "Enter git-email: " git_email

# starting in home directory
cd

# create directories
mkdir ~/Documents &> /dev/null
mkdir ~/Downloads &> /dev/null
mkdir ~/.config &> /dev/null

# upating before install
echo -e "\nUPDATING COMPUTER"
sudo pacman -Syy --noconfirm &> /dev/null

#welcoming the user
clear
echo "Welcome to:"
cat << "EOF"
     _     _ _        _    _              
  _ | |___| | |_  _  | |  (_)_ _ _  ___ __
 | || / -_) | | || | | |__| | ' \ || \ \ /
  \__/\___|_|_|\_, | |____|_|_||_\_,_/_\_\
               |__/
EOF


#downloading git
echo "INSTALLING: git"
sudo pacman -S git --noconfirm &> /dev/null

git config --global user.name $git_username
git config --global user.email $git_email
git config --global core.editor nvim

# download yay
echo "DOWNLOADING: yay"
cd ~/Downloads
sudo git clone https://aur.archlinux.org/yay-git.git &> /dev/null

sudo chown -R $USER:$USER ./yay-git
cd yay-git
echo "INSTALLING: yay"
makepkg -si --noconfirm &> /dev/null

cd ../
rm -rf ./yay-git
cd

# install dotfiles
echo "INSTALLING: dotfiles"
cd ~/.config

git clone https://github.com/eagledb14/dotfiles.git &> /dev/null

cd ./dotfiles
ln -r -s -f ./* ~/.config/
ln -r -s -f .bashrc ~/

cd

# installing ble.sh
echo "INSTALLING: ble.sh"
cd ~/Documents
git clone --recursive https://github.com/akinomyoga/ble.sh.git &> /dev/null
cd ble.sh
make install &> /dev/null
cd ../
rm -rf ble.sh

cd

# installing wallpapers
cd ~/.config
echo -e "DOWNLOADING: Wallpapers\n"
git clone https://github.com/eagledb14/wallpapers.git &> /dev/null

cd

# installing other needed packages
PKGS=(
  "alacritty"
  "bluetuith-bin"
  "bluez"
  "bluez-libs"
  "bluez-utils"
  "brightnessctl-git"
  "discord"
  "evince"
  "floorp-bin"
  "freetube"
  "fuse"
  "gnome-boxes"
  "gnome-calculator"
  "gnome-disk-utility"
  "go"
  "grim"
  "htop"
  "imv"
  "keepassxc"
  "kmonad"
  "lua"
  "luarocks"
  "lutris"
  "man-db"
  "man-pages"
  "monero-gui"
  "mullvad-vpn-bin"
  "ncdu"
  "neofetch"
  "neovim"
  "networkmanager"
  "network-manager-applet"
  "npm"
  "obsidian"
  "obs-studio"
  "openssh"
  "pavucontrol"
  "pipewire"
  "pipewire-alsa"
  "pipewire-audio"
  "pipewire-pulse"
  "qbittorrent"
  "rustup"
  "slurp"
  "sof-firmware"
  "steam"
  "sway"
  "swaybg"
  "syncthing-bin"
  "thunar"
  "tldr"
  "tmux"
  "tofi"
  "torbrowser-launcher"
  "unzip"
  "vlc"
  "wine"
  "wlrobs-hg"
  "wl-clipboard"
  "xdg-desktop-portal"
  "xorg-xhosts"
  "xorg-xwayland"
  "zip"
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    yay -S "$PKG" --noconfirm --needed &> /dev/null
done

echo -e "\n"

#miscelanious

echo SETTING UP: rust install
rustup default stable &> /dev/null

echo SETTING UP: bluetooth 
sudo systemctl enable bluetooth &> /dev/null

echo REMOVING BOOT TIMEOUT
if [[ -z $(ls /boot/grub 2> /dev/null) ]]; then
  #removes boot timeout for systemd-boot
  sudo echo "timeout 0" > /boot/loader/loader.conf
else
  #removes boot timeout for grub
  yay -S update-grub --noconfirm --needed &> /dev/null

  sudo sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub &> /dev/null
  sudo sed -i 's/^GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=hidden/' /etc/default/grub &> /dev/null

  update-grub &> /dev/null
  yay -Rcns update-grub --noconfirm &> /dev/null
fi

echo INSTALLING DEPENDENCIES
sudo luarocks install luaposix &> /dev/null
sudo luarocks install lanes &> /dev/null
sudo luarocks install luafilesystem &> /dev/null

echo CLEANING UP
cd ~
sudo rm -rf ~/go &> /dev/null
sudo rm -rf Photos Templates Music 
xhost si:localuser:root

echo "Done!"
sleep 10

#deleting script after it is finished
rm -- "$0"
sudo reboot now
