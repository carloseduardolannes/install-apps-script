#!/bin/bash

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then 
  echo "Por favor, execute como root"  # Se não for root, exibe uma mensagem de erro.
  exit  # Sai do script se não for executado como root.
fi

# Atualiza a lista de pacotes
sudo apt update  # Atualiza o índice de pacotes disponíveis.

# Função para criar atalhos no menu principal
create_desktop_entry() {
    local name=$1     # Nome do aplicativo.
    local exec=$2     # Caminho do executável do aplicativo.
    local icon=$3     # Caminho do ícone do aplicativo.
    local category=$4 # Categoria para o menu principal.

    # Criando o arquivo .desktop
    echo "Criando atalho para $name..."  # Exibe mensagem de progresso.
    echo "[Desktop Entry]
Name=$name          # Nome que aparecerá no menu.
Exec=$exec          # Caminho do executável que será chamado ao clicar no atalho.
Icon=$icon          # Caminho do ícone que aparecerá no menu.
Type=Application    # Tipo do item, que será uma aplicação.
Categories=$category;  # Categoria do menu onde será adicionado.
" | sudo tee /usr/share/applications/${name,,}.desktop > /dev/null  # Cria o arquivo .desktop com as informações acima.
}

# Função para instalar os aplicativos
install_apps() {
    local category=("$@")  # Recebe os aplicativos a serem instalados como argumentos.
    for app in "${category[@]}"; do  # Itera sobre cada aplicativo.
        echo "Instalando $app..."  # Exibe mensagem de progresso.
        sudo apt install -y $app  # Instala o aplicativo usando apt sem pedir confirmação.
    done
}

# Listas de aplicativos categorizadas

# Ferramentas de Desenvolvimento
dev_tools=(
    "git"                  # Sistema de controle de versões.
    "curl"                 # Ferramenta de transferência de dados.
    "vim"                  # Editor de texto.
    "docker.io"            # Plataforma de containerização.
    "python3-pip"          # Gerenciador de pacotes para Python.
    "code"                 # Visual Studio Code, IDE para desenvolvimento.
    "arduino"              # IDE para programação de placas Arduino.
    "netbeans"             # IDE para desenvolvimento em várias linguagens.
    "pycharm-community"    # IDE PyCharm, versão gratuita.
    "jupyter-notebook"     # Ferramenta interativa para Python e outras linguagens.
    "putty"                # Cliente SSH e telnet.
    "android-studio"       # IDE para desenvolvimento Android.
)

# Ferramentas Educacionais
edu_tools=(
    "gcompris"             # Suíte educacional para crianças.
    "geogebra-classic"     # Ferramenta de matemática para gráficos e álgebra.
    "anki"                 # Aplicativo de cartões de memorização.
    "maxima"               # Sistema de álgebra computacional.
    "stellarium"           # Simulador de planetário.
    "ktouch"               # Programa para aprender digitação.
    "klavaro"              # Tutor de digitação.
    "scratch"              # Ferramenta de programação para iniciantes.
    "kturtle"              # Ambiente de programação educacional.
    "kgeography"           # Aplicativo de aprendizado de geografia.
    "minuet"               # Aplicativo de teoria musical.
    "blinken"              # Jogo educacional baseado em padrões de som e cores.
    "kstars"               # Planetário para observação astronômica.
    "ktechlab"             # Simulador de circuitos eletrônicos.
    "step"                 # Simulador de física.
    "marble"               # Globo virtual interativo.
)

# Aplicativos Científicos
science_tools=(
    "octave"               # Ferramenta para cálculos numéricos.
    "celestia"             # Simulador de espaço em 3D.
    "chemtool"             # Ferramenta para desenhar estruturas químicas.
    "gperiodic"            # Tabela periódica.
    "gap"                  # Sistema para álgebra computacional.
    "ugene"                # Ferramenta para bioinformática.
)

# Ferramentas de Estudo e Pesquisa
study_tools=(
    "bibletime"            # Aplicativo de estudo bíblico.
    "artha"                # Dicionário offline baseado no WordNet.
    "gnome-dictionary"     # Dicionário para o ambiente GNOME.
    "convertall"           # Conversor de unidades.
)

# Ferramentas de Utilidade e Outros
utility_tools=(
    "kmag"                 # Lupa para a área de trabalho.
    "sweet-home3d"         # Aplicativo para modelagem de interiores.
    "anbox"                # Executa aplicativos Android no Linux.
    "google-chrome-stable" # Navegador web Google Chrome.
)

# Ferramentas de Escritório
office_tools=(
    "libreoffice"          # Suíte de escritório.
)

# Gerenciamento de Sistemas
sys_tools=(
    "htop"                 # Monitor do sistema em terminal.
    "veyon"                # Ferramenta de controle de laboratórios de informática.
    "gnukhata"             # Sistema de contabilidade.
)

# Instalação de Ferramentas de Desenvolvimento
echo "Instalando Ferramentas de Desenvolvimento..."
install_apps "${dev_tools[@]}"  # Chama a função para instalar a lista de ferramentas de desenvolvimento.
# Cria atalhos para Ferramentas de Desenvolvimento
create_desktop_entry "Git" "/usr/bin/git" "git" "Development"
create_desktop_entry "Curl" "/usr/bin/curl" "utilities-terminal" "Development"
create_desktop_entry "Visual Studio Code" "/usr/bin/code" "code" "Development"
create_desktop_entry "Arduino IDE" "/usr/bin/arduino" "arduino" "Development"
create_desktop_entry "Netbeans" "/usr/bin/netbeans" "netbeans" "Development"
create_desktop_entry "PyCharm" "/usr/bin/pycharm-community" "pycharm" "Development"
create_desktop_entry "Jupyter Notebook" "/usr/bin/jupyter-notebook" "jupyter" "Development"
create_desktop_entry "PuTTY" "/usr/bin/putty" "putty" "Development"
create_desktop_entry "Android Studio" "/usr/bin/android-studio" "android-studio" "Development"

# Instalação de Ferramentas Educacionais
echo "Instalando Ferramentas Educacionais..."
install_apps "${edu_tools[@]}"  # Instala a lista de ferramentas educacionais.
# Cria atalhos para Ferramentas Educacionais
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
install_apps "${science_tools[@]}"  # Instala os aplicativos científicos.
# Cria atalhos para Aplicativos Científicos
create_desktop_entry "Octave" "/usr/bin/octave" "octave" "Science"
create_desktop_entry "Celestia" "/usr/bin/celestia" "celestia" "Science"
create_desktop_entry "Chemtool" "/usr/bin/chemtool" "chemtool" "Science"

# Instalação de Ferramentas de Estudo e Pesquisa
echo "Instalando Ferramentas de Estudo e Pesquisa..."
install_apps "${study_tools[@]}"  # Instala as ferramentas de estudo.
# Cria atalhos para Ferramentas de Estudo e Pesquisa
create_desktop_entry "BibleTime" "/usr/bin/bibletime" "bibletime" "Education"
create_desktop_entry "Artha" "/usr/bin/artha" "artha" "Education"
create_desktop_entry "Gnome Dictionary" "/usr/bin/gnome-dictionary" "accessories-dictionary" "Utility"
create_desktop_entry "Convertall" "/usr/bin/convertall" "convertall" "Utility"

# Instalação de Ferramentas de Utilidade e Outros
echo "Instalando Ferramentas de Utilidade..."
install_apps "${utility_tools[@]}"  # Instala as ferramentas de utilidade.
# Cria atalhos para Ferramentas de Utilidade
create_desktop_entry "KMag" "/usr/bin/kmag" "kmag" "Utility"
create_desktop_entry "Sweet Home 3D" "/usr/bin/sweethome3d" "sweethome3d" "Graphics"
create_desktop_entry "Anbox" "/usr/bin/anbox" "anbox" "Utility"
create_desktop_entry "Google Chrome" "/usr/bin/google-chrome-stable" "google-chrome" "Internet"

# Instalação de Ferramentas de Escritório
echo "Instalando Ferramentas de Escritório..."
install_apps "${office_tools[@]}"  # Instala o LibreOffice.
# Cria atalhos para Ferramentas de Escritório
create_desktop_entry "LibreOffice" "/usr/bin/libreoffice" "libreoffice" "Office"

# Instalação de Ferramentas de Gerenciamento de Sistemas
echo "Instalando Ferramentas de Gerenciamento de Sistemas..."
install_apps "${sys_tools[@]}"  # Instala as ferramentas de sistema.
# Cria atalhos para Ferramentas de Gerenciamento de Sistemas
create_desktop_entry "Htop" "/usr/bin/htop" "utilities-system-monitor" "System"
create_desktop_entry "Veyon" "/usr/bin/veyon" "veyon" "System"

# Instalação de aplicativos adicionais
echo "Instalando Google Earth..."
wget -q https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb  # Baixa o pacote Google Earth.
sudo apt install -y ./google-earth-pro-stable_current_amd64.deb  # Instala o Google Earth.
rm google-earth-pro-stable_current_amd64.deb  # Remove o arquivo .deb após a instalação.
create_desktop_entry "Google Earth" "/usr/bin/google-earth-pro" "google-earth" "Science"  # Cria o atalho para o Google Earth.

# Limpeza após a instalação
sudo apt autoremove -y  # Remove pacotes desnecessários após a instalação.

echo "Instalação concluída!"  # Exibe uma mensagem indicando o término do processo.
