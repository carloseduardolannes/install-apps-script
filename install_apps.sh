#!/bin/bash

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then 
  echo "Por favor, execute como root"  # Se o usuário não for root, exibe uma mensagem de erro
  exit  # Sai do script se não for root
fi

# Atualiza a lista de pacotes
sudo apt update  # Atualiza a lista de pacotes disponíveis para garantir que estamos instalando as versões mais recentes

# Função para instalar os aplicativos
install_apps() {
    local category=("$@")  # Recebe a lista de aplicativos a serem instalados como argumento
    for app in "${category[@]}"; do  # Itera sobre cada aplicativo na lista
        echo "Instalando $app..."  # Exibe uma mensagem indicando o aplicativo que está sendo instalado
        sudo apt install -y $app  # Instala o aplicativo usando o apt; -y confirma automaticamente a instalação
    done
}

# Categorias de aplicativos
dev_tools=("git" "python3" "arduino" "netbeans" "pycharm" "jupyter-notebook")  # Lista de ferramentas de desenvolvimento
edu_tools=("gcompris" "kturtle" "kgeography" "minuet" "blinken" "kstars" "ktechlab" "step" "marble" "geogebra" "maxima" "gnu-typist" "anki" "celestia" "chemtool" "gperiodic" "scipy" "scratch")  # Lista de ferramentas educacionais
sys_tools=("htop" "veyon" "putty")  # Lista de ferramentas de gerenciamento de sistemas
utility_tools=("kmag" "convertall" "sweethome3d" "anbox")  # Lista de ferramentas de utilidade
office_tools=("libreoffice")  # Lista de ferramentas de escritório
internet_tools=("google-chrome-stable" "android-studio")  # Lista de ferramentas de internet

# Instalação de Ferramentas de Desenvolvimento
echo "Instalando Ferramentas de Desenvolvimento..."  # Exibe uma mensagem indicando que a instalação das ferramentas de desenvolvimento está começando
install_apps "${dev_tools[@]}"  # Chama a função install_apps para instalar os aplicativos listados em dev_tools

# Instalação de Ferramentas Educacionais
echo "Instalando Ferramentas Educacionais..."  # Exibe uma mensagem indicando que a instalação das ferramentas educacionais está começando
install_apps "${edu_tools[@]}"  # Chama a função install_apps para instalar os aplicativos listados em edu_tools

# Instalação de Ferramentas de Utilidade
echo "Instalando Ferramentas de Utilidade..."  # Exibe uma mensagem indicando que a instalação das ferramentas de utilidade está começando
install_apps "${utility_tools[@]}"  # Chama a função install_apps para instalar os aplicativos listados em utility_tools

# Instalação de Ferramentas de Escritório
echo "Instalando Ferramentas de Escritório..."  # Exibe uma mensagem indicando que a instalação das ferramentas de escritório está começando
install_apps "${office_tools[@]}"  # Chama a função install_apps para instalar os aplicativos listados em office_tools

# Instalação de Ferramentas de Gerenciamento de Sistemas
echo "Instalando Ferramentas de Gerenciamento de Sistemas..."  # Exibe uma mensagem indicando que a instalação das ferramentas de gerenciamento de sistemas está começando
install_apps "${sys_tools[@]}"  # Chama a função install_apps para instalar os aplicativos listados em sys_tools

# Instalação de aplicativos adicionais (Google Earth)
echo "Instalando Google Earth..."  # Exibe uma mensagem indicando que a instalação do Google Earth está começando
wget -q https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb  # Baixa o pacote .deb do Google Earth de forma silenciosa
sudo apt install -y ./google-earth-pro-stable_current_amd64.deb  # Instala o pacote .deb do Google Earth usando o apt; -y confirma automaticamente a instalação
rm google-earth-pro-stable_current_amd64.deb  # Remove o arquivo .deb após a instalação para liberar espaço

# Instalação de Veyon e configuração de Wayland
echo "Instalando Veyon..."  # Exibe uma mensagem indicando que a instalação do Veyon está começando
sudo apt install -y veyon  # Instala o Veyon usando o apt; -y confirma automaticamente a instalação

# Edita o arquivo custom.conf para desativar o Wayland e configurar o login automático
echo "Configurando /etc/gdm3/custom.conf..."  # Exibe uma mensagem indicando que a configuração do arquivo custom.conf está começando

# Desativa o Wayland
sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf  # Descomenta e ajusta a linha para desativar o Wayland

# Habilita o login automático
sudo sed -i 's/#  AutomaticLoginEnable = true/AutomaticLoginEnable = true/' /etc/gdm3/custom.conf  # Descomenta e ajusta a linha para habilitar o login automático
sudo sed -i 's/#  AutomaticLogin = user/AutomaticLogin = dev/' /etc/gdm3/custom.conf  # Descomenta e ajusta a linha para definir o usuário dev para login automático

# Reinicia o GDM para aplicar as mudanças
echo "Reiniciando o GDM para aplicar as configurações..."  # Exibe uma mensagem indicando que o GDM será reiniciado para aplicar as mudanças
sudo systemctl restart gdm3  # Reinicia o serviço GDM para que as mudanças na configuração entrem em vigor

# Limpeza após a instalação
sudo apt autoremove -y  # Remove pacotes desnecessários que foram instalados como dependências e não são mais necessários; -y confirma automaticamente a remoção

echo "Instalação concluída!"  # Exibe uma mensagem indicando que a instalação foi concluída com sucesso