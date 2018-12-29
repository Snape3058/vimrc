" vimrc:
"
" author : Oikawa Kirie
" date   : 2018-06-15
" version: 1.1.0

" basic configurations {{{

set nocompatible        " not compatible to vi (nocp)
syntax enable           " syntax highlight
syntax on
set enc=utf-8           " set charset
set number              " line number
set autoindent          " indent
set smartindent
set tabstop=4           " tab = 4 spaces for default
set shiftwidth=4
set softtabstop=4
set expandtab
set background=dark     " interface color
set t_Co=256
set laststatus=2
set cursorline          " highlight current line
set hlsearch            " highlight search result
set mouse=a             " hold <shift> key to discard mouse=a and select to copy
set ttimeoutlen=10
set timeoutlen=1000
set foldmethod=marker   " enable marker folding
set wildignorecase      " ignore case when completing path/file names

" auto resize window when host window is resized
autocmd VimResized * wincmd =

" }}}

" additional highlight configurations {{{

"   highlight EOL white spaces
au InsertEnter * syntax match WhitespaceEOL /\s\+\%#\@<!$/
au InsertLeave * syntax match WhitespaceEOL /\s\+$/
highlight WhitespaceEOL ctermbg=Red guibg=Red

"   highlight the part that above line length limit
au BufRead,BufNewFile * syntax match LongLine /\%>80v.\+/
highlight LongLine ctermbg=Red guibg=Red

" }}}

" commands {{{

"   date and time
"   require: date
command Date read !date "+\%Y-\%m-\%d"
command Time read !date "+\%H:\%M:\%S"

"   search and unsearch
command HighLightCursorWord let @/='\V\<'.escape(expand('<cword>'), '\').'\>' | set hlsearch
command HighLightClear let @/=''

"   spell check switch
command SpellCheckOn setlocal spell spelllang=en_us
command SpellCheckOff setlocal spell spelllang=

"   long line highlight switch
command LineLengthCheckOn highlight LongLine ctermbg=Red guibg=Red
command LineLengthCheckOff highlight LongLine ctermbg=NONE guibg=NONE

"   clear EOL white spaces
command ClearEOLWhiteSpace %s/[ 	 ]\+$//g

"   use sudo to force write a file
"   require: sudo
command SudoWrite w !sudo tee % >/dev/null
cabbrev w!! <c-r>=(':' == getcmdtype() && 1 == getcmdpos() ? 'SudoWrite' : 'w!!')<cr>

"   paste from system clipboard (in case system clipboard will not work in vim)
"   require: xclip
command Paste read !xclip -out

"   upper case version to compatible with addtional shift key
command Q q
command Qa qa
command QA qa
command W w
command Wa wa
command WA wa
command Wq wq
command WQ wq
command Vs vs
command VS vs
command Sp sp
command SP sp

" }}}

" global keymaps {{{

"   window view
nnoremap <up> kzz
nnoremap <down> jzz
nnoremap <left> zt
nnoremap <right> zb

"   window forcus
nnoremap <silent> ,m :up<cr>:wincmd h<cr>
nnoremap <silent> ,l :up<cr>:wincmd l<cr>
nnoremap <silent> ,k :up<cr>:wincmd k<cr>
nnoremap <silent> ,j :up<cr>:wincmd j<cr>

"   long line highlight switch
nnoremap <silent> ,- :LineLengthCheckOn<cr>
nnoremap <silent> ,_ :LineLengthCheckOff<cr>

"   search and unsearch
nnoremap <silent> ,/ :HighLightCursorWord<cr>
nnoremap <silent> _ :HighLightClear<cr>
nnoremap <silent> <2-LeftMouse> :HighLightCursorWord<cr>
nnoremap <silent> <2-RightMouse> :HighLightClear<cr>

"   spell check
nnoremap <silent> ,' :SpellCheckOn<cr>
nnoremap <silent> ,'_ :SpellCheckOff<cr>

"   new white line
nnoremap - o<esc>
nnoremap + O<esc>

" }}}

" Vundle (plugin management) {{{

" pre load vundle {{{
if 0 != system("ls ~/.vim/bundle/Vundle.vim/ 2>/dev/null 1>/dev/null; echo $?")
    "   define a command to install Vundle if not installed
    "   otherwise, load vundle configurations
    echo "Vundle not installed, execute 'InstallVundle' to install Vundle."
    command InstallVundle !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
    " required by Vundle
    filetype off
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    " }}}

    " load plugins: username/repo
    "   Vundle
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'eparreno/vim-l9'

    "   plugins
    Plugin 'vim-scripts/AutoComplPop'
    Plugin 'vim-scripts/OmniCppComplete'
    Plugin 'scrooloose/syntastic'
    Plugin 'jiangmiao/auto-pairs'
    Plugin 'Lokaltog/vim-powerline'
    Plugin 'rhysd/vim-clang-format'

    "   syntax highlight rules
    Plugin 'Mizuchi/STL-Syntax'
    Plugin 'pix/vim-known_hosts'
    Plugin 'Snape3058/vim-smali'
    Plugin 'bohlender/vim-smt2'

    " post load vundle {{{
    call vundle#end()
    filetype plugin indent on
endif
" }}}

" }}}

" plugin configurations: {{{

" OmniCppComplete: {{{
"    set function with filetype
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType googletest set omnifunc=cppcomplete#Complete
" }}}
" auto-pairs {{{
"     set <tab> as close operator
let g:back_brackets = [')', ']', '"', "'", '}', '`']
inoremap <expr> <tab> index(g:back_brackets, getline('.')[col('.')-1]) >= 0 ? "\<right>" : "\<tab>"
" }}}
" syntastic: {{{
let g:syntastic_error_symbol='!>'
let g:syntastic_warning_symbol='*>'
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_auto_loc_list = 1
let g:syntastic_filetype_map = { 'googletest': 'cpp' }
nnoremap <silent> ,, :SyntasticReset<cr>
nnoremap <silent> ,. :SyntasticCheck<cr>
" }}}
" clang-format {{{
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1
let g:clang_format#auto_formatexpr = 1
" }}}

" }}}
