"=======================================================
" 				Auto-Commands
"=======================================================

"Gets rid of the highlightswhen you leave commandline {{{
augroup vimrc-incsearch-highlight
	au!
	au CmdlineEnter /,\? set hlsearch
	au CmdlineLeave /,\? set nohlsearch
augroup END
"}}}

"Set quickscope colours {{{
augroup quick-scope-colours
	au!
	au ColorScheme * highlight QuickScopePrimary guifg='#61afe0' gui=underline ctermfg=155 cterm=underline
	au ColorScheme * highlight QuickScopeSecondary guifg='#98d379' gui=underline ctermfg=81 cterm=underline
augroup END
"}}}

"whitespace must die {{{
augroup white-space-and-format
	au!
	au BufWritePre * %s/\s\+$//e
	" au BufWritePost *.py,*.rs,*.cpp,*.cc,*.sh,*.zsh,*.lua,*.md :Format
augroup END
"}}}

augroup terminal-numbers
	au!
	au TermOpen,TermEnter * setlocal nornu nonu
augroup END

augroup tabstops
	au!
	au BufEnter * lua require"common".set_default_tab(vim.api.nvim_buf_get_option(0, 'filetype'))
augroup END

augroup tex
    au!
    au BufEnter *.tex set ft=tex
augroup END

augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
