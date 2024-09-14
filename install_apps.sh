#!/bin/bash

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then 
  echo "Por favor, execute como root"
  exit
fi

# Atualiza a lista de pacotes
echo "Atualizando lista de pacotes..."
sudo apt update

# Lista de aplicativos para instalar
apps=(
    "git"
    "curl"
    "vim"
    "htop"
    "gimp"
    "vlc"
    "docker.io"
    "python3-pip"
)

# Instala os aplicativos
echo "Instalando aplicativos..."
for app in "${apps[@]}"; do
    echo "Instalando $app..."
    sudo apt install -y $app
done

# Limpeza após a instalação
echo "Limpando pacotes desnecessários..."
sudo apt autoremove -y

echo "Instalação concluída!"
