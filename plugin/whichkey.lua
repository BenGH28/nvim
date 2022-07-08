-- vim: foldmethod=marker
-- {{{ regular maps

-- alias the long function
local setmap = vim.api.nvim_set_keymap

local noremap = { noremap = true }
local silence = { noremap = true, silent = true }

setmap("n", "<C-n>", ":NvimTreeToggle<CR>", silence)

setmap("i", "jk", "<ESC>", noremap)
setmap("i", "kj", "<ESC>", noremap)

setmap("n", "Y", "y$", noremap)
setmap("n", "0", "0^", noremap)

-- windows
setmap("n", "<C-h>", ":wincmd h<CR>", silence)
setmap("n", "<C-j>", ":wincmd j<CR>", silence)
setmap("n", "<C-k>", ":wincmd k<CR>", silence)
setmap("n", "<C-l>", ":wincmd l<CR>", silence)

-- "hover doc
setmap("n", "K", ':lua require"lspsaga.hover".render_hover_doc()<CR>', silence)

--Ctrl-Backspace will delete the word behind the cursor in INSERT mode
setmap("i", "<C-h>", "<C-w>", noremap)

--terminal escape
--need to escape \ in the lua api
setmap("t", "<Esc>", "<C-\\><C-n>", noremap)

-- }}} regular

--{{{ which-key

local wk = require "which-key"

--{{{ g mappings
local gmaps = {
	l = { ":HopLine<cr>", "hop line" },
	p = { ":HopPattern<cr>", "hop pattern" },
	d = { ":lua vim.lsp.buf.definition()<CR>", "go to definition" },
	I = { ":lua vim.lsp.buf.implementation()<CR>", "go to implementation" },
	r = { ":lua vim.lsp.buf.references()<CR>", "go to references" },
	h = { ':lua require"lspsaga.provider".lsp_finder()<CR>', "lsp finder" },
	n = { ':lua require"lspsaga.rename".rename()<CR>', "rename" },
}
local g_opts = {
	prefix = "g",
}

wk.register(gmaps, g_opts)
--}}} g

--{{{normal mappings

--{{{loud normal mappings
local loud_normal_maps = {
	b = {
		s = {
			name = "+substitute",
			-- need to register this here other wise it will have a silent mapping which then won't appear in the cmdline area until user types
			g = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "substitute word in file" },
			l = { [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "substitute word in line" },
		},
	},
}
local loud_normal_opts = {
	silent = false,
	prefix = "<Leader>",
}

wk.register(loud_normal_maps, loud_normal_opts)
--}}} loud

--{{{ silent normal mappings

local silent_normal_opts = {
	prefix = "<Leader>",
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
}

local silent_normal_maps = {
	["."] = { ":tabn<cr>", "next" },
	[","] = { ":tabp<cr>", "previous" },
	["1"] = { ":BufferLineGoToBuffer 1<cr>", "Goto buffer 1" },
	["2"] = { ":BufferLineGoToBuffer 2<cr>", "Goto buffer 2" },
	["3"] = { ":BufferLineGoToBuffer 3<cr>", "Goto buffer 3" },
	["4"] = { ":BufferLineGoToBuffer 4<cr>", "Goto buffer 4" },
	["5"] = { ":BufferLineGoToBuffer 5<cr>", "Goto buffer 5" },
	["6"] = { ":BufferLineGoToBuffer 6<cr>", "Goto buffer 6" },
	["7"] = { ":BufferLineGoToBuffer 7<cr>", "Goto buffer 7" },
	["8"] = { ":BufferLineGoToBuffer 8<cr>", "Goto buffer 8" },
	["9"] = { ":BufferLineGoToBuffer 9<cr>", "Goto buffer 9" },
	b = {
		name = "+buffers",
		n = { ":BufferLineCycleNext<cr>", "next" },
		p = { ":BufferLineCyclePrev<cr>", "previous" },
		d = { ":Bdelete!<cr>", "delete" },
		f = { ":lua vim.lsp.buf.formatting()<cr>", "format" },
		l = { ":lua require('telescope.builtin').buffers()<cr>", "list buffers" },
		b = {
			name = "+background",
			l = { ":set background=light<cr>", "light" },
			d = { ":set background=dark<cr>", "dark" },
			m = { ":call MyFunctions#ToggleAlacrittyTheme()<cr>", "match alacritty" },
			t = { ":call MyFunctions#ToggleTransparentBackground()<cr>", "toggle transparency" },
		},
	},
	d = { ":Dox<cr>", "Doxygen" },
	f = {
		name = "+files",
		v = {
			name = "+nvim config",
			v = { ":e $MYVIMRC<cr>", "open init.lua" },
			-- not sure this binding does anything (major) now
			s = { ":so $MYVIMRC<cr>", "reload vimrc" },
			o = { ":lua require'common'.edit_lua_file('options')<cr>", "edit nvim options" },
			p = { ":lua require'common'.edit_lua_file('plugins')<cr>", "edit plugins" },
			m = { ":lua require'common'.edit_plugin_file('whichkey.lua')<cr>", "edit mappings" },
		},
		f = { ":lua require'telescope.builtin'.find_files()<cr>", "find files" },
		g = { ":lua require'telescope.builtin'.git_files()<cr>", "git files" },
		["/"] = { ":lua require'telescope.builtin'.live_grep()<cr>", "search project" },
		h = { ":lua require'telescope.builtin'.oldfiles()<cr>", "history" },
		j = { ":w!<cr>", "save" },
		q = { ":q<cr>", "quit" },
		p = { ":Telescope projects<cr>", "projects" },
		s = { ":NewScratchBelow<cr>", "scratch buffer" },
		["."] = { ":source % | echo 'file sourced'<cr>", "source current file" },
	},
	g = {
		name = "+git",
		l = { ":LazyGit<cr>", "lazygit" },
		s = { ":lua require'gitsigns'.stage_hunk()<cr>", "stage hunk" },
		u = { ":lua require'gitsigns'.undo_stage_hunk()<cr>", "undo stage hunk" },
		r = { ":lua require'gitsigns'.reset_hunk()<cr>", "reset hunk" },
		R = { ":lua require'gitsigns'.reset_buffer()<cr>", "reset buffer" },
		p = { ":lua require'gitsigns'.preview_hunk()<cr>", "preview hunk" },
		b = { ":lua require'gitsigns'.blame_line()<cr>", "blame line" },
		S = { ":lua require'gitsigns'.stage_buffer()<cr>", "stage buffer" },
		U = { ":lua require'gitsigns'.reset_buffer_index()<cr>", "reset buffer index" },
	},
	h = {
		name = "+help",
		h = { ":lua require('telescope.builtin').help_tags()<cr>", "help docs" },
		m = { ":lua require('telescope.builtin').man_pages()<cr>", "man pages" },
	},
	l = {
		name = "+lsp",
		c = { ":Lspsaga code_action<cr>", "code action" },
		d = {
			name = "+diagnostics",
			l = { ":Lspsaga show_line_diagnostics<cr>", "Show line diagnostics" },
			c = { ":Lspsaga show_cursor_diagnostics<cr>", "Show cursor diagnostics" },
			n = { ":Lspsaga diagnostic_jump_next<cr>", "Next diagnostic" },
			p = { ":Lspsaga diagnostic_jump_prev<cr>", "Prev diagnostic" },
			d = { ":lua vim.lsp.diagnostic.set_loclist()<cr>", "Diagnostic list" },
		},
		f = {
			name = "+folder",
			a = { "lua vim.lsp.buf.add_workspace_folder()", "Add workspace folder" },
			r = { "lua vim.lsp.buf.remove_workspace_folder()", "Remove workspace folder" },
			l = { "lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))", "List workspace folders" },
		},
		t = {
			name = "+trouble",
			x = { ":TroubleToggle<cr>", "toggle" },
			w = { ":TroubleToggle workspace_diagnostics<cr>", "workspace diagnostics" },
			d = { ":TroubleToggle document_diagnostics<cr>", "document diagnostics" },
			q = { ":TroubleToggle quickfix<cr>", "quickfix" },
			l = { ":TroubleToggle loclist<cr>", "loclist" },
			n = { ":lua require'trouble'.next({skip_groups = true, jump = true})<cr>", "next" },
			p = { ":lua require'trouble'.previous({skip_groups = true, jump = true})<cr>", "previous" },
		},
		l = { ":LspInfo<cr>", "info" },
	},
	p = {
		name = "+packer",
		i = { ":lua require'common'.install_plugins()<cr>", "install" },
		u = { ":lua require'common'.update_plugins()<cr>", "update" },
		c = { ":lua require'common'.clean_plugins()<cr>", "clean" },
		C = { ":lua require'common'.compile_plugins()<cr>", "compile" },
		s = { ":lua require'common'.sync_plugins()<cr>", "sync" },
		S = { ":lua require'common'.packer_status()<cr>", "status" },
	},
	q = {
		name = "+quickfix",
		n = { ":cnext<cr>", "next" },
		p = { ":cprevious<cr>", "previous" },
		c = { ":cclose<cr>", "close" },
	},
	s = {
		name = "+sessions",
		c = { ":lua require'persistence'.load{}<cr>", "load current directory session" },
		l = { ":lua require'persistence'.load{last = true}<cr>", "load last session" },
		s = { ":lua require'persistence'.stop{}<cr>", "stop" },
	},
	t = {
		name = "+terminal",
		n = { ":10 sp | terminal<cr>", "new terminal" },
	},
	w = {
		name = "+window",
		h = { ":vertical resize -3<CR>", "decrease width" },
		j = { ":resize -3<CR>", "decrease height" },
		k = { ":resize +3<CR>", "increase height" },
		l = { ":vertical resize +3<CR>", "increase height" },
		["="] = { "<C-W>=<cr>", "balance" },
		o = { ":on<cr>", "show only current window" },
		v = { ":vs<cr>", "make vertical split" },
		s = { ":sp<cr>", "make horizontal split" },
	},
}

wk.register(silent_normal_maps, silent_normal_opts)
--}}} silent

--}}} normals

--}}} which-key
