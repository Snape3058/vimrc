" LaTeX file configurations:
"
" author : Oikawa Kirie
" date   : 2018-07-25
" version: 1.1.0

" include protection {{{
if exists("g:LATEX_CONFIG")
    finish
endif
let g:LATEX_CONFIG = 1
" }}}

" basic configurations override {{{

setlocal spell spelllang=en_us

" }}}

" filetype keymaps {{{
nnoremap <F7> :!tex2pdf "%"<cr>
nnoremap <F6> :!evince "%:t:r.pdf" &<cr>
" }}}

" plugin configurations: {{{

" auto-pairs: {{{
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':"'", '$':'$'}
let g:back_brackets += ['$']
" }}}
" syntastic: {{{
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_tex_checkers=['chktex']
" }}}

" }}}
