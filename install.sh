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
p7zip-rar
pulseeffects
python3-dev
ranger
ripgrep
s-tui
stress
terminator
timeshift
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

cp vimrc $HOME/.vimrc 
cp zshrc $HOME/.zshrc 

#install oh my zsh
if [ ! -d ~/.oh-my-zsh ]
	then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
	chsh -s $(which zsh);
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
fi


#install vim plug
if [ ! -f ~/.vim/autoload/plug.vim ]
	then 
	plug_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs ${plug_url};
fi

if [ "$(uname -n)" = "ubuntu" ]; then
	sudo apt-get -y install $(cat - <<EOF 
i3
feh
EOF
);
	i3-config-wizard
	cat ./i3conf >> $HOME/.config/i3/config
	#sed -i '/^bar/d' $HOME/.config/i3/config
	cp bg.jpg $HOME/Pictures/bg.jpg
	sudo bash ./kde-i3.sh
fi

