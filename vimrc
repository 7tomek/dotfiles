call plug#begin('~/.vim/plugged')

Plug 'elzr/vim-json'
Plug 'wombat256.vim'
Plug 'kien/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
Plug 'gtags.vim'
Plug 'fatih/molokai'
Plug 'tomtom/tcomment_vim'
Plug 'fatih/vim-go' 
Plug 'Shougo/neocomplete.vim'
Plug 'toyamarinyon/vim-swift'

call plug#end()

colorscheme distinguished

filetype plugin indent on    " required

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
let g:neocomplete#sources#tags#cache_limit_size = 5000000
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'


" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

"" Settings
" 
set noerrorbells                " No beeps
set number                      " Show line numbers
set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing
set showmode                    " Show current mode.

set noswapfile                  " Don't use swapfile
set nobackup            	    " Don't create annoying backup files
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set encoding=utf-8              " Set default encoding to UTF-8
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set laststatus=2

set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats

if has("gui_macvim")
" No toolbars, menu or scrollbars in the GUI
set guifont=Anka/Coder:h13
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
else

set backspace=2
set t_Co=256
syntax on
set number
nmap <C-Space> <C-X><C-O>
set tags+=~/.vim/tags/tags
set tags+=~/.vim/tags/gotags
set tags+=~/.vim/tags/iossystemlibframework
"set tags+=~/.vim/tags/systemobjtags
endif


map <C-Q> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

map <C-F6> :ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

map <C-a> <esc>ggVG<CR>
com! FormatJSON %!python -m json.tool
com! FormatHTML %!tidy -mi -html -wrap 0 %

function! UpdateTags()
	  execute ":!ctags -R --languages=C++ --c++-kinds=+p --fields=+iaS --extra=+q ./"
	    echohl StatusLine | echo "C/C++ tag updated" | echohl None
endfunction
nnoremap <F4> :call UpdateTags()

" ==================== Vim-go ====================
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "gofmt"
let g:go_bin_path = "/usr/local/go/bin"

au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)
au FileType go nmap <Leader>t <Plug>(go-def-tab)

au FileType go nmap <Leader>i <Plug>(go-info)

au FileType go nmap  <leader>r  <Plug>(go-run)
au FileType go nmap  <leader>b  <Plug>(go-build)

au FileType go nmap <Leader>d <Plug>(go-doc)
