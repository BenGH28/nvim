#!/usr/bin/env sh

### helper functions
has_package() {
    if ! command -v $1 &>/dev/null; then
        false
    else
        true
    fi
}

MISSING_DEPENDS=false

check_depends() {
    if ! has_package $1; then
        echo "missing $1"
        MISSING_DEPENDS=true
    fi
}
has_dependencies() {
    echo "checking dependencies..."
    check_depends npm
    check_depends node
    check_depends rustup
    check_depends pip
    check_depends lua
    check_depends luarocks

    if [ $MISSING_DEPENDS == true ]; then
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

### LSP install functions
install_bashls() { npm i -g bash-language-server; }
install_yamlls() { npm install -g yaml-language-server; }
install_vimls() { npm install -g vim-language-server; }
install_jsonls() { npm i -g vscode-json-languageserver; }

install_pyls() {
    pip install python-language-server[all] pyls-mypy pyls-isort
}
install_rls() {
    rustup update
    rustup component add rls rust-analysis rust-src
}
install_efmls() {
    go get github.com/mattn/efm-langserver@HEAD
}
install_lua_format() {
    luarocks install --local --server=https://luarocks.org/dev luaformatter
}
install_npm_lsps() {
    install_bashls
    install_yamlls
    install_jsonls
    install_vimls
}
install_none_npm_lsps() {
    install_pyls
    install_rls
    install_efmls
    install_lua_format
}

install_all_lsps() {
    if has_dependencies; then
        echo "dependencies passed. continue install?"
        read
        install_npm_lsps
        install_none_npm_lsps
    else
        echo "you need to install some things first"
    fi
}

###call the functions

install_all_lsps
clone_my_nvim_repo
