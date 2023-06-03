
#install dotfiles
echo git username
read git_username

echo git password
read -s git_password

cd ~/.config
pass_file="./pass.sh"

echo "!#/bin/bash" > "$pass_file"
echo "exec echo $git_password" >> "$pass_file"
chmod +x "$pass_file"

GIT_ASKPASS="$pass_file" git clone https://github.com/eagledb14/dotfiles.git
rm $pass_file

cd ./dotfiles
ln -r -s -f ./* ~/.config/

cd



