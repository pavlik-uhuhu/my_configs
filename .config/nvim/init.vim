lua require('lazy_config')

so /Users/pavlik/.config/nvim/functions.vim

"nnoremap ZZ :Q<CR>
"nnoremap ZQ :Q<CR>

nnoremap <LeftMouse> <Cmd>let temp=&so<cr><Cmd>let &so=0<cr><LeftMouse><Cmd>let &so=temp<cr>
nmap <CR> o<Esc>
nmap <S-Q> :tabclose <CR>
noremap <silent> <C-s> :w <CR>

nnoremap <C-e> :Telescope buffers <cr>
nnoremap <C-m> :Telescope marks <CR>
nnoremap <space>a :Telescope diagnostics<cr> 
nnoremap <C-g> :Telescope lsp_references show_line=false <cr>
nnoremap <F4> :Telescope lsp_type_definitions show_line=false <cr>
nnoremap <F5> :Telescope lsp_document_symbols <CR>
noremap <silent> <C-w> :b# <CR> :bd # <CR>
nmap <silent> gs :Git <CR>

autocmd BufRead Cargo.toml nnoremap <buffer> <F2> :lua require('crates').show_popup() <cr>

nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> :call nerdcommenter#Comment(1, 'sexy') <CR>

"nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" normal mode:
nnoremap <c-j> 5j
nnoremap <c-k> 5k
nnoremap <c-l> 5k
" visual mode:
xnoremap <c-j> 5j
xnoremap <c-k> 5k

"noremap <silent> <c-left> <c-o>
"nmap <silent> <c-right> <c-i>

map <C-n> :Neotree toggle<CR>
nnoremap <silent> <space>r  :Neotree reveal<cr>

set nocompatible
set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
set hidden
set laststatus=2
filetype plugin indent on
syntax on
set number
set relativenumber
set incsearch
set ignorecase
set smartcase
set hlsearch
set incsearch
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set nobackup
"set noswapfile
set nowrap
set completeopt-=preview
set updatetime=200
set signcolumn=yes
set wildignore+=*/tmp/*,*/target/*
set mouse=a
set cursorline
set termguicolors
set iskeyword-=_
set scrolloff=999

"autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;./tags;/,$RUST_SRC_PATH/rusty-tags.vi
"autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
au BufWrite *.rs :Autoformat
au BufWrite *.go :Autoformat

let g:formatdef_rustfmt = '"rustfmt"'

let g:python3_host_prog = "/usr/bin/python3"

let g:tagbar_map_nexttag='n'
let g:tagbar_map_prevtag='<S-n>'
let g:tagbar_width = 65
let g:tagbar_type_rust = {
            \ 'ctagsbin' : '/opt/homebrew/bin/ctags',
            \ 'ctagstype' : 'rust',
            \ 'kinds' : [
            \ 'n:modules',
            \ 's:structures:1',
            \ 'i:interfaces',
            \ 'c:implementations',
            \ 'f:functions:1',
            \ 'g:enumerations:1',
            \ 't:type aliases:1:0',
            \ 'v:constants:1:0',
            \ 'M:macros:1',
            \ 'm:fields:1:0',
            \ 'e:enum variants:1:0',
            \ 'P:methods:1',
            \ ],
            \ 'sro': '::',
            \ 'kind2scope' : {
            \ 'n': 'module',
            \ 's': 'struct',
            \ 'i': 'interface',
            \ 'c': 'implementation',
            \ 'f': 'function',
            \ 'g': 'enum',
            \ 't': 'typedef',
            \ 'v': 'variable',
            \ 'M': 'macro',
            \ 'm': 'field',
            \ 'e': 'enumerator',
            \ 'P': 'method',
            \ },
            \ }
let g:rust_use_custom_ctags_defs = 1

let g:bufferline_modified = '+'
let g:rooter_patterns = ['.git/']

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'
