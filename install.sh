#!/bin/bash -i
#atualizando os pacotes
#-----------------------------------------------------------------------
{ #try
    sudo apt update && sudo apt dist-upgrade -y
} || { #catch
    echo Desculpe, não foi possível concluir a atualização dos pacotes. Resolve esse problema e então tente novamente!
    exit 0
}
#instalando os programas
#-----------------------------------------------------------------------
#instalando o git, caso não esteja instalado
sudo apt install git -y

#instalando o curl
sudo apt install curl -y 

#instalando o snap
sudo apt install snapd -y

#instalando o vim
sudo apt install vim -y

#instalando o flameshot
sudo apt install flameshot -y

#instalando o Discord
cd ~/Downloads
wget -O "discord.deb" 'https://discordapp.com/api/download?platform=linux&format=deb'
sudo dpkg -i discord.deb
sudo apt install -f -y

#instalando o Reactotron
wget -O "reactotron.deb" 'https://github.com/infinitered/reactotron/releases/download/v2.17.1/reactotron-app_2.17.1_amd64.deb'
sudo dpkg -i reactotron.deb
sudo apt install -f -y

#instalando o vscode
wget -O "vscode.deb" 'https://az764295.vo.msecnd.net/stable/c47d83b293181d9be64f27ff093689e8e7aed054/code_1.42.1-1581432938_amd64.deb'
sudo dpkg -i vscode.deb
sudo apt install -f -y

#instalando o Google Chrome
wget -O "chrome.deb" 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
sudo dpkg -i chrome.deb
sudo apt install -f -y

#instalando o Slack
sudo snap install slack --classic

#instalando o insomnia
sudo snap install insomnia

#instalando o postbird
sudo snap install postbird

#instalando o Spotify
sudo snap install spotify

#instalando o NodeJS
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
source ~/.bashrc
nvm install --lts

#instalando o yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn

#instalando o Canta theme 
sudo apt-get install gtk2-engines-murrine gtk2-engines-pixbuf -y
git clone https://github.com/vinceliuice/Canta-theme.git
sudo add-apt-repository ppa:numix/ppa
sudo apt update
sudo apt install numix-icon-theme-circle -y
cd Canta-theme/
./install.sh -i

#instalando o Peek
sudo add-apt-repository ppa:peek-developers/stable -y
sudo apt update
sudo apt install peek

#instalando o docker
sudo snap install docker
sudo snap enable docker
sudo groupadd docker
sudo usermod -aG docker $USER

#atualizando todos os pacotes
#-----------------------------------------------------------------------
sudo apt update && sudo apt dist-upgrade -y
sudo apt install -f -y
echo "Instalações terminadas com sucesso! Divirta-se"
echo "Seu computador será reiniciado em instantes"
sleep 3s
sudo reboot

