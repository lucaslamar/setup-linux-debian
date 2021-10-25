#!/bin/bash -i
#updating packages
#-----------------------------------------------------------------------
{ #try
    sudo apt update && sudo apt dist-upgrade -y
} || { #catch
    echo Sorry, we could not update update the packages in your system. Solve this issue and try again!
    exit 0
}
#installing the programs
#-----------------------------------------------------------------------
#installing basic programs
echo "Installing the basic programs:"
echo "-----------------------------------------------"
sudo apt install git -y

#installing curl
sudo apt install curl -y 

#installing snap
sudo apt install snapd -y

#installing vim
sudo apt install vim -y
echo "-----------------------------------------------"

#interaction screen for choosing the programs to be installed
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
               microsoft-teams "Microsoft's business communication platform" on \
               docker "For virtualization" on \
               docker-composer "Orchestrate your Docker containers" on \
	       bottom "A custom graphical process/system monitor" on \
	       ulauncher "A launcher for Linux" on \
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
         sudo snap install slack --classic </dev/tty
         ;;
      insomnia)
         sudo snap install insomnia </dev/tty
         ;;
      postman)
         sudo snap install postman </dev/tty
         ;;
      spotify)
         sudo snap install spotify </dev/tty
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
         sudo add-apt-repository ppa:numix/ppa -y
         sudo apt update
         sudo apt install numix-icon-theme -y
         cd Canta-theme/
         ./install.sh -i
         cd -
         ;;
      peek)
         sudo add-apt-repository ppa:peek-developers/stable -y
         sudo apt update
         sudo apt install peek -y
         ;;
      dbeaver)
         wget -c https://dbeaver.io/files/6.0.0/dbeaver-ce_6.0.0_amd64.deb
         sudo dpkg -i dbeaver-ce_6.0.0_amd64.deb
         sudo apt-get install -f
         ;;
      microsoft-teams)
         sudo snap install teams </dev/tty
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
      bottom)
	 curl -LO https://github.com/ClementTsang/bottom/releases/download/0.6.4/bottom_0.6.4_amd64.deb
	 sudo dpkg -i bottom_0.6.4_amd64.deb
	 ;;
      ulauncher)
	 sudo add-apt-repository ppa:agornostal/ulauncher -y
	 sudo apt update
	 sudo apt install ulauncher -y
	 ;;
      git-config)
         echo "What name do you want to use in GIT user.name?"
         echo "For example, mine will be \"Bruce Wayne\""
         read git_config_user_name </dev/tty
         git config --global user.name "$git_config_user_name"
         echo "What email do you want to use in GIT user.email?"
         echo "For example, mine will be \"bruce.wayne@wayneenterprises.com\""
         read git_config_user_email </dev/tty
         git config --global user.email $git_config_user_email
         echo "Generating a SSH Key"
         ssh-keygen -t rsa -b 4096 -C $git_config_user_email </dev/tty
         ssh-add ~/.ssh/id_rsa
         sudo apt install xclip
         clear
         echo "Generated SSH:"
         echo "-----------------------------------------------------"
         cat ~/.ssh/id_rsa.pub | xclip -selection clipboard
         echo "-----------------------------------------------------"
         sudo apt remove xclip
         ;;
   esac
done < "$filename"

#updating all packages
#-----------------------------------------------------------------------
sudo apt update && sudo apt dist-upgrade -y
sudo apt install -f -y
echo "Installations completed successfully! Have fun :D"
echo "Your computer will restart in 5 seconds"
echo "Do you want to restart your computer? <1 for yes, 0 for no>"
read restart </dev/tty
if [[ $restart -eq 1 ]]
then
   echo "Your computer is restarting"
   sleep 5s
   sudo reboot
fi
echo "See you next time!"
