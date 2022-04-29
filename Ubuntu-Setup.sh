#!/bin/bash

cd ~

# Update
sudo apt -y update; sudo apt -y upgrade

# Install dependencies
sudo add-apt-repository universe
sudo add-apt-repository multiverse
sudo add-apt-repository restricted

sudo apt-get -y install wget
sudo apt-get -y install git
sudo apt-get -y install build-essential
sudo apt-get -y install g++
sudo apt-get -y install zip
sudo apt-get -y install unzip
sudo apt-get -y install make
sudo apt-get -y install bison
sudo apt-get -y install flex
sudo apt-get -y install python3
sudo apt-get -y install python3-venv
sudo apt-get -y install lua5.2
sudo apt-get -y install lua5.2-dev
sudo apt-get -y install curl

sudo snap install cmake --classic

# Update
sudo apt -y update; sudo apt -y upgrade

# Install miscellaneous snaps and flatpaks
sudo apt-get -y install flatpak
sudo apt-get -y install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo snap install code --classic
sudo snap install 1password
sudo snap install flameshot
sudo snap install htop
sudo snap install onionshare
sudo snap install teams
sudo snap install powershell --classic
flatpak install -y flathub com.obsproject.Studio
flatpak install -y flathub com.mojang.Minecraft

# Install Gnome Dock
sudo apt-get -y install gnome-tweaks
sudo apt-get -y install gnome-shell-extensions
sudo apt-get -y install gnome-shell-extension-autohidetopbar
xdg-open https://extensions.gnome.org/extension/307/dash-to-dock/
xdg-open https://extensions.gnome.org/extension/1238/time/
xdg-open https://extensions.gnome.org/extension/779/clipboard-indicator/
xdg-open https://extensions.gnome.org/extension/1036/extensions/
xdg-open https://extensions.gnome.org/extension/1319/gsconnect/
xdg-open https://extensions.gnome.org/extension/517/caffeine/

# Install ProtonVPN
wget https://protonvpn.com/download/protonvpn-beta-release_1.0.1-1_all.deb
sudo dpkg -i protonvpn-beta-release_1.0.1-1_all.deb
rm -f protonvpn-beta-release_1.0.1-1_all.deb
sudo apt -y update
sudo apt-get -y install protonvpn

grep '/usr/s\?bin' /etc/systemd/system/display-manager.service
sudo apt-get -y install gnome-shell-extension-appindicator
sudo apt-get -y install gir1.2-appindicator3-0.1

# Install Tor
wget https://www.torproject.org/dist/torbrowser/11.0.10/tor-browser-linux64-11.0.10_en-US.tar.xz
tar -xf tor-browser-linux64-11.0.10_en-US.tar.xz
rm -f tor-browser-linux64-11.0.10_en-US.tar.xz  
cd tor-browser_en-US/
./start-tor-browser.desktop --register-app

cd..

# Install Fonts
sudo apt-get -y install fonts-firacode
sudo apt-get -y install fonts-open-sans

git clone https://github.com/kencrocken/FiraCodeiScript
cd FiraCodeiScript
mkdir ~/.fonts
cp FiraCodeiScript/FiraCodeiScript-Regular.ttf ~/.fonts
cp FiraCodeiScript/FiraCodeiScript-Italic.ttf ~/.fonts
cp FiraCodeiScript/FiraCodeiScript-Bold.ttf ~/.fonts
cd ..
yes | rm -r FiraCodeiScript/

git clone --depth 1 https://github.com/ryanoasis/nerd-fonts 
cd nerd-fonts/
./install.sh FiraCode
./install.sh FiraMono
cd..
yes | rm -r nerd-fonts/

# Install Github Desktop
wget -qO - https://mirror.mwt.me/ghd/gpgkey | sudo tee /etc/apt/trusted.gpg.d/shiftkey-desktop.asc > /dev/null
sudo sh -c 'echo "deb [arch=amd64] https://mirror.mwt.me/ghd/deb/ any main" > /etc/apt/sources.list.d/packagecloud-shiftkey-desktop.list'
sudo apt -y update
sudo apt-get -y install github-desktop
