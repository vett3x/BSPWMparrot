#!/bin/bash

if [ "$(whoami)" == "root" ]; then
    exit 1
fi

ruta=$(pwd)

# Actualizando el sistema

sudo apt update

sudo parrot-upgrade

# Instalando dependencias de Entorno

sudo apt install -y build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev

# Instalando Requerimientos para la polybar

sudo apt install -y cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libuv1-dev libnl-genl-3-dev

# Dependencias de Picom

sudo apt install -y meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev libpcre3 libpcre3-dev

# Instalamos paquetes adionales

sudo apt install -y feh scrot scrub zsh rofi xclip bat locate neofetch wmname acpi bspwm sxhkd imagemagick ranger kitty

# Creando carpeta de Reposistorios

mkdir ~/github

# Descargar Repositorios Necesarios

cd ~/github
git clone --recursive https://github.com/polybar/polybar
git clone https://github.com/ibhagwan/picom.git

# Instalando Polybar

cd ~/github/polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install

# Instalando Picom

cd ~/github/picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

# Instalando p10k

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Instalando p10k root

sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k

# Configuramos el tema Nord de Rofi:

mkdir -p ~/.config/rofi/themes
cp $ruta/rofi/nord.rasi ~/.config/rofi/themes/

# Instando lsd

sudo dpkg -i $ruta/lsd.deb

# Instalamos las HackNerdFonts

sudo cp -v $ruta/fonts/HNF/* /usr/local/share/fonts/

# Instalando Fuentes de Polybar

sudo cp -v $ruta/Config/polybar/fonts/* /usr/share/fonts/truetype/

# Instalando Wallpaper de S4vitar

mkdir ~/Wallpaper
cp -v $ruta/Wallpaper/* ~/Wallpaper
mkdir ~/ScreenShots

# Copiando Archivos de Configuración

cp -rv $ruta/Config/* ~/.config/
sudo cp -rv $ruta/kitty /opt/

# Kitty Root

sudo cp -rv $ruta/Config/kitty /root/.config/

# Copia de configuracion de .p10k.zsh y .zshrc

rm -rf ~/.zshrc
cp -v $ruta/.zshrc ~/.zshrc

cp -v $ruta/.p10k.zsh ~/.p10k.zsh
sudo cp -v $ruta/.p10k.zsh-root /root/.p10k.zsh

# Script

sudo cp -v $ruta/scripts/whichSystem.py /usr/local/bin/
sudo cp -v $ruta/scripts/screenshot /usr/local/bin/

# Plugins ZSH

sudo apt install -y zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplete
sudo mkdir /usr/share/zsh-sudo
cd /usr/share/zsh-sudo
sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh

# Cambiando de SHELL a zsh

chsh -s /usr/bin/zsh
sudo usermod --shell /usr/bin/zsh root
sudo ln -s -fv ~/.zshrc /root/.zshrc

# Asignamos Permisos a los Scritps

chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/scripts/bspwm_resize
chmod +x ~/.config/bin/ethernet_status.sh
chmod +x ~/.config/bin/htb_status.sh
chmod +x ~/.config/bin/htb_target.sh
chmod +x ~/.config/polybar/launch.sh
sudo chmod +x /usr/local/bin/whichSystem.py
sudo chmod +x /usr/local/bin/screenshot

# Fix archivos inseguros de zsh
sudo chown -R root:root /usr/local/share/zsh/site-functions

# Configuramos el Tema de Rofi

rofi-theme-selector

# Configurando Neovim con NVChad

sudo apt install npm -y
cd ~/Descargas
wget "https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz"
sudo rm -r ~/.config/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
cd /opt/
sudo mv ~/Descargas/nvim-linux64.tar.gz .
sudo tar -xf nvim-linux64.tar.gz
sudo rm nvim-linux64.tar.gz
cd /opt/nvim-linux64/bin
sudo ./nvim

# Instalando flameshot
sudo apt install flameshot -y

# Instalando CTFR
sudo apt install python -y
mkdir ~/Herramientas
cd ~/Herramientas
git clone https://github.com/UnaPibaGeek/ctfr.git
cd ctfr
sudo pip3 install -r requirements.txt

# Instalando ffuf (https://github.com/ffuf/ffuf)
cd ~/Herramientas
git clone https://github.com/ffuf/ffuf
cd ffuf
go get
go build

# Instalando CrackMapExec
# https://github.com/mpgn/CrackMapExec y https://wiki.porchetta.industries/
sudo python3 -m pip install pipx
cd ~/Herramientas
sudo git clone https://github.com/mpgn/CrackMapExec
cd CrackMapExec
sudo pipx install .

# Instalar SecList (Diccionarios)
cd /usr/share/
sudo git clone https://github.com/danielmiessler/SecLists.git

# Instalando Gotop
cd ~/Herramientas
git clone --depth 1 https://github.com/cjbassi/gotop
sudo ~/Herramientas/gotop/scripts/download.sh

# Instalando Docker.io
sudo apt install docker.io -y
sudo apt install docker-compose -y

# Instalando cifs-utils (Monturas)
sudo apt install cifs-utils -y

# Removiendo Repositorio

rm -rf ~/github
rm -rf $ruta

# Mensaje de Instalado

notify-send "BSPWM INSTALADO"
