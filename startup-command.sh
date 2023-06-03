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
sudo pacman -S git --noconfirm

# download yay
cd ~/Downloads
sudo git clone https://aur.archlinux.org/yay-git.git

sudo chown -R $USER:$USER ./yay-git
cd yay-git
makepkg -si --noconfirm

cd ../
rm -rf ./yay-git
cd

sudo rm -rf ~/go

# install dotfiles
cd ~/.config

git clone https://github.com/eagledb14/dotfiles.git

cd ./dotfiles
ln -r -s -f ./* ~/.config/
rm ../.bashrc
ln -r -s -f .bashrc ~/

cd

# installing ble.sh
cd ~/documents
git clone --recursive https://github.com/akinomyoga/ble.sh.git
cd ble.sh
make install
cd ../
rm -rf ble.sh

cd

# installing wallpapers
cd ~/.config
git clone https://github.com/eagledb14/wallpapers.git

cd

# removing unwanted packages that were probably added during install
REMOVE_PKGS=(
  "xfce4"
  "lightdm"
  "wayland"
)

for PKG in "${REMOVE_PKGS[@]}"; do
    echo "REMOVING: ${PKG}"
    yay -Rcns "$PKG" --noconfirm  > /dev/null
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
    yay -S "$PKG" --noconfirm --needed > /dev/null
done


sudo reboot now
