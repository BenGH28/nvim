require "packer-config"
vim.cmd [[packadd packer.nvim]]
require "packer".startup(
  function(use)
    -- I feel the need, the need for specified
    use {
      "lewis6991/impatient.nvim",
      config = function()
        require "impatient"
      end
    }
    local lsp_file_list = {"yaml", "cpp", "c", "python", "json", "lua", "rust", "bash", "sh"}
    --#region General Dependencies
    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {"kyazdani42/nvim-web-devicons"}
    --#endregion

    --#region Lsp
    use {
      "hrsh7th/nvim-compe",
      ft = lsp_file_list
    }
    use {
      "onsails/lspkind-nvim",
      ft = lsp_file_list
    }
    use {
      "glepnir/lspsaga.nvim",
      ft = lsp_file_list
    }
    -- if you could just sign right there
    use {
      "ray-x/lsp_signature.nvim",
      ft = lsp_file_list
    }
    -- How can it be? Great scott we have an lsp!!
    use {
      "neovim/nvim-lspconfig",
      after = {"lspsaga.nvim", "nvim-compe", "lspkind-nvim", "lsp_signature.nvim"},
      config = function()
        require("lsp")
      end
    }
    -- "...I am the captain now"
    use {
      "kabouzeid/nvim-lspinstall"
    }
    use {"hrsh7th/vim-vsnip", after = "nvim-lspconfig"}
    use {"hrsh7th/vim-vsnip-integ", after = "nvim-lspconfig"}
    use {"rafamadriz/friendly-snippets", after = "nvim-lspconfig"}
    --#endregion

    use "sainnhe/edge"
    -- plugin to the outlet
    use {"wbthomason/packer.nvim", opt = true}
    -- Oh hey its me
    use {
      "BenGH28/neo-runner.nvim",
      cmd = "NeoRunner",
      run = ":UpdateRemotePlugins"
    }
    -- I'm really liking this format
    use {
      "mhartington/formatter.nvim",
      ft = {"rust", "bash", "sh", "zsh", "lua", "cpp", "python", "markdown"},
      config = function()
        require("formatter-conf")
      end
    }
    -- colours to make unicorns vomit
    use {
      "nvim-treesitter/nvim-treesitter",
      event = "BufEnter",
      run = ":TSUpdate",
      config = function()
        require "treesitter-conf"
      end
    }
    -- which bracket is this again?
    use {
      "p00f/nvim-ts-rainbow",
      after = "nvim-treesitter",
      config = function()
        require "nvim-treesitter.configs".setup {
          rainbow = {enable = true}
        }
      end
    }
    -- quotes, brackets and easy times ahead
    use {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require "autopairs"
      end
    }
    -- I walk the line
    use {
      "glepnir/galaxyline.nvim",
      branch = "main"
    }
    -- files, files, files
    use {
      "kyazdani42/nvim-tree.lua",
      -- disable = true,
      config = function()
        require "tree-conf"
      end
    }
    -- see all the files on the moon
    use {
      "nvim-lua/telescope.nvim",
      event = "BufEnter",
      config = function()
        require "telescope-conf"
      end
    }
    -- jump around, jump around
    use {
      "phaazon/hop.nvim",
      event = "BufEnter",
      config = function()
        require "hop".setup {keys = "etovxqpdygfblzhckisuran", term_seq_bias = 1.5}
      end
    }
    -- the Lone Ranger
    use {
      "kevinhwang91/rnvimr",
      opt = true,
      branch = "main",
      config = function()
        vim.g.rnvimr_ex_enable = 1
      end
    }
    -- wait that hex code is a colour?
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end
    }
    -- I changed something didn't I?
    use {
      "lewis6991/gitsigns.nvim",
      -- disable = true,
      config = function()
        require("gitsigns").setup()
      end
    }
    -- lets git kraken... oh wait wrong git app
    use {
      "kdheepak/lazygit.nvim",
      event = "BufEnter",
      config = function()
        require "lazygit-conf"
      end
    }
    -- I'm pretty buff
    use {
      "akinsho/nvim-bufferline.lua",
      config = function()
        require "bufferline".setup()
      end
    }

    -- comments are easy
    use {"tpope/vim-commentary"}
    -- 'I have you completely surrounded'
    use {"tpope/vim-surround"}
    -- do it again
    use "tpope/vim-repeat"
    -- start screen for the vimified
    use "mhinz/vim-startify"
    -- 360 no scope
    use "unblevable/quick-scope"
    -- what was that shortcut again?
    use "liuchengxu/vim-which-key"
    -- documentation for the enlightend
    use {"vim-scripts/DoxygenToolkit.vim", ft = {"cpp", "c"}}
    -- OCD and me
    use {
      "junegunn/vim-easy-align",
      opt = true
    }
    use {
      "lukas-reineke/indent-blankline.nvim",
      disable = true,
      config = function()
        require "indent_blankline".setup {
          buftype_exclude = {"terminal", "startify", "help"}
        }
      end
    }
  end
)
