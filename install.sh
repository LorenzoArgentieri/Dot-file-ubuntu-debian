#!/usr/bin/bash

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

cp .vimrc ~/.vimrc;
cp .zshrc ~/.zshrc;

#install oh my zsh
if [ ! -d ~/.oh-my-zsh ]
	then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
	chsh -s $(which zsh);
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi


#install vim plug
if [ ! -d ~/.vim && ! -f ~/.vim/autoload/plug.vim ]

	then 
	plug_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs ${plug_url};
fi
