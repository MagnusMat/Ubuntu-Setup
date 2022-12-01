#!/bin/bash

cd ~

# Update
sudo apt -y update; sudo apt -y upgrade

# Install dependencies
sudo add-apt-repository universe
sudo add-apt-repository multiverse
sudo add-apt-repository restricted

sudo apt-get -y remove unattended-upgrades
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
sudo apt-get -y install python3-pip
sudo apt-get -y install python-is-python3
sudo apt-get -y install lua5.2
sudo apt-get -y install lua5.2-dev
sudo apt-get -y install curl
sudo apt-get -y install mpv
sudo apt-get -y install lynx

sudo snap install cmake --classic

# Update
sudo apt -y update; sudo apt -y upgrade

# Install miscellaneous snaps and flatpaks
sudo apt-get -y install flatpak
sudo apt-get -y install gnome-software-plugin-flatpak
sudo apt-get -y install dotnet6
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo snap install code --classic
sudo snap install 1password
sudo snap install htop
sudo snap install teams
sudo snap install powershell --classic
sudo snap install emote
sudo snap install nextcloud-desktop-client
flatpak install -y flathub org.onionshare.OnionShare
flatpak install -y flathub com.obsproject.Studio
flatpak install -y flathub com.mojang.Minecraft

# Install Gnome Extensions
sudo apt-get -y install gnome-tweaks
sudo apt-get -y install gnome-shell-extensions
flatpak install -y flathub com.mattjakeman.ExtensionManager

array=( https://extensions.gnome.org/extension/545/hide-top-bar/
https://extensions.gnome.org/extension/1238/time/
https://extensions.gnome.org/extension/779/clipboard-indicator/
https://extensions.gnome.org/extension/1319/gsconnect/
https://github.com/tom-james-watson/Emote/wiki/Hotkey-In-Wayland/ )

for i in "${array[@]}"
do
    EXTENSION_ID=$(curl -s $i | grep -oP 'data-uuid="\K[^"]+')
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
    wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
    gnome-extensions install --force ${EXTENSION_ID}.zip
    if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
        busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
    fi
    gnome-extensions enable ${EXTENSION_ID}
    rm ${EXTENSION_ID}.zip
done

# Install R
sudo apt-get -y install r-base r-base-dev
sudo apt-get -y install libatlas3-base
pip3 install -U radian
R
install.packages("languageserver")
install.packages("httpgd")
q()

# Install 1Password CLI
curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
 sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" |
 sudo tee /etc/apt/sources.list.d/1password.list

sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/

curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | \
 sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol

sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22

curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
 sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

sudo apt-get -y update
sudo apt-get -y install 1password-cli

# Install DotNet
sudo apt-get -y update
sudo apt-get -y install dotnet7
sudo apt-get -y install aspnetcore-runtime-7.0
sudo apt-get -y install dotnet-runtime-7.0

# Install ProtonVPN
wget `lynx -dump -listonly -nonumbers https://protonvpn.com/support/linux-ubuntu-vpn-setup/ | grep -E "*.deb" | head -1`
sudo dpkg -i `find . -name 'protonvpn-stable-release_*'`
rm -f `find . -name 'protonvpn-stable-release_*'`
sudo apt -y update
sudo apt-get -y install protonvpn

grep '/usr/s\?bin' /etc/systemd/system/display-manager.service
sudo apt-get -y install gnome-shell-extension-appindicator
sudo apt-get -y install gir1.2-appindicator3-0.1

# Install Tor
wget `lynx -dump -listonly -nonumbers https://www.torproject.org/download/ | grep -E "*.tar.xz" | head -1`
tar -xf `find . -name '*tor-browser-linux64*'`
rm -f `find . -name '*tor-browser-linux64*.tar.xz'`
cd tor-browser_en-US/
./start-tor-browser.desktop --register-app

cd ~

# Install Fonts
sudo apt-get -y install fonts-firacode
sudo apt-get -y install fonts-open-sans

git clone https://github.com/kencrocken/FiraCodeiScript
mkdir ~/.fonts
cp FiraCodeiScript/FiraCodeiScript-Regular.ttf ~/.fonts
cp FiraCodeiScript/FiraCodeiScript-Italic.ttf ~/.fonts
cp FiraCodeiScript/FiraCodeiScript-Bold.ttf ~/.fonts
yes | rm -r FiraCodeiScript/

git clone --depth 1 https://github.com/ryanoasis/nerd-fonts
cd nerd-fonts/
./install.sh FiraCode
./install.sh FiraMono
cd ~
yes | rm -r nerd-fonts/

# Install Github Desktop
wget -qO - https://mirror.mwt.me/ghd/gpgkey | sudo tee /etc/apt/trusted.gpg.d/shiftkey-desktop.asc > /dev/null
sudo sh -c 'echo "deb [arch=amd64] https://mirror.mwt.me/ghd/deb/ any main" > /etc/apt/sources.list.d/packagecloud-shiftkey-desktop.list'
sudo apt-get -y update
sudo apt-get -y install github-desktop

# Change autocomplete functionality
wget -O ~/.inputrc https://raw.githubusercontent.com/MagnusMat/Ubuntu-Setup/main/.inputrc
