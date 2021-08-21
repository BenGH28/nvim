require("formatter").setup(
	{
		logging = false,
		filetype = {
			rust = {
				-- Rustfmt
				function()
					return {
						exe = "rustfmt",
						args = {"--emit=stdout", "--config", "hard_tabs=true", "--edition", "2018"},
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
			zsh = {
				function()
					return {
						exe = "shfmt",
						args = {
							"-ln",
							"bash",
							"-i",
							"0",
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
							"-ci",
							"-filename",
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
						args = {"--use-tabs", "--stdin"},
						stdin = true
					}
				end
			}
		}
	}
)
