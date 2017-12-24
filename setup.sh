#!/bin/bash

# Setup necessary dev tools

set -e

usage() {
  printf "Usage: $0\n \
    [ -h print usage ]\n \
    [ -e your_github_email@place.tld ]\n"
  exit
}

if [ "$#" -eq 0 ]; then
  usage
fi

while getopts ":e:h" opt; do
  case ${opt} in
    e ) github_email="$OPTARG"
      ;;
    h ) usage
      ;;
    \? ) echo "Invalid option: -$OPTARG" 1>&2 && usage
      ;;
    : ) echo "Error: -$OPTARG requires an argument" 1>&2 && usage
      ;;
  esac
done
shift $((OPTIND -1))

control_c()
{
  echo -en "\nsetup cancelled\n"
  exit
}

# trap keyboard interrupt (control-c)
trap control_c SIGINT

# Create an ssh key for github
ssh-keygen -t rsa -b 4096 -C "$github_email"
eval "$(ssh-agent -s)"
ssh-add -K $HOME/.ssh/id_rsa
pbcopy < $HOME/.ssh/id_rsa.pub

echo "A new ssh key has been copied to the clipboard, printing too just in case"
cat $HOME/.ssh/id_rsa.pub

read -p "Add the ssh key to your GitHub profile and press enter when complete"

# Create dev dir structure and clone env repo
mkdir $HOME/Developer && mkdir $HOME/Developer/GitHub
cd $HOME/Developer/GitHub

git clone git@github.com:jbaskeen/perivallon.git && cd perivallon

# list available software updates
softwareupdate -l

# Install xcode cli tools
sudo xcodebuild -license
xcode-select --install
open -a Xcode

read -p "Xcode has been opened to ensure CLI tools are installed. If you're promopted to install Xcode tools do so then press Enter when complete"

chown -R "`whoami`":admin /usr/local/bin
chown -R "`whoami`":admin /usr/local/share
chown -R "`whoami`":admin /usr/local/include

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew --version

# Install brew packages
declare -a brewskies=(
  "ack"
  "android-sdk"
  "android-ndk"
  "ant"
  "autoconf"
  "automake"
  "babel"
  "bash"
  "cask"
  "gawk"
  "git"
  "gnu-sed"
  "go"
  "gpg"
  "gradle"
  "hub"
  "imagemagick"
  "jq"
  "kubectl"
  "maven"
  "neovim"
  "nmap"
  "node"
  "python"
  "python3"
  "ruby"
  "shellcheck"
  "ssh-copy-id"
  "the_silver_searcher"
  "tmux"
  "tree"
  "unrar"
  "vim"
  "watch"
  "watchman"
  "webpack"
  "wget"
  "zsh"
)

for cold_one in "${brewskies[@]}"; do
  brew install "$cold_one"
done

declare -a casks=(
  "1password"
  "atom"
  "android-studio"
  "docker-toolbox"
  "docker"
  "dropbox"
  "firefox"
  "google-chrome"
  "insomnia"
  "intel-haxm"
  "iterm2"
  "java"
  "minikube"
  "postman"
  "slack"
  "virtualbox"
  "vlc"
)

for casket in "${casks[@]}"; do
  brew cask install "$casket"
done

# Update bash
sudo -s
echo /usr/local/bin/bash >> /etc/shells
chsh -s /usr/local/bin/bash

# Install custom gems
which gem
sudo gem update --system

sudo gem install travis

# Install node version manager
npm i -g n
n 6 -d
n 7 -d
n 8 -d
n 9 -d
n use 8

# React native
npm install -g react-native-cli
npm install -g create-react-native-app

# gitbook-cli init b/c it's PoS
npm i -g gitbook-cli@2.3.1

cd /usr/local/lib/node_modules/gitbook-cli
rm -rf node_modules
sed -i '' "s^npmi@2.0.1^npmi@1.0.1^g" package.json
npm i

cd ~

gitbook fetch 3.2.2
cd $HOME/.gitbook/versions/3.2.2/
rm -rf node_modules
npm i

# setup atom
which atom

declare -a atoms=(
  "atom-beautify"
  "atom-clock"
  "atom-shell-commands"
  "atom-typescript"
  "autocomplete-bash-builtins"
  "autocomplete-python"
  "browser-plus"
  "busy-signal"
  "city-lights-syntax"
  "css-snippets"
  "dash"
  "es6-javascript"
  "file-type-icons"
  "file-types"
  "github-utils"
  "hey-pane"
  "intentions"
  "language-babel"
  "language-docker"
  "language-dotfiles"
  "language-lua"
  "language-markdown"
  "language-tmux"
  "language-unix-shell"
  "linter"
  "linter-docker"
  "linter-eslint"
  "linter-luacheck"
  "linter-js-yaml"
  "linter-shellcheck"
  "linter-ui-default"
  "python-indent"
  "react-es6-snippets"
  "react-es7-snippets"
  "react-native-snippets"
  "react-snippets"
  "script"
  "sort-lines"
  "split-diff"
  "teletype"
  "trailing-spaces"
)

for nucleus in "${atoms[@]}"; do
  apm install "$nucleus"
done

cp -f ./configs/atom.config.cson $HOME/.atom/config.cson

# Move dotfiles
cp -R ./dotfiles/. $HOME/

# Install powerline fonts
cd $HOME/Developer/GitHub
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Android ಠ_ಠ
android update sdk --no-ui

# iTerm2
mkdir $HOME/.iTerm2
cp ./configs/iTerm2.preferences $HOME/.iTerm2/

# zsh
cp ./configs/agnostik.zsh-theme $HOME/.oh-my-zsh/custom/themes/

# Setup completed
printf "\n\nSetup completed, the workstation needs to be restarted\n\n"

count=15

while [ $count -ge 1 ]; do
 echo -ne "Rebooting workstation in $count seconds, press ctrl-c to cancel \r"
 sleep 1
 count=$[$count-1]
done

echo
echo "restarting workstation"

sudo shutdown -r now "Rebooting to complete workstation setup"