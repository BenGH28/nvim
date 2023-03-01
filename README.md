# nvim
![image](https://user-images.githubusercontent.com/45215137/161371967-2ca62397-01ec-4555-85fc-9e117073f2d1.png)

## Install

[Latest stable version of neovim **required**](https://github.com/neovim/neovim)

Bootstrap.sh will clone this config into `$HOME/.config/nvim`
backing up any pre-existing config to `$HOME/.config/nvim.bak`.

```sh
curl https://raw.githubusercontent.com/BenGH28/nvim/main/bootstrap.sh | sh
```

All plugins will install on initial startup of neovim thanks to [lazy.nvim](https://github.com/folke/lazy.nvim).

## Language Servers

Ensure you have the following tools available for automatic installation of some language servers.

-   go
-   npm
-   pip
-   unzip
-   curl/wget
-   gzip
-   tar

Languages supported out of the box:

-   python
-   lua
-   c++
-   json
-   yaml
-   bash
-   rust
-   go



## Fonts

-   This config benefits from [nerd fonts](https://github.com/ryanoasis/nerd-fonts.git), to please your eyes,
    I recommend downloading one of those.
