#!/bin/bash

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then 
  echo "Por favor, execute como root"
  exit
fi

# Atualiza a lista de pacotes
sudo apt update

# Função para criar atalhos no menu principal
create_desktop_entry() {
    local name=$1
    local exec=$2
    local icon=$3
    local category=$4

    # Criando o arquivo .desktop
    echo "Criando atalho para $name..."
    echo "[Desktop Entry]
Name=$name
Exec=$exec
Icon=$icon
Type=Application
Categories=$category;
" | sudo tee /usr/share/applications/${name,,}.desktop > /dev/null
}

# Instala os aplicativos
install_apps() {
    local category=("$@")
    for app in "${category[@]}"; do
        echo "Instalando $app..."
        sudo apt install -y $app
    done
}

# Ferramentas de Desenvolvimento
dev_tools=(
    "git"
    "curl"
    "vim"
    "docker.io"
    "python3-pip"
    "code"
)

# Ferramentas Educacionais
edu_tools=(
    "geogebra-classic"
    "anki"
    "gcompris"
    "maxima"
    "stellarium"
    "ktouch"
    "klavaro"
)

# Aplicativos Científicos
science_tools=(
    "octave"
    "celestia"
    "chemtool"
    "gperiodic"
    "gap"
    "ugene"
)

# Ferramentas de Estudo e Pesquisa
study_tools=(
    "bibletime"
    "artha"
    "gnome-dictionary"
)

# Gerenciamento de Sistemas
sys_tools=(
    "htop"
    "veyon"
    "gnukhata"
    "epoptes"
)

# Instalação de Ferramentas de Desenvolvimento
echo "Instalando Ferramentas de Desenvolvimento..."
install_apps "${dev_tools[@]}"
create_desktop_entry "Git" "/usr/bin/git" "git" "Development"
create_desktop_entry "Curl" "/usr/bin/curl" "utilities-terminal" "Development"
create_desktop_entry "Visual Studio Code" "/usr/bin/code" "code" "Development"

# Instalação de Ferramentas Educacionais
echo "Instalando Ferramentas Educacionais..."
install_apps "${edu_tools[@]}"
create_desktop_entry "GeoGebra" "/usr/bin/geogebra" "geogebra" "Education"
create_desktop_entry "Anki" "/usr/bin/anki" "anki" "Education"
create_desktop_entry "GCompris" "/usr/bin/gcompris" "gcompris" "Education"

# Instalação de Aplicativos Científicos
echo "Instalando Aplicativos Científicos..."
install_apps "${science_tools[@]}"
create_desktop_entry "Octave" "/usr/bin/octave" "octave" "Science"
create_desktop_entry "Celestia" "/usr/bin/celestia" "celestia" "Science"
create_desktop_entry "Chemtool" "/usr/bin/chemtool" "chemtool" "Science"

# Instalação de Ferramentas de Estudo e Pesquisa
echo "Instalando Ferramentas de Estudo e Pesquisa..."
install_apps "${study_tools[@]}"
create_desktop_entry "BibleTime" "/usr/bin/bibletime" "bibletime" "Education"
create_desktop_entry "Artha" "/usr/bin/artha" "artha" "Education"
create_desktop_entry "Gnome Dictionary" "/usr/bin/gnome-dictionary" "accessories-dictionary" "Utility"

# Instalação de Ferramentas de Gerenciamento de Sistemas
echo "Instalando Ferramentas de Gerenciamento de Sistemas..."
install_apps "${sys_tools[@]}"
create_desktop_entry "Htop" "/usr/bin/htop" "utilities-system-monitor" "System"
create_desktop_entry "Veyon" "/usr/bin/veyon" "veyon" "System"

# Instalação de aplicativos adicionais
echo "Instalando Google Earth..."
wget -q https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb
sudo apt install -y ./google-earth-pro-stable_current_amd64.deb
rm google-earth-pro-stable_current_amd64.deb
create_desktop_entry "Google Earth" "/usr/bin/google-earth-pro" "google-earth" "Science"

# Limpeza após a instalação
sudo apt autoremove -y

echo "Instalação concluída!"
