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

" enable spell checking under en_US
setlocal spell spelllang=en_us

" enable auto compile when saving
autocmd BufWritePost *.tex AsyncRun make

" }}}

" filetype keymaps {{{
nnoremap <F7> :make <cr>
nnoremap <F6> :!xdg-open "%:t:r.pdf" &<cr>
nnoremap <silent> ,= :!ydcv <cword> <cr>
" }}}

" plugin configurations: {{{

" auto-pairs: {{{
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':"'", '$':'$'}
let g:back_brackets += ['$']
" }}}
" AsyncRun: {{{
let g:asyncrun_open = 6
nnoremap <silent>,, :cclose<cr>
" }}}

" }}}
