# to use on cli, use curl from
# https://raw.githubusercontent.com/eagledb14/dotfiles/main/setup.sh

# starting in home directory
cd

# create directories
mkdir ~/documents > /dev/null 2>&1
mkdir ~/Downloads > /dev/null 2>&1
mkdir ~/.config > /dev/null 2>&1

# upating before install
sudo pacman -Syy --noconfirm > /dev/null 2>&1

#welcoming the user
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
sudo pacman -S git --noconfirm > /dev/null 2>&1

# download yay
echo "DOWNLOADING: yay"
cd ~/Downloads
sudo git clone https://aur.archlinux.org/yay-git.git > /dev/null 2>&1

sudo chown -R $USER:$USER ./yay-git
cd yay-git
echo "INSTALLING: yay"
makepkg -si --noconfirm > /dev/null 2>&1

cd ../
rm -rf ./yay-git
cd

# install dotfiles
echo "INSTALLING: dotfiles"
cd ~/.config

git clone https://github.com/eagledb14/dotfiles.git > /dev/null 2>&1

cd ./dotfiles
ln -r -s -f ./* ~/.config/
ln -r -s -f .bashrc ~/

cd

# installing ble.sh
echo "INSTALLING: ble.sh"
cd ~/documents
git clone --recursive https://github.com/akinomyoga/ble.sh.git > /dev/null 2>&1
cd ble.sh
make install > /dev/null 2>&1
cd ../
rm -rf ble.sh

cd

# installing wallpapers
cd ~/.config
echo "DOWNLOADING: Wallpapers"
git clone https://github.com/eagledb14/wallpapers.git > /dev/null 2>&1

cd

# removing unwanted packages that were probably added during install
REMOVE_PKGS=(
  "lightdm"
  "wayland"
  "xfce4"
)

for PKG in "${REMOVE_PKGS[@]}"; do
    echo "REMOVING: ${PKG}"
    yay -Rcns "$PKG" --noconfirm > /dev/null 2>&1
done

# installing other needed packages
PKGS=(
  "alacritty"
  "arandr"
  "bluetuith"
  "bluez"
  "bluez-libs"
  "brave-bin"
  "cairo"
  "curl"
  "discord"
  "dmenu"
  "evince"
  "feh"
  "firefox"
  "gnome-boxes"
  "gnome-calculator"
  "gnome-disk-utility"
  "htop"
  "i3-wm"
  "keepassxc"
  "kmonad"
  "libreoffice-fresh"
  "lutris"
  "lxappearance-gtk3"
  "man-db"
  "man-pages"
  "mesa"
  "monero-gui"
  "mullvad-vpn-bin"
  "neofetch"
  "neovim"
  "networkmanager"
  "npm"
  "obsidian-appimage"
  "openssh"
  "pop-gtk-theme-git"
  "pop-icon-theme-git"
  "pulseaudio"
  "pulseaudio-also"
  "pulseaudio-bluetooth"
  "rustup"
  "steam"
  "sublime-text-4"
  "sx"
  "syncthing-bin"
  "thunar"
  "timeshift-bin"
  "tmux"
  "unzip"
  "wine"
  "zip"
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    yay -S "$PKG" --noconfirm --needed > /dev/null 2>&1
done


#miscelanious extras
echo CLEANING UP
yay -Rcns go > --noconfirm /dev/null 2>&1
rm -rf ~/go > /dev/null 2>&1

rustup default stable > /dev/null 2>&1


echo "Done!"
sleep(3)
sudo reboot now
