#!/usr/bin/env bash

clone_my_nvim_repo() {
    if [ -d $HOME/.config/nvim ]; then
        echo "backing up your old config"
        mv $HOME/.config/nvim $HOME/.config/nvim.bak
    fi
    echo "cloning repo to '$HOME/.config/nvim'"
    git clone https://github.com/BenGH28/nvim.git $HOME/.config/nvim/
}

clone_my_nvim_repo
