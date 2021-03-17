vim.cmd[[packadd packer.nvim]]
return require('packer').startup(function(use)
    use 'sainnhe/edge'
    use {'wbthomason/packer.nvim', opt = true}
    use {'BenGH28/neo-runner.nvim', run = ':UpdateRemotePlugins'}
    use {
        'neovim/nvim-lspconfig',
        requires = {
            {'hrsh7th/nvim-compe'}, {'glepnir/lspsaga.nvim'},
            {'onsails/lspkind-nvim'}
        }
    }
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
end)
