require("formatter").setup(
  {
    logging = false,
    filetype = {
      rust = {
        -- Rustfmt
        function()
          return {
            exe = "rustfmt",
            args = {"--emit=stdout", "--edition", "2018"},
            stdin = true
          }
        end
      },
      python = {
        --yapf
        function()
          return {
            exe = "yapf",
            args = {
              "-i",
              "--style",
              "pep8",
              vim.api.nvim_buf_get_name(0)
            },
            stdin = false
          }
        end
      },
      cpp = {
        function()
          return {
            exe = "clang-format",
            args = {
              "-i",
              "--style=Google",
              "--sort-includes",
              vim.api.nvim_buf_get_name(0)
            },
            stdin = false
          }
        end
      },
      sh = {
        function()
          return {
            exe = "shfmt",
            args = {
              "-ln",
              "bash",
              "-i",
              "4",
              "-ci",
              "-filename",
              vim.api.nvim_buf_get_name(0)
            },
            stdin = true
          }
        end
      },
      zsh = {
        function()
          return {
            exe = "shfmt",
            args = {
              "-ln",
              "bash",
              "-i",
              "4",
              "-ci",
              "-filename",
              vim.api.nvim_buf_get_name(0)
            },
            stdin = true
          }
        end
      },
      bash = {
        function()
          return {
            exe = "shfmt",
            args = {
              "-ln",
              "bash",
              "-i",
              "8",
              "-ci",
              "-filename",
              vim.api.nvim_buf_get_name(0)
            },
            stdin = true
          }
        end
      },
      css = {
        function()
          return {
            exe = "prettier",
            args = {
              "--tab-width",
              "4",
              "--stdin-filepath",
              vim.api.nvim_buf_get_name(0)
            },
            stdin = true
          }
        end
      },
      javascript = {
        function()
          return {
            exe = "prettier",
            args = {
              "--tab-width",
              "4",
              "--stdin-filepath",
              vim.api.nvim_buf_get_name(0)
            },
            stdin = true
          }
        end
      },
      markdown = {
        function()
          return {
            exe = "prettier",
            args = {
              "--tab-width",
              "4",
              "--stdin-filepath",
              vim.api.nvim_buf_get_name(0)
            },
            stdin = true
          }
        end
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"-i", "2", "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)
