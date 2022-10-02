"============================================================
"                         User Functions
"============================================================

"see https://lib.rs/crates/alacritty-theme
"
" This function will set Vim's background to "light" or "dark"
" depending on if the current color scheme Alacritty is using
" has those keywords in its name.
function! MyFunctions#AlignAlacrittyBackground() abort
	let &background = ( system('alacritty-theme current') =~ 'light' ? 'light' : 'dark' )
  	hi Normal guibg=NONE ctermbg=NONE
endfunc

" This function will toggle Alacritty's color scheme back and
" forth between light and dark themes.
function! MyFunctions#ToggleAlacrittyTheme() abort
    if (system('alacritty-theme current') =~ 'light')
        call system('alacritty-theme change one_dark')
    else
        call system('alacritty-theme change one_light')
    endif
    call MyFunctions#AlignAlacrittyBackground()
endfunc

let t:is_transparent = 0
function! MyFunctions#ToggleTransparentBackground() abort
  if t:is_transparent == 0
    hi Normal guibg=#282c34 ctermbg=235
    let t:is_transparent = 1
  else
    hi Normal guibg=NONE ctermbg=NONE
    let t:is_transparent = 0
  endif
endfunction


function! MyFunctions#NewScratchBelow() abort
    execute 'sp | enew'
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    file scratch
endfunction
