https://github.com/MagnusMat/Windows-Setup/tree/main
https://github.com/MagnusMat/Ubuntu-Setup/tree/main
https://github.com/tom-james-watson/Emote
https://github.com/MagnusMat/Ubuntu-Setup/blob/main/.inputrc
https://github.com/MagnusMat/Windows-Terminal-Setup/blob/main/WSL-Setup.sh
https://github.com/MagnusMat/Windows-Terminal-Setup/blob/main/.zshrc
https://www.amd.com/en/support/linux-drivers
https://chat.openai.com/
https://apps.gnome.org/DejaDup/
https://wiki.gnome.org/Apps/GTG
https://help.gnome.org/users/gnome-boxes/stable/
https://apps.gnome.org/Blanket/
https://extensions.gnome.org/extension/1319/gsconnect/
https://extensions.gnome.org/extension/4491/privacy-settings-menu/
https://extensions.gnome.org/extension/4651/notification-banner-reloaded/
https://extensions.gnome.org/extension/5446/quick-settings-tweaker/
https://extensions.gnome.org/extension/545/hide-top-bar/
https://extensions.gnome.org/extension/1238/time/
https://extensions.gnome.org/extension/779/clipboard-indicator/
https://extensions.gnome.org/extension/4481/forge/
https://github.com/tom-james-watson/Emote/wiki/Hotkey-In-Wayland/
https://github.com/linuxmint/timeshift?ref=itsfoss.com
https://github.com/oguzhaninan/Stacer?ref=itsfoss.com
https://htop.dev/
https://github.com/flameshot-org/flameshot?ref=itsfoss.com
https://obsproject.com/?ref=itsfoss.com
https://itsfoss.com/kazam-screen-recorder/
https://github.com/GradienceTeam/Gradience

#!/bin/bash

cd ~

# -------------------- Functions --------------------

function Set-Confirmation { #ToDo
    param (
        [string]$Question,
        [string[]]$ValidOptions = @('y', 'n')
    )

    do {
        $Confirmation = Read-Host "$Question"
        if ($Confirmation -notin $ValidOptions) {
            Write-Host "You need to pick a valid option"
        }
    } while ($Confirmation -notin $ValidOptions)

    return $Confirmation
}


function Install-Zip { } #ToDo
function Install-deb{ } #ToDo
function Install-GitHub{ } #ToDo
function Get-DownloadLink { #ToDo
    param (
        [string]$URL,
        [string]$DownloadURL
    )

    $url = ((Invoke-WebRequest -URI $URL -UseBasicParsing).Links | Where-Object { $_.href -like $DownloadURL } | Select-Object -First 1).href

    return $url
}

# -------------------- Confirmations --------------------

# Prompt for Install Drive #ToDo
$ConfirmationDrive = Set-Confirmation -Question "Do you want to install software the C: or D: drive c/d" -ValidOptions 'c', 'd'

if ($ConfirmationDrive -eq 'c') {
    $InstallDrive = "C:\Program Files"
}
if ($ConfirmationDrive -eq 'd') {
    $InstallDrive = "D:"
}

# Install Laptop Desktop Prompt #ToDo
$ConfirmationLaptopDesktop = Set-Confirmation -Question "Are you installing on a Laptop or Desktop l/d" -ValidOptions 'l', 'd'

# Graphics Card Architecture Prompt #ToDo
$ConfirmationNvidiaAMD = Set-Confirmation -Question "Are you installing on a Nvidia or AMD system n/a" -ValidOptions 'n', 'a'

# Games Prompt #ToDo
$ConfirmationGames = Set-Confirmation -Question "Do you want to install Games y/n"

# Emulator prompt #ToDo
$ConfirmationEmulators = Set-Confirmation -Question "Do you want to install Emulators y/n"

# Tex Prompt #ToDo
$ConfirmationTex = Set-Confirmation -Question "Do you want to install LaTeX y/n"

# Windows Terminal Settings Prompt #ToDo
$ConfirmationWindowsTerm = Set-Confirmation -Question "Do you want to replace the Windows Terminal Settings? This will not work if you have a Windows Terminal instance open y/n"

# -------------------- Initial Setup - Updates & Package Managers --------------------

# Remove packages
sudo apt-get remove -y unattended-upgrades

# Add repositories
sudo add-apt-repository universe
sudo add-apt-repository multiverse
sudo add-apt-repository restricted

# Update and upgade all packages
sudo apt update -y; sudo apt upgrade -y

# Curl
sudo apt-get install -y curl

# Flatpak
sudo apt-get install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Git
sudo apt-get install -y git

# GitHub CLI
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \

sudo apt update -y && sudo apt-get install -y gh

# wget
sudo apt-get install -y wget

# Python 3.11
sudo apt-get install -y python3
sudo apt-get install -y python3-venv
sudo apt-get install -y python3-pip
sudo apt-get install -y python-is-python3

# Zip
sudo apt-get install -y zip
sudo apt-get install -y unzip

# Zsh #ToDo
# Change autocomplete functionality #ToDO
wget -O ~/.inputrc https://raw.githubusercontent.com/MagnusMat/Ubuntu-Setup/main/.inputrc

# Download Wallpaper
curl -o ~/Downloads/Planets.jpg https://raw.githubusercontent.com/MagnusMat/Ubuntu-Setup/main/Desktop/Planets%20Wallpaper.jpg

# GitHub Cli Login
gh auth login

# Update and upgade all packages
sudo apt update -y; sudo apt upgrade -y

# -------------------- Fonts --------------------

mkdir ~/.fonts

# Google Fonts
sudo apt-get install -y fonts-open-sans
sudo apt-get install -y fonts-roboto

# Fira Code
sudo apt-get install -y fonts-firacode

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

# Segoe Fonts #ToDo
curl -L -O https://aka.ms/SegoeFonts
unzip SegoeFonts -d segoe

cp segoe/*.ttf ~/.fonts

yes | rm -r SegoeFonts segoe

# -------------------- Websites --------------------

# Create a list of urls #ToDo
urls=(
    "https://github.com/ranmaru22/firefox-vertical-tabs"
)

# Drivers and Software for AMD Radeon
if [ "$confirmationNvidiaAMD" = 'a' ]; then
    urls+=("https://www.amd.com/en/support")
fi

for url in "${urls[@]}"; do
    xdg-open "$url"
done

# -------------------- Build Tools --------------------

# Bison
sudo apt-get install -y bison

# Clang
sudo apt-get install -y clang

# Cmake
sudo apt-get install -y cmake

# Flex
sudo apt-get install -y flex

# GCC & G++
sudo apt-get install -y build-essential

# Lua
sudo apt-get install -y lua5.2
sudo apt-get install -y lua5.2-dev

# Lynx
sudo apt-get install -y lynx

# Make
sudo apt-get install -y make

# -------------------- Development Tools --------------------

# AspNet
sudo apt-get install -y aspnetcore-runtime-7.0

# DotNet SDK
sudo apt-get install -y dotnet-sdk-7.0

# DotNet Runtime
sudo apt-get install -y dotnet-runtime-7.0

# ffmpeg #ToDo
# Pandoc #ToDo
# PowerShell 7 #ToDo

# -------------------- Programs --------------------

if ($confirmationNvidiaAMD -eq 'n') {
    # Nvidia Broadcast #ToDo
    # Nvidia Control Panel #ToDo
    # Nvidia GeForce Experience #ToDo
}

if ($confirmationLaptopDesktop -eq 'd') {
    # Hue Sync #ToDo
    # Locale Emulator #ToDo
}

# 1Password
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list

sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

sudo apt update -y && sudo apt-get install -y 1password

# 1Password CLI
sudo apt-get install -y 1password-cli

# Amazon Send to Kindle #ToDo

# Apt Transport HTTPS
sudo apt-get install -y apt-transport-https

# Blender #ToDo
# Calibre #ToDo
# CPU-Z #ToDo
# Dev Home #ToDo
# Discord #ToDo
# Docker Desktop #ToDo
# Draw.io #ToDo
# Facebook Messenger #ToDo
# Fan Control #ToDo
# Figma #ToDo
# GitHub Desktop #ToDo

# Gnome Tweaks
sudo apt-get install -y gnome-tweaks

# Gnome Shell Extensions
sudo apt-get install -y gnome-shell-extensions

# Gnome Shell Extensions Manager
sudo apt-get install -y gnome-shell-extension-manager

# Godot #ToDo
# Handbrake #ToDo
# htop #ToDO
# Inkscape #ToDo
# JDK Adoptium JDK 17 #ToDo
# Jupyter Notebook #ToDo
# LaTeX-OCR #ToDo
# Libre Hardware Monitor #ToDo
# Libre Office
# Mendeley #ToDo
# Microsoft Teams #ToDo
# Microsoft Whiteboard #ToDo

# MPV
sudo apt-get install -y mpv

# Notion #ToDo
# NVM for Windows #ToDo
# OBS Studio #ToDo
# Obsidian #ToDo
# Oh My Posh #ToDo
# Onion Share #ToDo
# PDF Sam #ToDo
# Postman #ToDo
# PowerToys #ToDo
# Proton Drive #ToDo

# ProtonVPN #ToDo
curl -O https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-2_all.deb

sudo apt-get install -y ./protonvpn-stable-release_1.0.3-2_all.deb 
sudo apt update -y

sudo apt-get install -y protonvpn

yes | rm protonvpn-stable-release_1.0.3-2_all.deb

# RustDesk #ToDo
# Shotcut #ToDo
# SyncTrayzor #ToDo
# TeraCopy #ToDo
# TexLive #ToDo
# Tor Browser #ToDo
# Transmission #ToDo
# Unity Hub #ToDo

# Visual Studio Code
sudo snap install code --classic

# Windows File Recovery #ToDo
# Windows Terminal settings #ToDo
# WinSCP #ToDo
# Wireshark #ToDo
# WizTree #ToDo
# Yubikey Manager #ToDo

# -------------------- Game Launchers & Emulators --------------------

if ($confirmationGames -eq 'y') {
    # Archi Steam Farm #ToDo
    # Epic Games #ToDo
    # Global Steam Controller #ToDo
    # GOG Galaxy #ToDo
    # Minecraft #ToDo
    # Playnite #ToDo
    # Steam #ToDo
    # Ubisoft Connect #ToDo
    # Xbox #ToDo
    # Xbox Accessories #ToDo
}

if ($confirmationEmulators -eq 'y') {
    # Cemu #ToDo
    # Citra #ToDo
    # Dolphin #ToDo
    # NoPayStation #ToDo
    # PCSX2 #ToDo
    # PPSSPP #ToDo
    # Project64 #ToDo
    # QCMA #ToDo
    # RetroArch #ToDo
    # RPCS3 #ToDo
    # Ryujinx #ToDo
    # SNES9X #ToDo
    # Visual Boy Advance #ToDo
}
