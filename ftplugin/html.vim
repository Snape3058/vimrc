" HTML file configurations:
"
" author : Oikawa Kirie
" date   : 2018-07-25
" version: 1.1.0

" include protection {{{
if exists("g:HTML_CONFIG")
    finish
endif
let g:HTML_CONFIG = 1
" }}}

" filetype keymaps {{{
nnoremap <F6> :!firefox %<cr>
" }}}

" plugin configurations: {{{

" auto-pairs {{{
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '<':'>'}
let g:back_brackets += ['>']
" }}}

" }}}
