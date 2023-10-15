#!/bin/bash

cd ~

# -------------------- Functions --------------------
#!/bin/bash

# Initialize confirmation variables
confirmation_nvidia_amd=""
confirmation_games=""
confirmation_emulators=""

# Function for asking a yes/no question with valid options
function set_confirmation {
    local variable_name=$1
    local question=$2
    local valid_options=("${@:3}")

    while true; do
        read -p "$question" $variable_name
        if [[ ! " ${valid_options[@]} " =~ " ${!variable_name} " ]]; then
            echo "You need to pick a valid option"
        else
            return
        fi
    done
}

# -------------------- Confirmations --------------------

# Graphics Card Architecture Prompt
set_confirmation "confirmation_nvidia_amd" "Are you installing on a Nvidia or AMD system (n/a)?" n a

# Games Prompt
set_confirmation "confirmation_games" "Do you want to install Games (y/n)?" y n

# Emulator prompt
set_confirmation "confirmation_emulators" "Do you want to install Emulators (y/n)?" y n

# -------------------- Initial Setup - Updates & Package Managers --------------------

# Remove packages
sudo apt remove -y unattended-upgrades

# Add repositories
sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse
sudo add-apt-repository -y restricted

# Update and upgade all packages
sudo apt update -y; sudo apt upgrade -y

# Curl
sudo apt install -y curl

# Flatpak
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Git
sudo apt install -y git

# GitHub CLI
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt update -y && sudo apt install -y gh

# wget
sudo apt install -y wget

# Python 3.11
sudo apt install -y python3
sudo apt install -y python3-venv
sudo apt install -y python3-pip
sudo apt install -y python-is-python3

# Zip
sudo apt install -y zip
sudo apt install -y unzip

# Zsh
sudo apt -y install zsh

# Oh My Zsh
sh -c "$(wget -4 https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" -y # Force IPv4 address

# Change Zsh Theme
wget -O ~/.zshrc https://raw.githubusercontent.com/MagnusMat/Windows-Terminal-Setup/main/.zshrc

# Download Wallpaper
curl -o ~/Downloads/Planets.jpg https://raw.githubusercontent.com/MagnusMat/Ubuntu-Setup/main/Desktop/Planets%20Wallpaper.jpg

# GitHub Cli Login
gh auth login

# Update and upgade all packages
sudo apt update -y; sudo apt upgrade -y

# -------------------- Fonts --------------------

mkdir ~/.fonts

# Google Fonts
sudo apt install -y fonts-open-sans
sudo apt install -y fonts-roboto

# Fira Code
sudo apt install -y fonts-firacode

# Fira Code iScript
git clone https://github.com/kencrocken/FiraCodeiScript

cp FiraCodeiScript/*.ttf ~/.fonts

yes | rm -r FiraCodeiScript/

# Fira Code Nerd Font
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts

cd nerd-fonts/
./install.sh FiraCode
./install.sh FiraMono

cd ~
yes | rm -r nerd-fonts/

# Segoe Fonts
curl -L -O https://aka.ms/SegoeFonts
unzip SegoeFonts -d segoe

cp segoe/*.ttf ~/.fonts

yes | rm -r SegoeFonts segoe

# -------------------- Websites --------------------

# Create a list of urls
urls=()

# Clipboard History
urls+=(https://extensions.gnome.org/extension/4839/clipboard-history/)

# Emote Hotkeys
urls+=(https://github.com/tom-james-watson/Emote/wiki/Hotkey-In-Wayland/)

# Firefox Vertical Tabs
urls+=(https://github.com/ranmaru22/firefox-vertical-tabs)

# GSConnect
urls+=(https://extensions.gnome.org/extension/1319/gsconnect/)

# Hide Top Bar
urls+=(https://extensions.gnome.org/extension/545/hide-top-bar/)

# Privacy Quick Settings
urls+=(https://extensions.gnome.org/extension/4491/privacy-settings-menu/)

# Syncthing Indicator
urls+=(https://extensions.gnome.org/extension/1070/syncthing-indicator/)

# Drivers and Software for AMD Radeon
if [ "$confirmation_nvidia_amd" = 'a' ]; then
    urls+=(https://www.amd.com/en/support/linux-drivers)
fi

# Drivers and Software for Nvidia RTX
if [ "$confirmation_nvidia_amd" = 'a' ]; then
    urls+=(https://www.nvidia.com/en-us/geforce/drivers/)
fi

for url in "${urls[@]}"; do
    xdg-open "$url"
done

# -------------------- Build Tools --------------------

# Apt Transport HTTPS
sudo apt install -y apt-transport-https software-properties-common

# Bison
sudo apt install -y bison

# Clang
sudo apt install -y clang

# Cmake
sudo apt install -y cmake

# Flex
sudo apt install -y flex

# GCC & G++
sudo apt install -y build-essential

# Lynx
sudo apt install -y lynx

# Make
sudo apt install -y make

# Software Properties Common
sudo apt install -y software-properties-common

# -------------------- Development Tools --------------------

# AspNet
sudo apt install -y aspnetcore-runtime-7.0

# DotNet SDK
sudo apt install -y dotnet-sdk-7.0

# DotNet Runtime
sudo apt install -y dotnet-runtime-7.0

# ffmpeg
sudo apt install -y ffmpeg

# Pandoc
sudo apt install -y pandoc

# PowerShell 7
sudo snap install powershell --classic

# -------------------- Programs --------------------

# 1Password
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list

sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

sudo apt update -y && sudo apt install -y 1password

# 1Password CLI
sudo apt install -y 1password-cli

# Blanket
flatpak install flathub -y com.rafaelmardojai.Blanket

# Blender
sudo apt install -y blender

# Bottles
flatpak install flathub -y com.usebottles.bottles

# Boxes
flatpak install flathub -y org.gnome.Boxes

# Calibre
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

# Déjà Dup Backups
flatpak install flathub -y org.gnome.DejaDup

# Discord
sudo snap install discord

# Docker Desktop
sudo apt install -y ca-certificates gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

wget -O docker-desktop.deb `lynx -dump -listonly -nonumbers https://docs.docker.com/desktop/install/ubuntu/ | grep -E "*-amd64.deb*" | head -1`

sudo apt install -y ./docker-desktop.deb

yes | rm docker-desktop.deb

# Draw.io
sudo snap install drawio

# Emote
flatpak install flathub -y com.tomjwatson.Emote

# Gnome Tweaks
sudo apt install -y gnome-tweaks

# Gnome Shell Extensions Manager
sudo apt install -y gnome-shell-extension-manager

# Godot
sudo snap install gd-godot-engine-mono-snapcraft

# Gradience
flatpak install flathub -y com.github.GradienceTeam.Gradience

# Handbrake
flatpak install flathub -y fr.handbrake.ghb

# htop
sudo apt install -y htop

# Inkscape
sudo add-apt-repository -y ppa:inkscape.dev/stable
sudo apt update -y
sudo apt install -y inkscape

# Libre Office
flatpak install flathub -y org.libreoffice.LibreOffice

# Microsoft Edge
flatpak install flathub -y com.microsoft.Edge

# Mozilla Thunderbird
flatpak install flathub -y org.mozilla.Thunderbird

# Mozilla Firefox
flatpak install flathub -y org.mozilla.firefox

# MPV
sudo apt install -y mpv

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# OBS Studio
flatpak install flathub -y com.obsproject.Studio

# Onion Share
flatpak install flathub -y org.onionshare.OnionShare

# PDF Sam
wget -O pdfsam.deb `lynx -dump -listonly -nonumbers https://pdfsam.org/download-pdfsam-basic/ | grep -E "*.deb" | head -1`

sudo apt install -y ./pdfsam.deb

rm pdfsam.deb

# Pomodoro
sudo apt install -y gnome-shell-pomodoro

# Postman
sudo snap install postman

# Powertoys #ToDO
#   - Color Picker
#   - Paste as plain text
#   - PowerRename
#   - Text Extractor
#   - Screen ruler

# ProtonVPN
curl -O https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-2_all.deb

sudo apt install -y ./protonvpn-stable-release_1.0.3-2_all.deb 
sudo apt update -y

sudo apt install -y protonvpn

yes | rm protonvpn-stable-release_1.0.3-2_all.deb

# PuTTY
flatpak install flathub -y uk.org.greenend.chiark.sgtatham.putty

# RustDesk
gh release download -R rustdesk/rustdesk --pattern "*-x86_64.deb"

sudo apt install -y `find . -name '*x86_64.deb'`

yes | rm `find . -name '*x86_64.deb'`

# Shotcut
flatpak install flathub -y org.shotcut.Shotcut

# Stacer
sudo apt install -y stacer

# Syncthing
sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

sudo apt update -y
sudo apt install -y syncthing

# Transmission
sudo apt install -y transmission

# Tor Browser
wget `lynx -dump -listonly -nonumbers https://www.torproject.org/download/ | grep -E "*.tar.xz" | head -1`
tar -xvf `find . -name '*tor-browser-linux-*'`
rm -f `find . -name '*tor-browser-linux-*.tar.xz'`

sudo mv tor-browser /opt/tor-browser

cd /opt/tor-browser
./start-tor-browser.desktop --register-app

cd ~

# Visual Studio Code
sudo snap install code --classic

# Wireshark
sudo apt install -y wireshark

# -------------------- Game Launchers & Emulators --------------------

if ($confirmation_games -eq 'y') {
    # GOG Galaxy & Epic Games Launcher
    flatpak install flathub -y com.heroicgameslauncher.hgl
    
    # Minecraft
    flatpak install flathub -y org.prismlauncher.PrismLauncher

    # ProtonUp-Qt
    flatpak install flathub -y net.davidotek.pupgui2

    # Steam
    flatpak install flathub -y com.valvesoftware.Steam
    
    # Lutris
    flatpak install flathub -y net.lutris.Lutris
}

if ($confirmation_emulators -eq 'y') {
    # Cemu
    flatpak install flathub -y info.cemu.Cemu
    
    # Citra
    flatpak install flathub -y org.citra_emu.citra

    # Dolphin
    flatpak install flathub -y org.DolphinEmu.dolphin-emu
    
    # PCSX2
    flatpak install flathub -y net.pcsx2.PCSX2

    # PPSSPP
    flatpak install flathub -y org.ppsspp.PPSSPP

    # Simple64
    flatpak install flathub -y io.github.simple64.simple64

    # QCMA
    echo 'deb http://download.opensuse.org/repositories/home:/codestation/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:codestation.list
    curl -fsSL https://download.opensuse.org/repositories/home:codestation/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_codestation.gpg > /dev/null
    sudo apt update -y
    sudo apt install -y qcma

    # RetroArch
    flatpak install flathub -y org.libretro.RetroArch
    
    # RPCS3
    flatpak install flathub -y net.rpcs3.RPCS3
    
    # Ryujinx
    flatpak install flathub -y org.ryujinx.Ryujinx
    
    # SNES9X
    flatpak install flathub -y com.snes9x.Snes9x

    # Visual Boy Advance
    sudo snap install visualboyadvance-m --beta
}
