#!/bin/bash
# to use on cli, curl from
# https://raw.githubusercontent.com/eagledb14/dotfiles/main/setup.sh
# or
# https://blackman.zip/setup/

# starting in home directory
cd

# create directories
mkdir ~/Documents
mkdir ~/Downloads
mkdir ~/.config

# upating before install
echo -e "\nUPDATING COMPUTER"
sudo pacman -Syy --noconfirm

#welcoming the user
clear

#downloading git
echo "INSTALLING: git"
sudo pacman -S git --noconfirm

git config --global user.name eagledb14
git config --global user.email eagledb14@gmail.com
git config --global core.editor nvim

# download yay
echo "DOWNLOADING: yay"
cd ~/Downloads
sudo git clone https://aur.archlinux.org/yay-git.git

sudo chown -R $USER:$USER ./yay-git
cd yay-git
echo "INSTALLING: yay"
makepkg -si --noconfirm

cd ../
rm -rf ./yay-git
cd

# install dotfiles
echo "INSTALLING: dotfiles"
cd ~/.config

git clone https://github.com/eagledb14/dotfiles.git

cd ./dotfiles
ln -r -s -f ./* ~/.config/
ln -r -s -f .bashrc ~/
ln -r -s -f .bash_profile ~/

cd

# installing ble.sh
echo "INSTALLING: ble.sh"
cd ~/Documents
git clone --recursive https://github.com/akinomyoga/ble.sh.git
cd ble.sh
make install
cd ../
rm -rf ble.sh

cd

# installing wallpapers
cd ~/.config
echo -e "DOWNLOADING: Wallpapers\n"
git clone https://github.com/eagledb14/wallpapers.git

cd

echo "INSTALLING PKGS"
yay -S pacdef --noconfirm --needed
cd ~/.config/pkgs

pacdef import base gui
pacdef package sync --noconfirm
pacdef package clean --noconfirm
cd

echo -e "\n"

#miscelanious

echo SETTING UP: bluetooth 
sudo systemctl enable bluetooth

echo REMOVING BOOT TIMEOUT
if [[ -z $(ls /boot/grub 2> /dev/null) ]]; then
  #removes boot timeout for systemd-boot
  sudo echo "timeout 0" > /boot/loader/loader.conf
else
  #removes boot timeout for grub
  yay -S update-grub --noconfirm --needed

  sudo sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub
  sudo sed -i 's/^GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=hidden/' /etc/default/grub

  sudo update-grub
  yay -Rcns update-grub --noconfirm 
fi

echo CLEANING UP
cd ~
sudo rm -rf ~/go
sudo rm -rf Photos Templates Music 
xhost si:localuser:root

echo "Done!"
sleep 10

#deleting script after it is finished
rm -- "$0"
sudo reboot now
