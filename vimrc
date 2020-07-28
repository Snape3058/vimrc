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
set pastetoggle=<F3>    " press <F3> to switch on/off paste mode

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
nnoremap <silent> ,. :up<cr>:wincmd l<cr>
nnoremap <silent> ,k :up<cr>:wincmd k<cr>
nnoremap <silent> ,j :up<cr>:wincmd j<cr>

"   tab control
nnoremap <silent> ,x :tabclose<cr>gT
nnoremap <silent> ,X :tabclose<cr>
nnoremap <silent> ,t <C-W>T

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

"   quick-fix window
nnoremap <silent> ,f :copen 10<cr>
nnoremap <silent> ,c :ccl<cr>

"   new white line
nnoremap - o<esc>
nnoremap + O<esc>

" }}}

" plugin management {{{

" pre load plugin manager {{{
if 0 != system("ls ~/.vim/autoload/plug.vim 1>/dev/null 2>/dev/null; echo $?")
    "   define a command to install plugin manager if not installed
    "   otherwise, load plugin manager configurations
    echo "Plugin manager is not installed, execute 'InstallPluginManager' to install it."
    command InstallPluginManager !curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --create-dirs -o ~/.vim/autoload/plug.vim
else
    call plug#begin('~/.vim/bundle/')
    " }}}

    "   plugins
    Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
    Plug 'Shougo/deoplete.nvim', { 'do': 'pip3 install --user pynvim' }
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'

    Plug 'jiangmiao/auto-pairs'
    Plug 'vim-airline/vim-airline'
    Plug 'rhysd/vim-clang-format'
    Plug 'skywind3000/asyncrun.vim'
    "   Repo junegunn/fzf.vim requires functions defined in junegunn/fzf/plugin/fzf.vim
    "   Download this file to /usr/share/vim/vimfiles/plugin/ or
    "   install package archlinux/community/fzf
    Plug 'junegunn/fzf.vim'

    "   syntax highlight rules
    Plug 'Mizuchi/STL-Syntax'
    Plug 'pix/vim-known_hosts'
    Plug 'Snape3058/vim-smali'
    Plug 'bohlender/vim-smt2'

    " post load plugin manager {{{
    call plug#end()
endif
" }}}

" }}}

" plugin configurations: {{{

" LanguageClient {{{
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_serverCommands.c = ['clangd']
let g:LanguageClient_serverCommands.cpp = ['clangd']
let g:LanguageClient_serverCommands.python = ['pyls']
let g:LanguageClient_rootMarkers = {
            \ 'cpp': ['compile_commands.json', 'build'],
            \ 'c': ['compile_commands.json', 'build']
            \ }

nnoremap <silent> ,] :call LanguageClient#textDocument_definition({'gotoCmd': 'vsplit'}) <cr>
nnoremap <silent> ,[ :call LanguageClient#textDocument_references({'gotoCmd': 'vsplit'}) <cr>
" }}}
" deoplete {{{
call deoplete#enable()
call deoplete#custom#option('smart_case', 1)
inoremap <expr><c-j> pumvisible() ? "\<c-n>" : "\<c-j>"
inoremap <expr><c-k> pumvisible() ? "\<c-p>" : "\<c-k>"
" }}}
" auto-pairs {{{
"     set <tab> as close operator
let g:back_brackets = [')', ']', '"', "'", '}', '`']
inoremap <expr> <tab> index(g:back_brackets, getline('.')[col('.')-1]) >= 0 ? "\<right>" : "\<tab>"
" }}}
" clang-format {{{
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1
let g:clang_format#auto_formatexpr = 1
" }}}
" fzf {{{
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'alt-enter': 'tab split',
    \ 'enter': 'vsplit'}
nnoremap <silent> ,o <esc>:Files<cr>
nnoremap <silent> ,? <esc>:Lines<cr>
" }}}

" }}}
