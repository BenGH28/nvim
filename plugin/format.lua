require("formatter").setup(
  {
    logging = false,
    filetype = {
      rust = {
        -- Rustfmt
        function()
          return {
            exe = "rustfmt",
            args = {"--emit=stdout"},
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
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)
