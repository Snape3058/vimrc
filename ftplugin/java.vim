" Java file configurations:
"
" author : Oikawa Kirie
" date   : 2018-07-25
" version: 1.1.0

" include protection {{{
if exists("g:JAVA_CONFIG")
    finish
endif
let g:JAVA_CONFIG = 1
" }}}

" basic configurations override {{{

set tabstop=2
set shiftwidth=2
set softtabstop=2
set cindent                     " cindent

" }}}

" filetype keymaps {{{

" Compile:
nnoremap <buffer> <silent> <F7> :echo "Compiling ..." <cr> :echo system("javac ".expand("%")) <cr>

" Run:
nnoremap <buffer> <silent> <F6> :echo "Starting JVM ..." <cr> :echo system("java ".expand("%:t:r")." 2>&1") <cr>

inoremap <C-p> System.out.println()<esc>i

" }}}

" plugin configurations: {{{
"   auto-close Scratch when selected
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" }}}
