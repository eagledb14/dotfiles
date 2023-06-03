# to use on cli, use curl from
# https://raw.githubusercontent.com/eagledb14/dotfiles/main/startup-command.sh


# starting in home directory
cd

# getting passwords and stuff before isntall
# echo git username
# read git_username
#
# echo git password
# read -s git_password


# create directories
mkdir ~/documents
mkdir ~/Downloads
mkdir ~/.config


# upating before install
sudo pacman -Syy --noconfirm

#downloading git
echo "INSTALLING: git"
sudo pacman -S git --noconfirm

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

sudo rm -rf ~/go

# install dotfiles
echo "INSTALLING: dotfiles"
cd ~/.config

git clone https://github.com/eagledb14/dotfiles.git > /dev/null 2>&1

cd ./dotfiles
ln -r -s -f ./* ~/.config/
rm ../.bashrc
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
echo "DOWNLOADING WALLPAPERS"
git clone https://github.com/eagledb14/wallpapers.git > /dev/null 2>&1

cd

# removing unwanted packages that were probably added during install
REMOVE_PKGS=(
  "xfce4"
  "lightdm"
  "wayland"
)

for PKG in "${REMOVE_PKGS[@]}"; do
    echo "REMOVING: ${PKG}"
    yay -Rcns "$PKG" --noconfirm  2> /dev/null > /dev/null
done


# installing other needed packages
PKGS=(
  "firefox"
  "brave-bin"
  "sx"
  "i3-wm"
  "dmenu"
  "feh"
  "mesa"
  "htop"
  "kmonad"
  "openssh"
  "curl"
  "cairo"
  "lxappearance-gtk3"
  "monero-gui"
  "mullvad-vpn-bin"
  "bluetuith"
  "steam"
  "neovim"
  "alacritty"
  "syncthing"
  "pop-icon-theme-git"
  "pop-gtk-theme-git"
  "obsidian-appimage"
  "rustup"
  "gnome-boxes"
  "keepassxc"
  "evince"
  "tmux"
  "neofetch"
  "discord"
  "lutris"
  "wine"
  "zip"
  "unzip"
  "gnome-disk-utility"
  "gnome-calculator"
  "npm"
  "timeshift-bin"
  "libreoffice-fresh"
  "sublime-text-4"
  "man-db"
  "man-pages"
  "thunar"
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    yay -S "$PKG" --noconfirm --needed > /dev/null 2> /dev/null
done


sudo reboot now
