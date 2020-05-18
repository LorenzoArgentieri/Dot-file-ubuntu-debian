#!/usr/bin/bash
set -e

DIST=$1

install() {
	case $1 in
		"pop") PROGS="./prog-pop.txt";;
		"kali") PROGS="./prog-kali.txt";;
		*) echo "Error option not valid";;
	esac
	sudo apt-get -y update \
	&& sudo apt-get -y install $(cat $PROGS );
}

vim_conf() {
	
	#vim conf install
	if [ ! -d $HOME/.config/vim ]
		then
		mkdir $HOME/.config/vim
	fi

	if [ ! -f ~/.vim/autoload/plug.vim ]
		then 
		plug_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
		curl -fLo ~/.config/vim/autoload/plug.vim --create-dirs ${plug_url};
	fi

	ln -s $HOME/Dot-file-ubuntu-debian/vimrc $HOME/.config/vim/vimrc
}

zsh_conf() {
	if [ ! -d $HOME/.config/zsh ]
	then
		mkdir $HOME/.config/zsh
	fi
	
	ln -s $HOME/Dot-file-ubuntu-debian/.zshrc $HOME/.config/zsh/.zshrc
	ln -s $HOME/Dot-file-ubuntu-debian/.zshrc $HOME/.zshenv
	ln -s $HOME/Dot-file-ubuntu-debian/.profile $HOME/.profile

	#install oh my zsh
	if [ ! -d ~/.config/oh-my-zsh ]
		then
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
		chsh -s $(which zsh);
		mv $HOME/.oh-my-zsh $HOME/.config/oh-my-zsh
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
		git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/plugins/zsh-autosuggestions
		git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/plugins/zsh-history-substring-search
	fi
}

case $DIST in 
	"kali"|"pop") install $DIST;;
	"conf") cd $HOME && vim_conf && zsh_conf;;
	"*") echo "error option not defined" ;;
esac
