# Deps:
#  * git
#  * zsh
#  * tmux
#  * ??

all:
	# Setup configs.
	cp -i .vimrc ~/.vimrc
	cp -i .zshrc ~/.zshrc
	cp -i .dir_colors ~/.dir_colors
	cp -i .tmux.conf ~/.tmux.conf
	cp -i .xresources ~/.xresources
	# Install Deps
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim || true
	git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh || true
	# Vundle Install
	vim -c "execute \"VundleInstall\" | q | q"
	exec ~/.vim/bundle/YouCompleteMe/install.sh
	# Instructions
	echo 'Use `chsh -s <zsh location>` to set your terminal to ZSH.'
