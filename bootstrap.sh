#!/usr/bin/env bash

my_nvim="$HOME/.config/nvim"
backup="$HOME/.config/nvim.backup"

clone_my_nvim_repo() {
    if [ -d "$HOME/.config/nvim" ]; then
        echo "backing up your old config"
        mv "$my_nvim" "$backup"
    fi
    echo "cloning repo to '$my_nvim'"
    git clone https://github.com/BenGH28/nvim.git "$my_nvim"
}

clone_my_nvim_repo
