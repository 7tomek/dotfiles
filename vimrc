call plug#begin('~/.vim/plugged')

Plug 'elzr/vim-json'
Plug 'wombat256.vim'
Plug 'kien/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'taglist.vim'
Plug 'scrooloose/nerdtree'
Plug 'Chiel92/vim-autoformat'
Plug 'OmniCppComplete'

call plug#end()

" Autoformat
let g:formatprg_cs = "astyle"
let g:formatprg_args_cs = "--mode=c --style=linux -pcHs4"
noremap <F3> :Autoformat<CR><CR>

set backspace=2
set noswapfile
set t_Co=256
syntax on
set number

set tags+=~/.vim/tags/c
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/local

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

colorscheme wombat256mod

function! UpdateTags()
	  execute ":!ctags -R --languages=C++ --c++-kinds=+p --fields=+iaS --extra=+q ./"
	    echohl StatusLine | echo "C/C++ tag updated" | echohl None
endfunction
nnoremap <F4> :call UpdateTags()
