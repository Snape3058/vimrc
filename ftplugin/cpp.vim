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

" commands {{{
"   variables:
if "googletest" == &ft
    let gtestflags = " -lgtest -lgtest_main "
else
    let gtestflags = ""
endif

if "c" == &ft
    let cc = "gcc"
else
    let cc = "g++"
endif

let publicflags = " -g $(~/.vim/bin/syntasticFlags) "

"   create ctags
command Ctags :wa |:echo system("ctags -R --c++-kinds=+px --fields=+iaS --extra=+q .")

"   compile single file
if filereadable("GNUmakefile") || filereadable("makefile") || filereadable("Makefile")
    command Compile :make
else
    command Compile :echo system(cc.gtestflags.publicflags." -o ".expand("%:t:r")." ".expand("%"))
endif

"   run single file
command Run :echo system(" ./".expand("%:t:r")." 2>&1")
" }}}

" filetype keymaps {{{
nnoremap <F2> :Ctags<cr>
nnoremap <F6> :Run<cr>
nnoremap <F7> :Compile<cr>
" }}}

" plugin configurations: {{{

" OmniCppComplete: {{{
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_SelectFirstItem = 2
let OmniCpp_MayCompleteScope = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_NamespaceSearch = 2
"   auto-close Scratch when selected
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" }}}
" syntastic: {{{
let g:syntastic_cpp_compiler_options = '-Wall '
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_config_file = '.syntastic_cpp_config'
" }}}

" }}}
