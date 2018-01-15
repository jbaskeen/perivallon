#!/bin/bash

# Setup necessary dev tools

usage() {
  printf "Usage: $0\n \
    [ -h print usage ]\n \
    [ -e your_github_email ]\n"
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

wd=$(pwd)

create_ssh_key() {
  ssh-keygen -t rsa -b 4096 -C "${1}" -f "${2}"

  eval "$(ssh-agent -s)"
  ssh-add -K $2
  pbcopy < $2

  echo "A new ssh key $2 has been copied to the clipboard, printing too just in case"
  cat $2

  read -p "Add the ssh key ${2}.pub to your GitHub profile and press enter when complete so the ssh connection can be tested..."

  ssh -T "git@${3}"
}

# Create an ssh key for github
create_ssh_key "${github_email}" "$HOME/.ssh/id_rsa" "github.com"

cat > $HOME/.ssh/config << EOL
# GitHub account
Host github.com
  HostName github.com
  User git
  IdentityFile $HOME/.ssh/id_rsa

EOL

# Setup an additional ssh config
read -p "Would you like to setup a secondary GitHub ssh key [y/n]? " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
  # Create a secondary ssh key
  echo "Creating a secondary ssh key file..."

  read -p "Enter the email address: " secondary_email
  read -p "Enter the location of the secondary key file: " key_file
  read -p "Enter the host for the secondary ssh connection: " secondary_host

  create_ssh_key "${secondary_email}" "${key_file}" "${secondary_host}"

cat >> $HOME/.ssh/config << EOL
# GitHub secondary account
Host $secondary_host
  HostName $secondary_host
  User git
  IdentityFile $key_file
EOL
fi

echo "ssh config setup completed, moving on..."

# Create dev dir structure
mkdir $HOME/Developer && mkdir $HOME/Developer/GitHub
cd $HOME/Developer/GitHub

# list available software updates
softwareupdate -l

# Install xcode cli tools
sudo xcodebuild -license
# xcode-select --install
# open -a Xcode

read -p "Xcode has been opened to ensure CLI tools are installed. If you're promopted to install Xcode tools do so then press Enter when complete"

sudo chown -R "`whoami`":admin /usr/local/
sudo chown -R "`whoami`":admin /usr/local/bin
sudo chown -R "`whoami`":admin /usr/local/share
sudo chown -R "`whoami`":admin /usr/local/include

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew --version

brew tap caskroom/cask
brew tap caskroom/versions

declare -a casks=(
  "1password"
  "atom"
  "android-studio"
  "dbvisualizer"
  "docker-toolbox"
  "docker"
  "dropbox"
  "firefox"
  "google-chrome"
  "insomnia"
  "intel-haxm"
  "iterm2"
  "java7"
  "java8"
  "jenv"
  "minikube"
  "postman"
  "skype"
  "slack"
  "virtualbox"
  "vlc"
)

for casket in "${casks[@]}"; do
  echo "installing casket $casket"
  brew cask install "$casket"
done

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
  "bash-completion"
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
  "xctool"
  "yarn"
  "zsh"
  "zsh-completions"
)

for cold_one in "${brewskies[@]}"; do
  echo "installing brewsky $cold_one"
  brew install "$cold_one"
done

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

cd $wd

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
  "linter-travis-lint"
  "linter-ui-default"
  "minimap"
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

# Install powerline fonts
cd $HOME/Developer/GitHub
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

cd $wd

# zsh install/setup
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Move Atom config
cp -f ./configs/atom.config.cson $HOME/.atom/config.cson

# Move dotfiles
cp -Rf ./dotfiles/. $HOME/

# iTerm2 config
cp ./configs/com.googlecode.iterm2.plist $HOME/Library/Application\ Support/iTerm2/DynamicProfiles/

mkdir $HOME/.oh-my-zsh/custom/themes/
cp ./configs/agnostik.zsh-theme $HOME/.oh-my-zsh/custom/themes/

# Setup tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Link nvim to vim config
ln -s $HOME/.vim $HOME/.config/nvim
ln -s $HOME/.vimrc $HOME/.vim/init.vim

# Git config
git config --global core.editor "nvim"

echo "Add your git global email: "
read git_email

git config --global user.email "${git_email}"

echo "Add your git global user name: "
read git_name

git config --global user.name "${git_name}"

echo "Add your git global hub host name (github.com or your github enterprise host): "
read hub_host

git config --global hub.host "${hub_host}"

git config --global core.excludesfile "$HOME/.gitignore_global"
git config --global color.ui "true"
git config --global alias.incoming '!git remote update -p; git log ..@{u}'
git config --global alias.outgoing "log @{u}.."
git config --global alias.hist "log --graph --all --first-parent --decorate --pretty=format:'%C(40)[%h]%Creset %s %Cred%d%Creset %C(23)%an%Creset %C(5)(%ad)%Creset' --date=relative"

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
