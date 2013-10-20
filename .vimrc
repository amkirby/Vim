
" An example for a vimrc file.
"
" Original Maintainer:	Bram Moolenaar <Bram@vim.org> 
" Last change: 2011 Apr 15
"
" Current Maintainer: Allen Kirby

"Pathogen setup
filetype off
call pathogen#incubate()
call pathogen#helptags()

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " For all text files set 'textwidth' to 70 characters.
  autocmd FileType text setlocal textwidth=70

  " For C, C++ type files set abbreviations for #include and #define
  autocmd FileType cpp ab #i #include
  autocmd FileType cpp ab #d #define

  " Automatically source the .vimrc file when saved
  autocmd BufWritePost .vimrc source $MYVIMRC
else

  set smartindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Allen's added configs
set scrolloff=3 " minimum number of lines to keep above and below the cursor
set textwidth=70 " set the text with to 70 columns
set background=dark " set the background to be dark
colorscheme darkblue " set the colorscheme to darkblue

" remap the semicolon to insert the colon in normal mode 
nnoremap ; : 

" maps the Control - vim directions to perform window movements
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

set showmode " displays the current mode

set linebreak " sets line to break at a word

" has the up and down movement keys move through split lines
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$

set hidden " hides buffers instead of closing them when opening a new buffer
set noswapfile " does not create a swap file
let mapleader=',' " set map leader to comma instead of \

" Text / whitespace
set shiftwidth=4 " number of spaces to use for autoindenting
set showmatch " shows matching parens
set smartcase " ignores case in search if all lowercase
set tabstop=4 " set tab character to 4 characters
set softtabstop=4 
set expandtab " turn tabs into whitespace
set laststatus=2 " always show status line
set autowrite " autowrites the current file when opening another file
set formatoptions=tcq

" This autocmd if is used for setting whitespace preferences for
" certain file types. It is placed after global whitespace so it will
" take precedence
if has("autocmd")
  autocmd FileType make setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
  autocmd BufNewFile,BufRead .vimrc setlocal tabstop=2 softtabstop=2 shiftwidth=2
  au BufNewFile * start
endif " whitespace preference autocmd

" Emacs shortcuts for cursor movement in insert mode
imap <C-f> <Right>
imap <C-b> <Left>
imap <C-a> <Home>
imap <C-e> <End>
imap <C-n> <Down>
imap <C-p> <Up>

" map leader commands
map <Leader>w :w<CR>
map <Leader>ww :wq<CR>
map <Leader>q :q<CR>
map <Leader>qq :q!<CR>
map <Leader>v :vsplit<CR>
map <Leader>s :split<CR>
map <Leader>b <C-^>

" automatically inserts the closing paren
inoremap ( ()<Left>
inoremap [ []<Left>

" automatically add the closing brace and move up and tab to the
" correct position
inoremap { {<CR><CR>}<Up><Tab>

"set the status line to display file name, encoding, modified, help,
"and type
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

iab teh the 
