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

" commands {{{

"   create ctags
command Ctags :wa |:echo system("ctags -R --c++-kinds=+px --fields=+iaS --extra=+q .")

"   compile single file
if filereadable("GNUmakefile") || filereadable("makefile") || filereadable("Makefile")
    command Compile :make
else
    command Compile :echo system("javac ".expand("%"))
endif

"   run single file
command Run :echo system("java ".expand("%:t:r")." 2>&1")
" }}}

" filetype keymaps {{{
inoremap <C-p> System.out.println()<esc>i
nnoremap <F2> :Ctags<cr>
nnoremap <F6> :Run<cr>
nnoremap <F7> :Compile<cr>
" }}}

" plugin configurations: {{{

" syntastic: {{{
let g:syntastic_java_javac_config_file_enabled = 1
let g:syntastic_java_javac_config_file = '.syntastic_java_config'
" }}}

" }}}
