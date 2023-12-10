os.execute('luarocks install luafilesystem')
os.execute('luarocks install luaposix')
os.execute('luarocks install lanes')

local lfs = require"lfs"
local posix = require"posix"
local lanes = require"lanes"
local user = os.getenv("SUDO_USER")
local home = "/home/" .. user .. "/"
local packages = {
    "alacritty",
    "bluetuith-bin",
    "bluez",
    "bluez-libs",
    "bluez-utils",
    "brightnessctl-git",
    "discord",
    "evince",
    "freetube",
    "fuse",
    "gnome-calculator",
    "gnome-disk-utility",
    "go",
    "grim",
    "htop",
    "imv",
    "keepassxc",
    "kmonad",
    "lua",
    "luarocks",
    "lutris",
    "man-db",
    "man-pages",
    "monero-gui",
    "mullvad-vpn-bin",
    "neofetch",
    "neovim",
    "networkmanager",
    "network-manager-applet",
    "npm",
    "obsidian",
    "obs-studio",
    "openssh",
    "pavu-control",
    "pipewire",
    "pipewire-alsa",
    "pipewire-audio",
    "pipewire-pulse",
    "qbittorrent",
    "rustup",
    "slurp",
    "sof-firmware",
    "steam",
    "sway",
    "swaybg",
    "syncthing-bin",
    "thunar",
    "tldr",
    "tmux",
    "tofi",
    "torbrowser-launcher",
    "ttf-ms-win10-auto",
    "unzip",
    "vlc",
    "waterfox-bin",
    "wine",
    "wlrobs-hg",
    "wl-clipboard",
    "xdg-desktop-portal",
    "xorg-xwayland",
    "zip"
}

local function exec(command)
  local success, exit, signal = os.execute(command .. " &> /dev/null")
  if not success then
      print("Error executing command: " .. command)
      print("Exit code: " .. tostring(exit) .. " Signal: " .. tostring(signal))
      os.exit(1)
  end
end

local function user_exec(command)
  exec("sudo -u " .. user .. " " .. command)
end

local function exec_yay(files)
  user_exec("yay -S " .. files .. " --noconfirm --needed")
end

-- create directories
local function create_directories()
  -- print("Creating Directories")

  lfs.mkdir(home .. "Documents")
  lfs.mkdir(home .. "Downloads")
  lfs.mkdir(home .. ".config")
end

-- install git/setup git
local function setup_git(username, email)
  -- print("")
  exec("pacman -S git --noconfirm")

  user_exec("git config --global user.name " .. username)
  user_exec("git config --global user.email " .. email)
  user_exec("git config --global core.editor nvim")
end

-- download/setup yay
local function setup_yay()
  user_exec("git clone https://aur.archlinux.org/yay-git.git")
  user_exec("chown -R " .. user .. ":" .. user .. " ./yay-git")

  --this is the only way I could get makepkg to run without requireing to reinput your password
  exec("cp /etc/sudoers /etc/sudoers.backup")
  exec("echo \"".. user .. " ALL = NOPASSWD: /usr/bin/pacman\" >> /etc/sudoers")

  lfs.chdir("./yay-git")
  user_exec("makepkg -si --noconfirm ")

  exec("mv /etc/sudoers.backup /etc/sudoers")

  lfs.chdir(home)
  exec("rm -rf ./yay-git")
end

-- download/install dotfiles
local function install_dotfiles()
  exec("git clone https://github.com/eagledb14/dotfiles.git " .. home .. ".config")
  exec("ln -r -s -f ~/.config/dotfiles/* ~/.config/")
  exec("ln -r -s -f ~/.config/dotfiles/.bashrc ~/")
end

-- download/install ble.sh
local function install_blesh()
  exec("git clone --recursive https://github.com/akinomyoga/ble.sh.git")
  exec("cd ./ble.sh && make install")

  local success lfs.rmdir("./ble.sh")
  if not success then
    print("failed to remove ble.sh")
  end
end

-- download wallpapers
local function install_wallpapers()
  exec("git clone https://github.com/eagledb14/wallpapers.git " .. home .. ".config")
end

-- install all packages
local function install_packages(l)
  local package_string = table.concat(packages, " ")
  exec_yay(package_string)
end

-- check for grub or systemd boot
local function remove_grub_timeout()
  exec_yay("update-grub")

  local grub_file = io.open('/boot/grub/', "r")
  if not grub_file then
    print("error, grub file doesn't exist")
    return
  end

  local grub_content = grub_file:read('a')
  grub_file:close()

  grub_content = grub_content:gsub("^GRUB_TIMEOUT=.*", "GRUB_TIMEOUT=0")
  grub_content = grub_content:gsub("^GRUB_TIMEOUT_STYLE=.*", "GRUB_TIMEOUT_STYLE=hidden")

  grub_file = io.open('/boot/grub/', "w")
  if grub_file then
    grub_file:write(grub_content)
    grub_file:close()
    exec("update-grub")
  end
end

local function remove_systemd_timeout()
  local systemd_file = io.open("/boot/loader/loader.conf", "w")
  if not systemd_file then
    print("error, systemd file doesn't exist")
    return
  end

  systemd_file:write("timeout 0\n")
  systemd_file:close()
end

local function remove_boot_timeout()
  local filePath = "/boot/grub"

  --if it's grub
  if lfs.attributes(filePath, "mode") == "directory" then
    remove_grub_timeout()
  else
    remove_systemd_timeout()
  end
end

-- install rust stuff
local function setup_rust()
  exec("rustup default stable")
end

-- setup bluetooth
local function setup_bluetooth()
  exec("sudo systemctl enable bluetooth")
end

-- clean up
---- remove the go thing
---- print done
local function cleanup()
  lfs.rmdir(home .. "go")
  print("DONE")
end

local function main()
  if #arg < 2 then
    print("Usage: lua setup.lua [git username] [git email]")
  end
  local username = arg[1]
  local email = arg[2]

  create_directories()
  setup_git(username, email)

  local threads = {}

  local yay_handle = lanes.gen("*", setup_yay)()
  table.insert(threads, lanes.gen("*", install_dotfiles)())
  table.insert(threads, lanes.gen("*", install_wallpapers)())

  yay_handle:join()
  install_packages()

  table.insert(threads, lanes.gen("*", remove_boot_timeout)())
  table.insert(threads, lanes.gen("*", setup_rust)())
  table.insert(threads, lanes.gen("*", setup_bluetooth)())
  table.insert(threads, lanes.gen("*", cleanup)())

  for _, thread in pairs(threads) do
    thread:join()
  end
end

-- main()
local function test()
  remove_boot_timeout()
end


