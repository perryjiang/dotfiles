""" Header
noremap <Space> <Nop>
let mapleader = "\<Space>"

augroup vimrc
  autocmd!
augroup END

""" Plugins
packadd! termdebug

function! PackInit() abort
  packadd minpac
  call minpac#init()
  call minpac#add('arcticicestudio/nord-vim')
  call minpac#add('axelf4/vim-strip-trailing-whitespace')
  call minpac#add('christoomey/vim-tmux-navigator')
  call minpac#add('itchyny/lightline.vim')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('junegunn/vim-peekaboo')
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  call minpac#add('kana/vim-textobj-entire')
  call minpac#add('kana/vim-textobj-user')
  call minpac#add('liuchengxu/vista.vim')
  call minpac#add('mbbill/undotree')
  call minpac#add('mhinz/vim-signify')
  call minpac#add('morhetz/gruvbox')
  call minpac#add('neovim/nvim-lspconfig')
  call minpac#add('nvim-lua/completion-nvim')
  call minpac#add('nvim-treesitter/nvim-treesitter')
  call minpac#add('romainl/vim-cool')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-dispatch')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-sensible')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-unimpaired')
  call minpac#add('tpope/vim-vinegar')
endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()
command! PackStatus source $MYVIMRC | call PackInit() | call minpac#status()

"""" undotree
nnoremap <Leader>u <Cmd>UndotreeToggle<CR>

"""" vista
nnoremap <Leader>v <Cmd>Vista!!<CR>

"""" fzf
let &runtimepath .= ',' . trim(system('brew --prefix fzf'))

nnoremap <Leader>f <Cmd>Files<CR>
nnoremap <Leader>b <Cmd>Buffers<CR>
nnoremap <Leader>rg :<C-u>Rg<Space>

"""" lightline
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [['mode'],
      \            ['git_branch', 'readonly', 'filename', 'modified']],
      \ },
      \ 'component_function': {
      \   'git_branch': 'FugitiveHead',
      \ },
      \ }

""" Autocompletion
inoremap <expr> <Tab>   pumvisible() ? '<C-n>' : '<Tab>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'

set completeopt=menuone,noinsert,noselect
set shortmess+=c

""" Diagnostics
set updatetime=300

autocmd vimrc CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" TODO: gruvbox clears these otherwise
autocmd vimrc ColorScheme gruvbox highlight LspDiagnosticsUnderlineError cterm=underline gui=underline guisp=Red
autocmd vimrc ColorScheme gruvbox highlight LspDiagnosticsUnderlineWarning cterm=underline gui=underline guisp=Orange
autocmd vimrc ColorScheme gruvbox highlight LspDiagnosticsUnderlineInformation cterm=underline gui=underline guisp=LightBlue
autocmd vimrc ColorScheme gruvbox highlight LspDiagnosticsUnderlineHint cterm=underline gui=underline guisp=LightGrey
autocmd vimrc ColorScheme gruvbox highlight LspDiagnosticsDefaultError guisp=Red
autocmd vimrc ColorScheme gruvbox highlight LspDiagnosticsDefaultWarning guisp=Orange
autocmd vimrc ColorScheme gruvbox highlight LspDiagnosticsDefaultInformation guisp=LightBlue
autocmd vimrc ColorScheme gruvbox highlight LspDiagnosticsDefaultHint guisp=LightGrey

""" Lua
lua require("lsp").setup()
lua require("treesitter").setup()

""" Editing
nnoremap <Leader>ev <Cmd>vsplit $MYVIMRC<CR>
nnoremap <Leader>sv <Cmd>source $MYVIMRC<CR>

set mouse=a
set virtualedit=block,onemore

""" UI
set breakindent
set colorcolumn=120
set lazyredraw
set linebreak
set noshowmode
set termguicolors

if !exists('g:colors_name') || g:colors_name != 'gruvbox'
  let g:gruvbox_italic = 1
  let g:gruvbox_sign_column = 'dark0'
  colorscheme gruvbox
endif

autocmd vimrc InsertLeave,WinEnter,VimEnter * set cursorline
autocmd vimrc InsertEnter,WinLeave * set nocursorline

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
set foldlevelstart=99

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

autocmd vimrc Filetype * call SetFoldMethod()

""" Indentation
set expandtab
set shiftwidth=2
set softtabstop=2

""" Buffers & Windows
set hidden
set splitbelow
set splitright

""" Swap, Undo, Shada
set undofile

function! EnsureTmpDir(dirname) abort
  const l:path = $HOME . '/.config/nvim/' . a:dirname . '//'
  if !isdirectory(l:path)
    call mkdir(l:path)
  endif
  return l:path
endfunction

let &directory = EnsureTmpDir('swap')
let &undodir   = EnsureTmpDir('undo')
let &shadafile = EnsureTmpDir('shada') . 'shada'

autocmd vimrc BufWritePre /tmp/* setlocal noundofile
