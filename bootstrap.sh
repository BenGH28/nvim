#!/usr/bin/env sh

#install vim-plug
install_vim_plug(){
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

#install my config of nvim into .config/nvim
clone_my_nvim_repo(){
	git clone https://github.com/BenGH28/nvim.git $HOME/.config/nvim/
}

install_vim_plug
clone_my_nvim_repo
