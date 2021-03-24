#!/usr/bin/env bash

#helper functions
has_package(){
    if ! command -v $1 &>/dev/null; then
        false;
    else
        true
    fi
}

# LSP install functions
install_bashls(){ npm i -g bash-language-server; }
install_yamlls(){ npm install -g yaml-language-server; }
install_vimls(){ npm install -g vim-language-server; }
install_jsonls(){ npm i -g vscode-json-languageserver; }

install_pyls(){
    pip install python-language-server[all] pyls-mypy pyls-isort;
}
install_rls(){
	rustup update;
	rustup component add rls rust-analysis rust-src;
}
install_efmls(){
    go get github.com/mattn/efm-langserver@HEAD;
}
install_lua_format(){
    luarocks install --server=https://luarocks.org/dev luaformatter
}
#install my config of nvim into .config/nvim
clone_my_nvim_repo(){
	git clone https://github.com/BenGH28/nvim.git $HOME/.config/nvim/
}

install_npm_lsps(){
    install_bashls
    install_yamlls
    install_jsonls
    install_vimlss
}


install_all_lsps(){
    #install all the npm lsps
    has_npm=true
    has_package npm && install_npm_lsps || \
         echo "Npm missing. Cannot install bash, yaml, json, and vim lsps" && $has_npm=false

    #install rls
    has_rustup=true
    has_package rustup && install_rls || echo "Rustup missing. Cannot install rls" && $has_rustup=false

    #install pyls
    has_pip=true
    has_package pip && install_pip || echo "Pip missing. Cannot install pyls" && $has_pip=false

    #install efmls
    has_go=true
    has_package go && install_efmls || echo "Golang missing. Cannot install efmls" && $has_pip=false

    #install install_lua_format
    has_luarocks=true
    has_package lua && has_package luarocks && install_lua_format || \
        echo "Lua and/or Luarocks missing. Cannot install luaformatter" && $has_luarocks=false
}
