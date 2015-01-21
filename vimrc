call plug#begin('~/.vim/plugged')

Plug 'elzr/vim-json'
Plug 'wombat256.vim'
Plug 'kien/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'taglist.vim'
Plug 'scrooloose/nerdtree'
Plug 'Chiel92/vim-autoformat'
Plug 'OmniCppComplete'
Plug 'gtags.vim'
Plug 'fatih/molokai'
Plug 'cscope_macros.vim'
Plug 'endel/vim-github-colorscheme'
Plug 'therubymug/vim-pyte'
Plug 'reedes/vim-colors-pencil'

call plug#end()

" Autoformat
let g:formatprg_cs = "astyle"
let g:formatprg_args_cs = "--mode=c --style=linux -pcHs4"
noremap <F3> :Autoformat<CR><CR>

if has("gui_running")
	" No toolbars, menu or scrollbars in the GUI
	set guifont=Monospace\ 10
	set clipboard+=unnamed
	set vb t_vb=
	set guioptions-=m  "no menu
	set guioptions-=T  "no toolbar
	set guioptions-=l
	set guioptions-=L
	set guioptions-=r  "no scrollbar
	set guioptions-=R

	let macvim_skip_colorscheme=1
	let g:molokai_original=1
	highlight SignColumn guibg=#272822

	" Open ctrlp with cmd+p
	" let g:ctrlp_map = '<D-p>'

	" Open goto symbol on current buffer
	nmap <D-r> :MyCtrlPTag<cr>
	imap <D-r> <esc>:MyCtrlPTag<cr>

	" Open goto symbol on all buffers
	nmap <D-R> :CtrlPBufTagAll<cr>
	imap <D-R> <esc>:CtrlPBufTagAll<cr>

	" Open goto file
	nmap <D-t> :CtrlP<cr>
	imap <D-t> <esc>:CtrlP<cr>

	" Comment lines with cmd+/
	map <D-/> :TComment<cr>
	vmap <D-/> :TComment<cr>gv

	" Indent lines with cmd+[ and cmd+]
	nmap <D-]> >>
	nmap <D-[> <<
	vmap <D-[> <gv
	vmap <D-]> >gv

	" This mapping makes Ctrl-Tab switch between tabs.
	" Ctrl-Shift-Tab goes the other way.
	noremap <C-Tab> :tabnext<CR>
	noremap <C-S-Tab> :tabprev<CR>

	" switch between tabs with cmd+1, cmd+2,..."
	map <D-1> 1gt
	map <D-2> 2gt
	map <D-3> 3gt
	map <D-4> 4gt
	map <D-5> 5gt
	map <D-6> 6gt
	map <D-7> 7gt
	map <D-8> 8gt
	map <D-9> 9gt

	" until we have default MacVim shortcuts this is the only way to use it in
	" insert mode
	imap <D-1> <esc>1gt
	imap <D-2> <esc>2gt
	imap <D-3> <esc>3gt
	imap <D-4> <esc>4gt
	imap <D-5> <esc>5gt
	imap <D-6> <esc>6gt
	imap <D-7> <esc>7gt
	imap <D-8> <esc>8gt
	imap <D-9> <esc>9gt
endif

set backspace=2
set t_Co=256
syntax on
set number
nmap <C-Space> <C-X><C-O>
set tags+=~/.vim/tags/tags
set backspace=2
set noswapfile

set tags+=~/.vim/tags/c
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/local
set tags+=~/.vim/tags/go

"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'

""nmap <c-t> :tabnew<cr>
""nmap <c-i> :bnext<cr>
""nmap <c-s-i> :bprevious<cr>

map <C-e> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

map <C-F6> :ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

map <C-a> <esc>ggVG<CR>
com! FormatJSON %!python -m json.tool
com! FormatHTML %!tidy -mi -html -wrap 0 %

set omnifunc=syntaxcomplete#Complete " override built-in C omnicomplete with C++ OmniCppComplete plugin
let OmniCpp_GlobalScopeSearch   = 1
let OmniCpp_DisplayMode         = 1
let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace in pop-up
let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop-up
let OmniCpp_ShowAccess          = 1 "show access in pop-up
let OmniCpp_SelectFirstItem     = 1 "select first item in pop-up
set completeopt=menuone,menu,longest

let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
highlight   clear
highlight   Pmenu         ctermfg=0 ctermbg=2
highlight   PmenuSel      ctermfg=0 ctermbg=7
highlight   PmenuSbar     ctermfg=7 ctermbg=0
highlight   PmenuThumb    ctermfg=0 ctermbg=7


function! UpdateTags()
	execute ":!ctags -R --languages=C++ --c++-kinds=+p --fields=+iaS --extra=+q ./"
	echohl StatusLine | echo "C/C++ tag updated" | echohl None
endfunction
nnoremap <F4> :call UpdateTags()

colorscheme pencil
set background=dark
