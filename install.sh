#/usr/bin/bash

set -e

#install dipendencies for programs

sudo apt-get -y update \
&& sudo apt-get -y install $(cat - <<EOF 
curl 
zsh
vim
build-essential
cmake
python3-dev
vim-python-jedi
EOF
);

cp .vimrc ../.vimrc;
cp .zshrc ../.zshrc;
if [ ! -d ../.oh-my-zsh ]
	then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
	chsh -s $(which zsh);
fi

if [ ! ../.vim ]
	then plug_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs ${plug_url}
fi	
