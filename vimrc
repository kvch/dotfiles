"
" PLUGINS
"
execute pathogen#infect('bundle/{}')

" CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'r'

" Tagbar
let g:tagbar_width = 50
let g:tagbar_autofocus = 1

let g:task_readonly = 0

" Markdown
let g:vim_markdown_folding_disabled = 1

" vim-go
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>gd <Plug>(go-doc)
let g:go_fmt_command = "goimports"
let g:go_fmt_options = "-local=github.com/elastic"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Rust
let g:rustfmt_autosave = 1

set t_Co=256

syntax on
filetype plugin indent on

let mapleader=","
colorscheme molokai
set wildmenu
set lazyredraw
set backspace=indent,eol,start
set autoread
set noswapfile

set ignorecase
set smartcase
set showmatch
set incsearch
set hlsearch

set autoindent
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
set foldenable

set number
set cursorline
set confirm

" Commands
command! Q :q
command! Qall :qall
command! QAll :qall
command! W :w
command! Wq :wq
command! WQ :wq
command! Wqall :wqall
command! WQall :wqall
command! WQAll :wqall

set laststatus=2

" Hotkeys
inoremap ;; <esc>

nnoremap <F2> :set rnu! \| :set nu!<CR>
nmap <F4> :nohl<CR>
nmap <F5> :source ~/.vimrc<CR>
nmap <F6> :SyntasticReset<CR>
nmap <F7> :SyntasticCheck<CR>
nmap <F8> :TagbarToggle<CR>
nmap <F9> :%s/\s\+$//<CR>
nmap <F10> :setlocal spell spelllang=en_us<CR>

"nmap ip oimport ipdb; ipdb.set_trace()<ESC>

nmap Gt :GoTest<CR>
nmap Gli :GoLint<CR>
nmap Gbu :GoBuild<CR>
nmap Gd :GoDef<CR>

nmap ~~ <Home>i~~<ESC>A~~<ESC>
nmap ~x :s/- \[ \]/- \[x\]/<CR>

"Rust stuff
nmap Rsf i<Right>String::from("")<ESC>hi
nmap Rp i<Right>println!("")<ESC>hi


nmap Ts $i<Right>;
inoremap Ts <ESC>$i<Right>;

"nmap ;im o\begin{figure}[h]<CR>\begin{minted}[breaklines, breakbytoken, fontsize=\footnotesize, bgcolor=codebg]{c}<CR>%%%<CR>\end{minted}<CR>\end{figure}<ESC>
"imap <buffer> mn <C-O>/%%%<CR><C-O>c3l
"nmap <buffer> mn /%%%<CR>c3l

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

vnoremap < <gv
vnoremap > >gv
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

highlight colorcolumn ctermbg=darkgrey guibg=darkgrey
set colorcolumn=121
