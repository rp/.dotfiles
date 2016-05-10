" MAIN {{{

" general
set autoread
set autowrite
set noswapfile
set nobackup
set encoding=utf-8
set fileencoding=utf-8
set number " show line numbers
set showmatch " highlight matching [{()}]
set backspace=indent,eol,start " fix backspace cuz it sucks
set mouse=nicr " mouse used only for scrolling
set ruler " show cursor position
set lazyredraw " redraw only when we need to.

" search
set incsearch " search as characters are entered
set hlsearch " highlight matches
set ignorecase
set smartcase

" move vertically by visual line (wrapped text)
nnoremap j gj
nnoremap k gk

" color/theme
syntax on
set t_Co=256
set background=dark
colorscheme jellybeans

" make sure to use term background regardless of colorscheme
highlight Normal ctermbg=NONE
highlight LineNr ctermbg=NONE
highlight nonText ctermbg=NONE

" indent
set tabstop=4 " visually tab = 4 spaces, but is still \t
set shiftwidth=4 " make autoindent and > work with tabstop
set wildmenu " visual autocomplete for command menu
set cursorline " highlight current line
set showcmd
" Enable smart indenting
filetype plugin indent on
set autoindent
"set smarttab

" markdown stuff
autocmd BufRead,BufNew *.md set filetype=markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

" Set line limits based on filetype
au FileType c set colorcolumn=81
au FileType cpp set colorcolumn=81
au FileType python set colorcolumn=121

" write to files with root privileges
cmap w!! w !sudo tee % > /dev/null

" <F2> toggle paste mode because of smart indenting being a dummy
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" <F3> Word count in latex documents. Make sure detex is installed.
nnoremap <F3> :w !detex \| wc -w<CR>

" <F4> toggle spell check
nnoremap <F4> :setlocal spell! spelllang=en_us<CR>

" <F5> strip away trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Ctrl + l to remove highlighting
nnoremap <C-L> :nohlsearch<CR><C-L>

" move to beginning/end of line
nnoremap B ^
nnoremap E $
" make old things do nothing $/^
nnoremap $ <nop>
nnoremap ^ <nop>

" split navigation with Alt + {j,k,l,h}
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'
" }}}
