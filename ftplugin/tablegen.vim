" Vim filetype plugin file
" Language: LLVM TableGen
" Maintainer: The LLVM team, http://llvm.org/
" Modified from original version.

" include protection {{{
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1
" }}}

" basic configurations override {{{

setlocal matchpairs+=<:>
setlocal softtabstop=2 shiftwidth=2
setlocal expandtab

" }}}

" plugin configurations: {{{

" auto-pairs {{{
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '<':'>'}
let g:back_brackets += ['>']
" }}}

" }}}
