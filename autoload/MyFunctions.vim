"============================================================
"                         User Functions
"============================================================

"see https://lib.rs/crates/alacritty-theme
"
" This function will set Vim's background to "light" or "dark"
" depending on if the current color scheme Alacritty is using
" has those keywords in its name.
function! MyFunctions#AlignAlacrittyBackground()
	let &background = ( system('alacritty-theme current') =~ "light" ? "light" : "dark" )
  	hi Normal guibg=NONE ctermbg=NONE
endfunc

" This function will toggle Alacritty's color scheme back and
" forth between light and dark themes.
function! MyFunctions#ToggleAlacrittyTheme()
	if (system('alacritty-theme current') =~ "light")
	  	call system('alacritty-theme change one_dark')
	else
	  	call system('alacritty-theme change one_light')
	endif
	call MyFunctions#AlignAlacrittyBackground()
endfunc

function MyFunctions#mysource()
  if &filetype == 'lua'
	  :luafile %
  elseif &filetype == 'vim'
	  :source %
  else
	  echo "you can't source this..."
  endif
endfunc

let t:is_transparent = 0
function! Toggle_transparent_background()
  if t:is_transparent == 0
    hi Normal guibg=#111111 ctermbg=black
    let t:is_transparent = 1
  else
    hi Normal guibg=NONE ctermbg=NONE
    let t:is_transparent = 0
  endif
endfunction
