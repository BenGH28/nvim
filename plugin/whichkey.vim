"autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')
nnoremap <silent> <Leader> :WhichKey '<Space>'<CR>

let g:which_key_map = {}
let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆'}

let g:which_key_map['.'] = 'next tab'
let g:which_key_map[','] = 'previous tab'

let g:which_key_map['1'] = [':BufferLineGoToBuffer 1', "Goto buffer 1"]
let g:which_key_map['2'] = [':BufferLineGoToBuffer 2', "Goto buffer 2"]
let g:which_key_map['3'] = [':BufferLineGoToBuffer 3', "Goto buffer 3"]
let g:which_key_map['4'] = [':BufferLineGoToBuffer 4', "Goto buffer 4"]
let g:which_key_map['5'] = [':BufferLineGoToBuffer 5', "Goto buffer 5"]
let g:which_key_map['6'] = [':BufferLineGoToBuffer 6', "Goto buffer 6"]
let g:which_key_map['7'] = [':BufferLineGoToBuffer 7', "Goto buffer 7"]
let g:which_key_map['8'] = [':BufferLineGoToBuffer 8', "Goto buffer 8"]
let g:which_key_map['9'] = [':BufferLineGoToBuffer 9', "Goto buffer 9"]

let g:which_key_map.a = {
            \'name' : '+alacritty',
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
            \'p' : 'previous',
            \'d' : [':bdelete', 'delete']
            \}

let g:which_key_map.c = {
            \'name' : '+colours',
            \'l' : 'light background',
            \'d' : 'dark background',
            \'c' : [':Telescope colorscheme', 'colorscheme']
            \}
let g:which_key_map.d = [':Dox', 'Doxygen']

let g:which_key_map.f = {
            \'name' : '+files',
            \'o' : [':Format', 'Format'],
            \'v'  : {
                \'name': '+nvim config',
                \'v': [':e $MYVIMRC','open init.lua'],
                \'o': [':e /home/ben/.config/nvim/lua/options.lua', 'edit nvim options'],
                \'m': [':e /home/ben/.config/nvim/lua/general-mappings.lua', 'edit nvim general mappings'],
                \'p': [':e /home/ben/.config/nvim/lua/plugins.lua', 'edit plugins']
                \},
            \'e' : [':Telescope file_browser','File Explorer'],
            \'f' : [':Telescope find_files','Find files'],
            \'g' : [':Telescope git_files','Git Files'],
            \'/' : [':Telescope live_grep','Search Project'],
            \'l' : [':Telescope buffers','List Buffers'],
            \'h' : [':Telescope oldfiles','History'],
            \'m' : [':Telescope man_pages', 'Man Pages'],
            \'q' : 'quit',
            \'j' : 'save',
            \'r' : [':RnvimrToggle', 'Ranger'],
            \'.' : [':call MyFunctions#mysource()', 'source current file']
            \}

let g:which_key_map['H'] = [':Telescope help_tags','help']

let g:which_key_map.l = {
            \'name' : '+lsp',
            \'c': [':Lspsaga code_action', 'Code action'],
            \'d': {
                \'name': '+diagnostics',
                \'l': [':Lspsaga show_line_diagnostics', 'Show line diagnostics'],
                \'c': [':Lspsaga show_cursor_diagnostics', 'Show cursor diagnostics'],
                \'n': [':Lspsaga diagnostic_jump_next', 'Next diagnostic'],
                \'p': [':Lspsaga diagnostic_jump_prev', 'Prev diagnostic'],
                \'q': ['lua vim.lsp.diagnostic.set_loclist()', 'Diagnostic list'],
                \},
            \'f' : {
                \'name' : '+folder',
                \'a': ['lua vim.lsp.buf.add_workspace_folder()', 'Add workspace folder'],
                \'r': ['lua vim.lsp.buf.remove_workspace_folder()', 'Remove workspace folder'],
                \'l': ['lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))', 'List workspace folders'],
                \},
            \'l' : [':LspInfo', 'info'],
            \}

let g:which_key_map.m = {
            \'name' : '+make',
            \'a' : 'all',
            \'c' : 'clean',
            \}

let g:which_key_map.p = {
            \'name': '+packer',
            \'i': [':call MyFunctions#mysource()| PackerInstall', 'install'],
            \'u': [':call MyFunctions#mysource()| PackerUpdate', 'update'],
            \'c': [':call MyFunctions#mysource()| PackerClean', 'clean'],
            \'C': [':call MyFunctions#mysource()| PackerCompile', 'compile'],
            \'s': [':call MyFunctions#mysource()| PackerSync', 'sync'],
            \'S': [':PackerStatus', 'status']
            \}

let g:which_key_map.q = {
            \'name': '+persistence',
            \'c' : [":lua require'persistence'.load{}", 'load current directory session'],
            \'l' : [":lua require'persistence'.load{last = true}", 'load last session'],
            \'s' : [":lua require'persistence'.stop()", 'stop'],
            \}

let g:which_key_map.s = {
            \'name' : '+substitute',
            \'w' : {
                \ 'g' : 'global',
                \ 'l' :'local',
                \},
            \}

let g:which_key_map.t = {
            \'name' : '+terminal',
            \'t': 'ToggleTerm',
            \'g': [':LazyGit', 'LazyGit']
            \}


let g:which_key_map.v = 'source vimrc'

let g:which_key_map.w = {
            \'name' : '+window',
            \'h' : 'decrease width',
            \'j' : 'increase height',
            \'k' : 'decrease height',
            \'l' : 'increase width',
            \'=' : 'balance',
            \'o' : 'show only current window',
            \'v' : [':vs', 'vertical split'],
            \'s' : [':sp', 'horizontal split']
            \}

let g:which_key_map.x = {
            \'name' : '+trouble',
            \'x' : [':TroubleToggle', 'toggle'],
            \'w' : [':TroubleToggle lsp_workspace_diagnostics', 'workspace diagnostics'],
            \'d' : [':TroubleToggle lsp_document_diagnostics', 'document diagnostics'],
            \'q' : [':TroubleToggle quickfix', 'quickfix'],
            \'l' : [':TroubleToggle loclist', 'loclist'],
            \"n": [':lua require("trouble").next({skip_groups = true, jump = true})', 'next'],
            \"p": [':lua require("trouble").previous({skip_groups = true, jump = true})', 'previous']
            \}

call which_key#register('<Space>', 'g:which_key_map')
