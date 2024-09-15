#!/bin/bash

# Verifica se o script está sendo executado como root (UID 0 é do root)
if [ "$EUID" -ne 0 ]; then 
  echo "Por favor, execute como root"
  exit
fi

# Atualiza a lista de pacotes
echo "Atualizando lista de pacotes..."
sudo apt update

# Adiciona o repositório oficial do Visual Studio Code
echo "Adicionando repositório do Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

# Adiciona o repositório do GeoGebra
echo "Adicionando repositório do GeoGebra..."
sudo sh -c 'echo "deb http://www.geogebra.net/linux/ stable main" > /etc/apt/sources.list.d/geogebra.list'
wget -qO- https://static.geogebra.org/linux/office@geogebra.org.gpg.key | sudo apt-key add -

# Atualiza a lista de pacotes novamente após adicionar os novos repositórios
sudo apt update

# Lista de aplicativos para instalar
apps=(
    "git"                  # Ferramenta de controle de versão
    "curl"                 # Ferramenta para transferir dados de ou para um servidor
    "vim"                  # Editor de texto poderoso e amplamente utilizado
    "htop"                 # Monitor de processos interativo no terminal
    "gimp"                 # Editor de imagens avançado
    "vlc"                  # Reprodutor de mídia versátil
    "docker.io"            # Plataforma para automação de aplicativos usando containers
    "python3-pip"          # Gerenciador de pacotes para Python
    "code"                 # Visual Studio Code, editor de código poderoso
    "geogebra-classic"      # Aplicativo de matemática dinâmico, GeoGebra
    "anki"                 # Ferramenta de flashcards para auxiliar na memorização
    "artha"                # Tesauro offline baseado no WordNet
    "bibletime"            # Aplicativo de estudo bíblico
    "celestia"             # Simulação espacial 3D
    "chemtool"             # Programa para desenhar estruturas químicas
    "epoptes"              # Ferramenta de monitoramento de laboratórios de informática
    "gap"                  # Sistema de álgebra computacional
    "gcompris"             # Software educacional para crianças
    "gnome-dictionary"     # Dicionário para o ambiente GNOME
    "octave"               # Linguagem de programação científica compatível com MATLAB
    "gtypist"              # Instrutor de digitação em modo texto
    "gnukhata"             # Software de contabilidade
    "gperiodic"            # Tabela periódica para Linux
    "klavaro"              # Tutor de digitação
    "ktouch"               # Programa para aprender e praticar digitação
    "marble"               # Globo virtual e atlas mundial
    "maxima"               # Software de manipulação de expressões simbólicas e numéricas
    "stellarium"           # Planetário open-source
    "ugene"                # Software de bioinformática com GUI
    "veyon"                # Gerenciamento de computadores em sala de aula
)

# Instala os aplicativos
echo "Instalando aplicativos..."
for app in "${apps[@]}"; do
    echo "Instalando $app..."
    sudo apt install -y $app
done

# Aplicativos adicionais que exigem instalações manuais
echo "Instalando aplicativos adicionais..."

# Google Earth
echo "Instalando Google Earth..."
wget -q https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb
sudo apt install -y ./google-earth-pro-stable_current_amd64.deb
rm google-earth-pro-stable_current_amd64.deb

# Limpeza após a instalação
echo "Limpando pacotes desnecessários..."
sudo apt autoremove -y

echo "Instalação concluída!"
