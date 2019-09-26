#/usr/bin/bash

sudo apt-get -y update && sudo apt-get -y install curl zsh;
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
chsh -s $(which zsh);

sudo apt-get -y install vim;

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# vim plug-ins dependencies

sudo apt-get -y install build-essential cmake python3-dev;
sudo apt-get -y install vim-python-jedi;

