#!/usr/bin/bash
set -e

#install dipendencies for programs

sudo apt-get -y update \
&& sudo apt-get -y install $(cat - <<EOF 
build-essential
cmake
curl 
fzf
p7zip
p7zip-full
i3
feh
p7zip-rar
pulseeffects
python3-dev
ranger
ripgrep
terminator
tmux
tree
vim-doc
vim-athena
vim-python-jedi
wget
zathura
zathura-cb
zathura-djvu
zathura-pdf-poppler
zathura-ps
zsh
zsh-doc
EOF
);

vim_conf() {
	
	#vim conf install
	if [ ! -d $HOME/.config/vim ]
		mkdir $HOME/.config/vim
	fi

	if [ ! -f ~/.vim/autoload/plug.vim ]
		then 
		plug_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
		curl -fLo ~/.config/vim/autoload/plug.vim --create-dirs ${plug_url};
	fi

	ln -s ./vimrc $HOME/.config/vim/vimrc
}

zsh_conf() {
	if [ ! -d $HOME/.config/zsh ]
		mkdir $HOME/.config/zsh
	fi
	
	ln -s ./.zshrc $HOME/.config/.zshrc
	ln -s ./.zshrc $HOME/.zshenv
	ln -s ./.profile $HOME/.profile

	#install oh my zsh
	if [ ! -d ~/.config/oh-my-zsh ]
		then
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
		chsh -s $(which zsh);
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
		${ZSH_CUSTOM:-$HOME/.config/zsh/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
		git clone https://github.com/zsh-users/zsh-autosuggestions
		${ZSH_CUSTOM:-$HOME/.config/zsh/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
		git clone https://github.com/zsh-users/zsh-history-substring-search
		${ZSH_CUSTOM:-$HOME/.config/zsh/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
	fi
}
vim_conf
zsh_conf
