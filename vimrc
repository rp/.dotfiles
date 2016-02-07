" /\ \    _ / /\      /\ \      /\_\/\_\ _   
" \ \ \  /_/ / /      \ \ \    / / / / //\_\ 
"  \ \ \ \___\/       /\ \_\  /\ \/ \ \/ / / 
"  / / /  \ \ \      / /\/_/ /  \____\__/ /  
"  \ \ \   \_\ \    / / /   / /\/________/   
"   \ \ \  / / /   / / /   / / /\/_// / /    
"    \ \ \/ / /   / / /   / / /    / / /     
"     \ \ \/ /___/ / /__ / / /    / / /      
"      \ \  //\__\/_/___\\/_/    / / /       
"       \_\/ \/_________/        \/_/        
"
"			-- Rahul Parhi

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
set mouse=a " mouse use
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

" make sure to use term background
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
" We use 80 characters for C/C++, 120 for Python
au FileType c set colorcolumn=81
au FileType cpp set colorcolumn=81
au FileType python set colorcolumn=121

" write to files with root privileges
cmap w!! w !sudo tee % > /dev/null

" Word count in latex documents. Make sure detex is installed.
map <F3> :w !detex \| wc -w<CR>
" toggle spell check
map <F4> :setlocal spell! spelllang=en_us<CR>

" Let <F5> strip away trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Let <F2> toggle paste mode because of smart indenting being a dummy
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" move to beginning/end of line
nnoremap B ^
nnoremap E $
" make old things do nothing $/^
nnoremap $ <nop>
nnoremap ^ <nop>

" lightline config cuz it looks so kewl
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'component': {
      \   'readonly': '%{&readonly?"x":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

" }}}
