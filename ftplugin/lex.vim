" Flex file configurations:
"
" author : Oikawa Kirie
" date   : 2018-07-25
" version: 1.1.0

" include protection {{{
if exists("g:FLEX_CONFIG")
    finish
endif
let g:FLEX_CONFIG = 1
" }}}

" basic configurations override {{{

set tabstop=2
set shiftwidth=2
set softtabstop=2
set cindent                     " cindent
set cinoptions=l1,g0.5s,h0.5s   " cindent style
set tags+=~/.vim/tags/cpp

" }}}
