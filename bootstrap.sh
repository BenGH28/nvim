#!/usr/bin/env sh

### helper functions
has_package() {
    if ! command -v $1 &>/dev/null; then
        false
    else
        true
    fi
}

clone_my_nvim_repo() {
    if [ -d $HOME/.config/nvim ]; then
        echo "backing up your old config"
        mv $HOME/.config/nvim $HOME/.config/nvim.bak
    fi
    echo "cloning repo to '$HOME/.config/nvim'"
    git clone https://github.com/BenGH28/nvim.git $HOME/.config/nvim/
}

install_efmls() {
	has_package go && go get github.com/mattn/efm-langserver@HEAD || echo "install go and run this command:\n\n"\
		"\tgo get github.com/mattn/efm-langserver@HEAD\n"
}

for arg in "$@"
do
	case $arg in
		"efm")install_efmls;;
		"nvim")clone_my_nvim_repo;;
		"all")clone_my_nvim_repo && install_efmls;;
		*)continue;;
	esac
done
