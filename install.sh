#!/usr/bin/bash
set -e

if [ -f /etc/os-release ];
then
	. /etc/os-release
fi
CDIR=$PWD
DIST=$1
install() {
	case $ID in
		"pop") 
			PROGS="./prog-pop.txt"
			NODE_DIST_COMMAND="curl -sL https://deb.nodesource.com/setup_14.x |sudo -E bash -"
			;;
		"kali") 
			PROGS="./prog-kali.txt"
			NODE_DIST_COMMAND="curl -sL https://deb.nodesource.com/setup_14.x |sudo bash -"
			;;
		*) echo "Distribution not supported";;
	esac

	sudo apt-get -y update \
	&& sudo apt-get -y install $(cat $PROGS );
	eval $NODE_DIST_COMMAND
	sudo apt-get install -y nodejs
}

nvim_conf() {
	
	#nvim conf install
	if [ ! -d $HOME/.config/nvim ]
		then
		mkdir $HOME/.config/nvim
	fi

	if [ ! -f $HOME/.local/share/nvim/autoload/plug.vim ]
		then 
		plug_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
		curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs ${plug_url};
	fi

	ln -s $CDIR/init.vim $HOME/.config/nvim/init.vim
}

tmux_conf() {
	if [ ! -d $HOME/.tmux ]
		then
		mkdir $HOME/.tmux
		ln -s $CDIR/.tmux.conf $HOME/.tmux.conf
		git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
	fi
}
zsh_conf() {
	if [ ! -d $HOME/.config/zsh ]
	then
		mkdir $HOME/.config/zsh
	fi	
	if [ -f $HOME/.zshenv ];
	then
		rm $HOME/.zshenv
	fi
	if [ -f $HOME/.profile ];
	then
		rm $HOME/.profile
	fi

	ln -s $CDIR/.zshenv $HOME/.zshenv
	ln -s $CDIR/.zshrc $HOME/.config/zsh/.zshrc
	ln -s $CDIR/.profile $HOME/.profile

	#install oh my zsh
	if [ ! -d $HOME/.config/oh-my-zsh ]
		then
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
		chsh -s $(which zsh);
		if [ -d $HOME/.oh-my-zsh ]
			then
			mv $HOME/.oh-my-zsh $HOME/.config/oh-my-zsh;
		fi
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
		git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/plugins/zsh-autosuggestions
		git clone https://github.com/zsh-users/zsh-history-substring-search.git ${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/plugins/zsh-history-substring-search
	fi
}

case $DIST in 
	"install") install;;
	"conf") cd $HOME && nvim_conf && zsh_conf && tmux_conf;;
	"nvim") cd $HOME && nvim_conf;;
	"zsh") cd $HOME && zsh_conf;;
	"tmux") cd $HOME && tmux_conf;;
	"*") echo "error option not defined" ;;
esac
