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

"Set foldmethod based on filetype {{{
augroup foldmethod-on-filetype
	au!
	au FileType sh,python setlocal foldmethod=indent
	au FileType vim setlocal foldmethod=marker
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
augroup white-space
	au!
	au BufWritePre * %s/\s\+$//e
augroup END
"}}}


" augroup format-on-save
"         autocmd!
"         au BufWritePre * :lua vim.lsp.buf.formatting()
" augroup END

augroup terminal-numbers
	au!
	au TermOpen,TermEnter * setlocal nornu nonu
augroup END
