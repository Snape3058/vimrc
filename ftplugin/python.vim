" Python file configurations:
"
" author : Oikawa Kirie
" date   : 2018-07-25
" version: 1.1.0

" include protection {{{
if exists("g:PYTHON_CONFIG")
    finish
endif
let g:PYTHON_CONFIG = 1
" }}}

" basic configurations override {{{

retab
set nocindent
set tags+=~/.vim/tags/python

" }}}

" filetype keymaps {{{
nnoremap <F6> :!./%<cr>
" }}}

" plugin configurations: {{{

" OmniCppComplete: {{{
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_SelectFirstItem = 2
let OmniCpp_MayCompleteDot = 1
" auto-close Scratch when selected
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" }}}
" syntastic: {{{
let g:syntastic_python_checkers=['flake8']
" }}}

" }}}
