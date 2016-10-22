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
"set lazyredraw " redraw only when we need to.
set ff=unix

if v:version >= 700
	set numberwidth=3
endif

set modeline

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
set tabstop=4
set shiftwidth=4
set wildmenu
set cursorline
set showcmd
" Enable smart indenting
filetype plugin indent on
set autoindent

let g:tex_flavor='latex'

" Filetype specific stuff
au FileType c,cpp,tex set colorcolumn=81
au FileType python set colorcolumn=121
au FileType ml,tex,html set shiftwidth=2 tabstop=2 expandtab

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
nnoremap <A-J> <C-W><C-J>
nnoremap <A-K> <C-W><C-K>
nnoremap <A-L> <C-W><C-L>
nnoremap <A-H> <C-W><C-H>

autocmd Syntax * syn match ExtraWhitespace /\S\s\+$/
set listchars=tab:>-,trail:~,extends:>,precedes:<
set list

command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" }}}

function! InsertStatuslineColor(mode)
	if a:mode == 'i'
		hi statusline ctermfg=40 ctermbg=0
	elseif a:mode == 'r'
		hi statusline ctermfg=160 ctermbg=0
	else
		hi statusline ctermfg=1 ctermbg=0
	endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline ctermfg=4 ctermbg=0
hi statusline ctermfg=4 ctermbg=0

" Status Line {{{
set statusline =%#identifier#
set statusline+=[%f]    "tail of the filename
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#warningmsg#
set statusline+=%m
set statusline+=%*

"set statusline+=%{fugitive#statusline()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
	if !exists("b:statusline_trailing_space_warning")

		if !&modifiable
			let b:statusline_trailing_space_warning = ''
			return b:statusline_trailing_space_warning
		endif

		if search('\s\+$', 'nw') != 0
			let b:statusline_trailing_space_warning = '[\s]'
		else
			let b:statusline_trailing_space_warning = ''
		endif
	endif
	return b:statusline_trailing_space_warning
endfunction


"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
	let name = synIDattr(synID(line('.'),col('.'),1),'name')
	if name == ''
		return ''
	else
		return '[' . name . ']'
	endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
	if !exists("b:statusline_tab_warning")
		let b:statusline_tab_warning = ''

		if !&modifiable
			return b:statusline_tab_warning
		endif

		let tabs = search('^\t', 'nw') != 0

		"find spaces that arent used as alignment in the first indent column
		let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

		if tabs && spaces
			let b:statusline_tab_warning =  '[mixed-indenting]'
		elseif (spaces && !&et) || (tabs && &et)
			let b:statusline_tab_warning = '[&et]'
		endif
	endif
	return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
	if !exists("b:statusline_long_line_warning")

		if !&modifiable
			let b:statusline_long_line_warning = ''
			return b:statusline_long_line_warning
		endif

		let long_line_lens = s:LongLines()

		if len(long_line_lens) > 0
			let b:statusline_long_line_warning = "[" .
						\ '#' . len(long_line_lens) . "," .
						\ 'm' . s:Median(long_line_lens) . "," .
						\ '$' . max(long_line_lens) . "]"
		else
			let b:statusline_long_line_warning = ""
		endif
	endif
	return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
	let threshold = (&tw ? &tw : 80)
	let spaces = repeat(" ", &ts)
	let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
	return filter(line_lens, 'v:val > threshold')
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
	let nums = sort(a:nums)
	let l = len(nums)

	if l % 2 == 1
		let i = (l-1) / 2
		return nums[i]
	else
		return (nums[l/2] + nums[(l/2)-1]) / 2
	endif
endfunction
" }}}
