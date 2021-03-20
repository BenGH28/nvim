"autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')
nnoremap <silent> <Leader> :WhichKey '<Space>'<CR>

let g:which_key_map = {}
let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆'}

let g:which_key_map['.'] = 'next tab'
let g:which_key_map[','] = 'previous tab'

let g:which_key_map.a = {
			\'name' : '+theme',
			\'l' : 'light background',
			\'d' : 'dark background',
			\'t' : 'match alacritty theme',
			\}

let g:which_key_map.b = {
			\'name' : '+buffers',
			\'h': {
				\'name': '+hop',
				\'w': [':HopWord', 'word'],
				\'l': [':HopLine', 'line'],
				\'1': [':HopChar1', 'char1'],
				\'2': [':HopChar2', 'char2'],
				\'p': [':HopPattern', 'pattern'],
				\},
			\'n' : 'next',
			\'p' : 'previous'
			\}

let g:which_key_map.d = 'doxygen'

let g:which_key_map.f = {
			\'name' : '+files',
			\'o' : 'format',
			\'v' : 'open vimrc',
			\'e' : [':Telescope file_browser','File Explorer'],
			\'f' : [':Telescope find_files','Find files'],
			\'g' : [':Telescope git_files','Git Files'],
			\'/' : [':Telescope live_grep','Search'],
			\'l' : [':Telescope buffers','List Buffers'],
			\'h' : [':Telescope oldfiles','History'],
			\'q' : 'quit',
			\'s' : 'save',
			\'r' : 'Ranger',
			\'.' : [':call MyFunctions#mysource()', 'source current file']
			\}

let g:which_key_map['H'] = [':Telescope help_tags','help']

let g:which_key_map.l = {
			\'name' : '+lsp',
			\'c': [':lua require("lspsaga.codeactions").code_action()', 'Code action'],
			\'d': {
				\'name': '+diagnostics',
				\'s': [':lua require"lspsaga.diagnostic".show_line_diagnostics()<CR>', 'Show line diagnostics'],
				\'n': [':lua require"lspsaga.diagnostic".lsp_jump_diagnostic_next()<CR>', 'Next diagnostic'],
				\'p': [':lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<CR>', 'Prev diagnostic'],
				\'q': [':lua vim.lsp.buf.diagnostic.set_loclist()', 'Loclist'],
				\},
			\'f' : {
				\'name' : '+folder',
				\'a': [':lua vim.lsp.buf.add_workspace_folder()', 'Add workspace folder'],
				\'r':[':lua vim.lsp.buf.remove_workspace_folder()', 'Remove workspace folder'],
				\'l':[':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))', 'List workspace folders'],
				\},
			\'l' : [':LspInfo', 'info']
			\}

let g:which_key_map.m = {
			\'name' : '+make',
			\'a' : 'all',
			\'c' : 'clean',
			\}

let g:which_key_map.s = {
			\'name' : '+substitute',
			\'w' : 'word'}

let g:which_key_map.t = {
			\'name' : '+floaterm',
			\'p' : 'previous',
			\'n' : 'new',
			\'x' : 'next',
			\'h' : 'hide',
			\'k' : 'kill',
			\}

let g:which_key_map.p = {
			\'name': '+packer',
			\'i': [':call MyFunctions#mysource()| PackerInstall', 'Install'],
			\'u': [':call MyFunctions#mysource()| PackerUpdate', 'Update'],
			\'c': [':call MyFunctions#mysource()| PackerClean', 'Clean'],
			\'C': [':call MyFunctions#mysource()| PackerCompile', 'Compile'],
			\'s': [':call MyFunctions#mysource()| PackerSync', 'Sync']
			\}

let g:which_key_map.v = 'source vimrc'

let g:which_key_map.w = {
			\'name' : '+window',
			\'h' : 'decrease width',
			\'j' : 'increase height',
			\'k' : 'decrease height',
			\'l' : 'increase width',
			\'=' : 'balance',
			\'o' : 'show only current window'
			\}

call which_key#register('<Space>', 'g:which_key_map')
