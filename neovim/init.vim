""" Plugins
packadd! termdebug

function! PackInit() abort
  packadd minpac
  call minpac#init()
  call minpac#add('Xuyuanp/nerdtree-git-plugin')
  call minpac#add('arcticicestudio/nord-vim')
  call minpac#add('axelf4/vim-strip-trailing-whitespace')
  call minpac#add('christoomey/vim-tmux-navigator')
  call minpac#add('itchyny/lightline.vim')
  call minpac#add('jiangmiao/auto-pairs')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('junegunn/vim-peekaboo')
  call minpac#add('junegunn/vim-slash')
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  call minpac#add('kana/vim-textobj-entire')
  call minpac#add('kana/vim-textobj-user')
  call minpac#add('liuchengxu/vista.vim')
  call minpac#add('mbbill/undotree')
  call minpac#add('mhinz/vim-signify')
  call minpac#add('neovim/nvim-lspconfig')
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
  call minpac#add('vim-scripts/a.vim')
endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()
command! PackStatus source $MYVIMRC | call PackInit() | call minpac#status()

"""" NERDTree
let NERDTreeShowHidden = 1
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapPreviewSplit = 'gs'
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeMapPreviewVSplit = 'gv'

nnoremap <silent> <C-n> :<C-u>NERDTreeToggle<CR>
nnoremap <silent> <C-m> :<C-u>NERDTreeFind<CR>

"""" undotree
nnoremap <silent> <Leader>u :<C-u>UndotreeToggle<CR>

"""" vista
nnoremap <silent> <Leader>v :<C-u>Vista!!<CR>

"""" fzf
let &runtimepath .= ',' . trim(system('brew --prefix fzf'))
nnoremap <silent> <C-p> :<C-u>FZF<CR>

"""" lightline
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

""" LSP
lua << EOF
vim.cmd('packadd nvim-lspconfig')
local nvim_lsp = require'nvim_lsp'
nvim_lsp.clangd.setup{}
nvim_lsp.cmake.setup{}
EOF

nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

""" Editing
set virtualedit=block,onemore

nnoremap <silent> <Leader>ev :<C-u>vsplit $MYVIMRC<CR>
nnoremap <silent> <Leader>sv :<C-u>source $MYVIMRC<CR>

""" UI
set breakindent
set colorcolumn=120
set lazyredraw
set linebreak
set noshowmode
set termguicolors

if !exists('g:colors_name') || g:colors_name != 'nord'
  colorscheme nord
endif

augroup cursorline
  autocmd!
  autocmd InsertLeave,WinEnter,VimEnter * set cursorline
  autocmd InsertEnter,WinLeave * set nocursorline
augroup END

""" Searching
set ignorecase
set smartcase

""" Command Line Mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

""" Terminal Mode
tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l

""" Folding
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

""" Buffers & Windows
set hidden
set splitbelow
set splitright

""" Backup, Swap, Undo
set backup
set undofile

function! EnsureTmpDir(dirname) abort
  const l:path = $HOME . '/.config/nvim/' . a:dirname . '//'
  if !isdirectory(l:path)
    call mkdir(l:path)
  endif
  return l:path
endfunction

let &backupdir = EnsureTmpDir('backup')
let &directory = EnsureTmpDir('swap')
let &undodir   = EnsureTmpDir('undo')
let &shadafile = EnsureTmpDir('shada') . 'shada'

augroup disallow_persistent_undo
  autocmd!
  autocmd BufWritePre /tmp/* setlocal noundofile
augroup END
