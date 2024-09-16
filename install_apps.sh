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
    "arduino"
    "netbeans"
    "pycharm-community"
    "jupyter-notebook"
)

# Ferramentas Educacionais
edu_tools=(
    "gcompris"
    "geogebra-classic"
    "anki"
    "maxima"
    "stellarium"
    "ktouch"
    "klavaro"
    "scratch"
    "kturtle"
    "kgeography"
    "minuet"
    "blinken"
    "kstars"
    "ktechlab"
    "step"
    "marble"
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
    "convertall"
)

# Ferramentas de Utilidade e Outros
utility_tools=(
    "kmag"
    "sweet-home3d"
)

# Gerenciamento de Sistemas
sys_tools=(
    "htop"
    "veyon"
    "gnukhata"
)

# Instalação de Ferramentas de Desenvolvimento
echo "Instalando Ferramentas de Desenvolvimento..."
install_apps "${dev_tools[@]}"
create_desktop_entry "Git" "/usr/bin/git" "git" "Development"
create_desktop_entry "Curl" "/usr/bin/curl" "utilities-terminal" "Development"
create_desktop_entry "Visual Studio Code" "/usr/bin/code" "code" "Development"
create_desktop_entry "Arduino IDE" "/usr/bin/arduino" "arduino" "Development"
create_desktop_entry "Netbeans" "/usr/bin/netbeans" "netbeans" "Development"
create_desktop_entry "PyCharm" "/usr/bin/pycharm-community" "pycharm" "Development"
create_desktop_entry "Jupyter Notebook" "/usr/bin/jupyter-notebook" "jupyter" "Development"

# Instalação de Ferramentas Educacionais
echo "Instalando Ferramentas Educacionais..."
install_apps "${edu_tools[@]}"
create_desktop_entry "GCompris" "/usr/bin/gcompris" "gcompris" "Education"
create_desktop_entry "GeoGebra" "/usr/bin/geogebra" "geogebra" "Education"
create_desktop_entry "Anki" "/usr/bin/anki" "anki" "Education"
create_desktop_entry "KTurtle" "/usr/bin/kturtle" "kturtle" "Education"
create_desktop_entry "KGeography" "/usr/bin/kgeography" "kgeography" "Education"
create_desktop_entry "Minuet" "/usr/bin/minuet" "minuet" "Education"
create_desktop_entry "Blinken" "/usr/bin/blinken" "blinken" "Education"
create_desktop_entry "KStars" "/usr/bin/kstars" "kstars" "Science"
create_desktop_entry "KTechlab" "/usr/bin/ktechlab" "ktechlab" "Education"
create_desktop_entry "Step" "/usr/bin/step" "step" "Science"
create_desktop_entry "Marble" "/usr/bin/marble" "marble" "Education"

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
create_desktop_entry "Convertall" "/usr/bin/convertall" "convertall" "Utility"

# Instalação de Ferramentas de Utilidade e Outros
echo "Instalando Ferramentas de Utilidade..."
install_apps "${utility_tools[@]}"
create_desktop_entry "KMag" "/usr/bin/kmag" "kmag" "Utility"
create_desktop_entry "Sweet Home 3D" "/usr/bin/sweethome3d" "sweethome3d" "Graphics"

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
