# nvim

![nvim](https://github.com/BenGH28/dots/blob/master/.screenshots/nvim-lua-config.png)

## Porting Everything to Lua because why not?

Lets get rid of vimscript and use lua.  The latest version of Neovim allows you to load an init.lua instead of init.vim.
Neovim 0.5 also has native-lsp which works pretty well so far.  Lua, perhaps alien right now, is much nicer to work with than vimscript.

This config is different from the VimL counter-part but does have some feature parity (but really you can do whatever you want with it
thats the joy of Neovim).

My old config is under the vimscript branch which keeps the CoC lsp implementation.

## Install

Compile Neovim from source to get the latest and greatest.
[Neovim 0.5](https://github.com/neovim/neovim) is **REQUIRED**.

```
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install
```

Bootstrap.sh will clone this config into `$HOME/.config/nvim`
backing up any pre-existing config to `$HOME/.config/nvim.bak`.

```sh
curl https://raw.githubusercontent.com/BenGH28/nvim/main/bootstrap.sh | sh
```

## Dependencies/Life Improvements

- This config benefits from [nerd fonts](https://github.com/ryanoasis/nerd-fonts.git), to please your eyes,
I recommend downloading one of those.
