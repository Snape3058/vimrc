" C/C++ file configurations:
"
" author : Oikawa Kirie
" date   : 2018-07-25
" version: 1.1.0

" include protection {{{
if exists("g:CPP_CONFIG")
    finish
endif
let g:CPP_CONFIG = 1
" }}}

" basic configurations override {{{

set tabstop=2
set shiftwidth=2
set softtabstop=2
set cindent                     " cindent
set cinoptions=l1,g0.5s,h0.5s   " cindent style
set tags+=~/.vim/tags/cpp

" }}}

" filetype keymaps {{{

"   variables:
if "googletest" == &ft
    let b:gtestflags = " -lgtest -lgtest_main "
else
    let b:gtestflags = ""
endif

if "c" == &ft
    let b:cc = "gcc"
else
    let b:cc = "g++"
endif

" Compile:
nnoremap <buffer> <silent> <F7> :echo "Compiling ..." <cr> :echo system(b:cc.b:gtestflags." -o ".expand("%:t:r")." ".expand("%")) <cr>

" Run:
nnoremap <buffer> <silent> <F6> :echo system(" ./".expand("%:t:r")." 2>&1") <cr>

nnoremap <buffer> <silent> ,, :cw 8<cr>
nnoremap <buffer> <silent> ,! :ccl<cr>

" }}}

" plugin configurations: {{{
"   auto-close Scratch when selected
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" }}}
