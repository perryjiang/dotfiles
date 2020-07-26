""" Plugins
packadd! matchit
packadd! termdebug

function! PackInit() abort
  packadd minpac

  call minpac#init()

  call minpac#add('LucHermitte/alternate-lite')
  call minpac#add('LucHermitte/lh-brackets')
  call minpac#add('LucHermitte/lh-cpp')
  call minpac#add('LucHermitte/lh-dev')
  call minpac#add('LucHermitte/lh-style')
  call minpac#add('LucHermitte/lh-vim-lib')
  call minpac#add('Xuyuanp/nerdtree-git-plugin')
  call minpac#add('arcticicestudio/nord-vim')
  call minpac#add('axelf4/vim-strip-trailing-whitespace')
  call minpac#add('bling/vim-bufferline')
  call minpac#add('christoomey/vim-tmux-navigator')
  call minpac#add('itchyny/lightline.vim')
  call minpac#add('junegunn/fzf', { 'do': { -> fzf#install() } })
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('junegunn/vim-peekaboo')
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  call minpac#add('kana/vim-textobj-entire')
  call minpac#add('kana/vim-textobj-user')
  call minpac#add('liuchengxu/vista.vim')
  call minpac#add('ludovicchabant/vim-gutentags')
  call minpac#add('mbbill/undotree')
  call minpac#add('mhinz/vim-signify')
  call minpac#add('mhinz/vim-startify')
  call minpac#add('nelstrom/vim-visual-star-search')
  call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
  call minpac#add('preservim/nerdtree')
  call minpac#add('ryanoasis/vim-devicons')
  call minpac#add('sheerun/vim-polyglot')
  call minpac#add('tiagofumo/vim-nerdtree-syntax-highlight')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-dispatch')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-sensible')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-unimpaired')
  call minpac#add('tpope/vim-vinegar')
  call minpac#add('wincent/terminus')
endfunction

command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
command! PackUpdate call PackInit() |
  \ call minpac#update('', {'do': 'call minpac#status()'})

"""" NERDTree
let NERDTreeShowHidden = 1
noremap <silent> <C-n> :NERDTreeToggle<CR>

"""" coc.nvim
let g:coc_global_extensions = [
  \ 'coc-clangd',
  \ 'coc-cmake',
  \ 'coc-eslint',
  \ 'coc-json',
  \ 'coc-lists',
  \ 'coc-markdownlint',
  \ 'coc-prettier',
  \ 'coc-sh',
  \ 'coc-snippets'
\ ]

" https://github.com/neoclide/coc.nvim#example-vim-configuration
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <Tab>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-@> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <CR>
    \ complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

"""" fzf
nnoremap <silent> <C-p> :<C-u>FZF<CR>

"""" lightline.vim
let g:lightline = {
  \ 'colorscheme': 'nord',
  \ 'active': {
  \   'left': [['mode', 'paste'],
  \            ['gitbranch', 'readonly', 'filename', 'modified', 'cocstatus']]
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status',
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ }

"""" vista.vim
noremap <silent> <Leader>v :<C-u>Vista!!<CR>

"""" undotree
nnoremap <silent> <Leader>u :<C-u>UndotreeToggle<CR>

""" General
nnoremap <silent> <Leader>ev :<C-u>vsplit $MYVIMRC<CR>
nnoremap <silent> <Leader>sv :<C-u>source $MYVIMRC<CR>

""" Autocompletion
set infercase

""" Backups
set backup
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//

""" Buffers, Windows, and Tabs
set hidden
set splitbelow
set splitright

""" Editing
set clipboard^=unnamed,unnamedplus
set virtualedit=block

""" Folding
set foldlevelstart=99

nnoremap <Space> za

function! VimFold(lnum) abort
  let l:line = getline(a:lnum)

  if l:line =~ '^""'
    return '>' . (matchend(l:line, '""*') - 2)
  endif

  return '='
endfunction

function! SetFoldMethod() abort
  if &filetype == 'vim'
    setlocal foldlevel=0
    setlocal foldmethod=expr
    setlocal foldexpr=VimFold(v:lnum)
  else
    setlocal foldmethod=syntax
  endif
endfunction

augroup fold_settings
  autocmd!
  autocmd Filetype * call SetFoldMethod()
augroup END

""" Indentation
set expandtab
set shiftwidth=2
set softtabstop=2

""" Search
set hlsearch
set ignorecase
set smartcase

nnoremap <silent> <Leader><Space> :<C-u>nohlsearch<CR><C-l>

""" Terminal Mode
tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l

augroup kill_terminal_job_on_exit
  autocmd!
  autocmd TerminalOpen * call term_setkill(bufnr(), 'hup')
augroup END

""" Undo
set undodir=$HOME/.vim/undo//
set undofile

augroup disallow_persistent_undo
  autocmd!
  autocmd BufWritePre /tmp/* setlocal noundofile
augroup END

""" User Interface
" Should be set before vim-devicons loads:
" https://github.com/ryanoasis/vim-devicons/issues/215
if !exists('g:syntax_on')
  syntax enable
endif

set colorcolumn=80
set cursorline
set lazyredraw
set noshowmode
set showcmd
set showmatch
set termguicolors

if !exists('g:colors_name') || g:colors_name != 'nord'
  colorscheme nord
endif
