#/usr/bin/bash

set -e

#install dipendencies for programs

sudo apt-get -y update \
&& sudo apt-get -y install \
"$(cat - <<EOF 
curl 
zsh
vim
build-essential
cmake
python3-dev
vim-python-jedi
EOF)"; 

cp .vimrc ../.vimrc
cp .zshrc ../.zshrc

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
chsh -s $(which zsh);

sh -c "$(curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)"
