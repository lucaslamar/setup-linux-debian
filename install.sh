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
echo "Instalando os programas básicos:"
echo "-----------------------------------------------"
sudo apt install git -y

#instalando o curl
sudo apt install curl -y 

#instalando o snap
sudo apt install snapd -y

#instalando o vim
sudo apt install vim -y
echo "-----------------------------------------------"

#tela de interação para a escolha dos programas a serem instalados
whiptail --checklist --separate-output "Uncheck the programs you don't want to install by pressing <space> for checking/unchecking, <tab> for ok and cancel options and press <enter> for your desired action" 15 80 5\
               discord "For voicechatting" on \
               flameshot "Get some good screenshots" on \
               reactotron "React debugger" on \
               vscode "Text Editor" on \
               google-chrome "Web browser" on \
               slack "Chat with your team" on \
               insomnia "Create requests for your RESTful apps" on \
               postman "Another program for api tests, just like insomnia" on \
               spotify "Listen to music" on \
               nodejs-lts "Use NPM package manager and code in NodeJS" on \
               yarn "Another package manager" on \
               canta-theme "Custom theme for Linux" on \
               peek "Record your screen" on \
               dbeaver "Connect and explore different databases" on \
               docker "For virtualization" on \
               docker-composer "Orchestrate your Docker containers" on \
               git-config "configure your git with a SSH key" on 2>programchoice.txt


filename="programchoice.txt"
while read -r line; do
    name="$line"
    echo "-----------------------------------------"
    echo "Installing the following program: $name"
    echo "-----------------------------------------"
    case $line in
      discord)
         cd ~/Downloads
         wget -O "discord.deb" 'https://discordapp.com/api/download?platform=linux&format=deb'
         sudo dpkg -i discord.deb
         sudo apt install -f -y
         cd -
         ;;
      flameshot)
         sudo apt install flameshot -y
         ;;
      reactotron)
         wget -O "reactotron.deb" 'https://github.com/infinitered/reactotron/releases/download/v2.17.1/reactotron-app_2.17.1_amd64.deb'
         sudo dpkg -i reactotron.deb
         sudo apt install -f -y
         ;;
      vscode)
         wget -O "vscode.deb" 'https://az764295.vo.msecnd.net/stable/c47d83b293181d9be64f27ff093689e8e7aed054/code_1.42.1-1581432938_amd64.deb'
         sudo dpkg -i vscode.deb
         sudo apt install -f -y
         ;;
      google-chrome)
         wget -O "chrome.deb" 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
         sudo dpkg -i chrome.deb
         sudo apt install -f -y
         ;;
      slack)
         sudo snap install slack --classic
         ;;
      insomnia)
         sudo snap install insomnia
         ;;
      postman)
         sudo snap install postman
         ;;
      spotify)
         sudo snap install spotify
         ;;
      nodejs-lts)
         wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
         source ~/.bashrc
         nvm install --lts
         ;;
      yarn)
         curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
         echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
         sudo apt update && sudo apt install yarn
         ;;
      canta-theme)
         sudo apt-get install gtk2-engines-murrine gtk2-engines-pixbuf -y
         git clone https://github.com/vinceliuice/Canta-theme.git
         sudo add-apt-repository ppa:numix/ppa
         sudo apt update
         sudo apt install numix-icon-theme-circle -y
         cd Canta-theme/
         ./install.sh -i
         cd -
         ;;
      peek)
         sudo add-apt-repository ppa:peek-developers/stable -y
         sudo apt update
         sudo apt install peek
         ;;
      dbeaver)
         wget -c https://dbeaver.io/files/6.0.0/dbeaver-ce_6.0.0_amd64.deb
         sudo dpkg -i dbeaver-ce_6.0.0_amd64.deb
         sudo apt-get install -f
         ;;
      docker)
         curl -fsSL https://get.docker.com -o get-docker.sh
         sudo sh get-docker.sh
         sudo usermod -aG docker $USER
         ;;
      docker-composer)
         sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
         sudo chmod +x /usr/local/bin/docker-compose
         ;;
      git-config)
         echo "What name do you want to use in GIT user.name?"
         echo "For example, mine will be \"Bruce Wayne\""
         read git_config_user_name
         git config --global user.name "$git_config_user_name"
         clear 
         echo "What email do you want to use in GIT user.email?"
         echo "For example, mine will be \"bruce.wayne@wayneenterprises.com\""
         read git_config_user_email
         git config --global user.email $git_config_user_email
         echo "Generating a SSH Key"
         ssh-keygen -t rsa -b 4096 -C $git_config_user_email
         ssh-add ~/.ssh/id_rsa
         cat ~/.ssh/id_rsa.pub | xclip -selection clipboard
         ;;
   esac
done < "$filename"

#atualizando todos os pacotes
#-----------------------------------------------------------------------
sudo apt update && sudo apt dist-upgrade -y
sudo apt install -f -y
echo "Instalações terminadas com sucesso! Divirta-se"
echo "Seu computador será reiniciado em instantes"
sleep 3s
sudo reboot