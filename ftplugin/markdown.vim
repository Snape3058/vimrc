" Markdown file configurations:
"
" author : Oikawa Kirie
" date   : 2021-07-14
" version: 1.0.0

" include protection {{{
if exists("g:MARKDOWN_CONFIG")
    finish
endif
let g:MARKDOWN_CONFIG = 1
" }}}

" basic configurations override {{{

" enable spell checking under en_US for tex-markdown files
setlocal spell spelllang=en_us

" enable auto compile when saving for tex-markdown files
autocmd BufWritePost *.mdtex AsyncRun make

" }}}

" filetype keymaps {{{
nnoremap <F7> :AsyncRun make <cr>

if &ft == "markdown.pandoc"

nnoremap <space>it o\tableobject{caption}{file_name}{position}<esc>5b
nnoremap <space>if o\figureobject{caption}{file_name}{file_type}{position}<esc>7b
nnoremap <space>ic o\codeobject{caption}{file_name}{file_type}{position}<esc>7b
nnoremap <space>io O<!--<esc>
nnoremap <space>ip o--><esc>
nnoremap <space>iO r<cr>O<!--<esc>
nnoremap <space>iP r<cr>O--><esc>

inoremap <c-f> <!--  --><left><left><left><left>

endif
" }}}

" plugin configurations: {{{

" auto-pairs: {{{
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"','*':'*','$':'$'}
let g:back_brackets += ['*', '$']
" }}}
" AsyncRun: {{{
let g:asyncrun_open = 6
" }}}

" }}}
