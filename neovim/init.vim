""" Header
let mapleader = ','
noremap \ ,

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
  call minpac#add('jiangmiao/auto-pairs')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('junegunn/vim-peekaboo')
  call minpac#add('junegunn/vim-slash')
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  call minpac#add('kana/vim-operator-user')
  call minpac#add('kana/vim-textobj-entire')
  call minpac#add('kana/vim-textobj-user')
  call minpac#add('liuchengxu/vista.vim')
  call minpac#add('mbbill/undotree')
  call minpac#add('mhinz/vim-signify')
  call minpac#add('neovim/nvim-lspconfig')
  call minpac#add('nvim-lua/completion-nvim')
  call minpac#add('nvim-lua/diagnostic-nvim')
  call minpac#add('nvim-lua/lsp-status.nvim')
  call minpac#add('rhysd/vim-clang-format')
  call minpac#add('sheerun/vim-polyglot')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-dispatch')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-sensible')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-unimpaired')
  call minpac#add('tpope/vim-vinegar')
  call minpac#add('voldikss/vim-floaterm')
endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()
command! PackStatus source $MYVIMRC | call PackInit() | call minpac#status()

"""" clangd
autocmd vimrc FileType c,cpp nnoremap <buffer> <Leader>ae <Cmd>ClangdSwitchSourceHeader<CR>
autocmd vimrc FileType c,cpp nnoremap <buffer> <Leader>as <Cmd>split +ClangdSwitchSourceHeader<CR>
autocmd vimrc FileType c,cpp nnoremap <buffer> <Leader>av <Cmd>vsplit +ClangdSwitchSourceHeader<CR>

"""" undotree
nnoremap <Leader>u <Cmd>UndotreeToggle<CR>

"""" vista
nnoremap <Leader>v <Cmd>Vista!!<CR>

"""" floaterm
let g:floaterm_keymap_toggle = '<Leader>t'

"""" fzf
let &runtimepath .= ',' . trim(system('brew --prefix fzf'))

nnoremap <Leader>f <Cmd>Files<CR>
nnoremap <Leader>b <Cmd>Buffers<CR>
nnoremap <Leader>rg :<C-u>Rg<Space>

"""" lightline
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [['mode'],
      \            ['git_branch', 'readonly', 'filename', 'modified', 'lsp_status']],
      \ },
      \ 'component_function': {
      \   'git_branch': 'FugitiveHead',
      \   'lsp_status': 'LspStatus',
      \ },
      \ }

""" Autocompletion
inoremap <expr> <Tab>   pumvisible() ? '<C-n>' : '<Tab>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'

set completeopt=menuone,noinsert,noselect
set shortmess+=c

""" Diagnostics
nnoremap [g <Cmd>PrevDiagnostic<CR>
nnoremap ]g <Cmd>NextDiagnostic<CR>

set updatetime=300

autocmd vimrc CursorHold * lua vim.lsp.util.show_line_diagnostics()
autocmd vimrc ColorScheme nord highlight LspDiagnosticsUnderline cterm=underline gui=underline

""" Formatting
nnoremap <Leader>x <Cmd>lua vim.lsp.buf.formatting()<CR>
xnoremap <Leader>x <Cmd>lua vim.lsp.buf.formatting()<CR>

autocmd vimrc FileType javascript,proto nmap <buffer> <Leader>x <Plug>(operator-clang-format)ae
autocmd vimrc FileType javascript,proto xmap <buffer> <Leader>x <Plug>(operator-clang-format)ae

""" LSP
nnoremap <Leader>d <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <C-]>     <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gr        <Cmd>lua vim.lsp.buf.references()<CR>
nnoremap K         <Cmd>lua vim.lsp.buf.hover()<CR>

function! LspStatus() abort
  return luaeval('#vim.lsp.buf_get_clients() > 0') ? luaeval("require('lsp-status').status()") : ''
endfunction

lua << EOF
vim.cmd('packadd completion-nvim')
vim.cmd('packadd diagnostic-nvim')
vim.cmd('packadd lsp-status.nvim')
vim.cmd('packadd nvim-lspconfig')

local completion = require('completion')
local diagnostic = require('diagnostic')
local lsp_status = require('lsp-status')
local nvim_lsp   = require('nvim_lsp')

lsp_status.register_progress()
lsp_status.config({
  status_symbol = '',
  indicator_errors = '×',
  indicator_warnings = '!',
  indicator_info = 'i',
  indicator_hint = '›',
  indicator_ok = '',
})

local on_attach = function(client, bufnr)
  completion.on_attach(client, bufnr)
  diagnostic.on_attach(client, bufnr)
  lsp_status.on_attach(client, bufnr)
end

nvim_lsp.clangd.setup {
  cmd = {
    'clangd',
    '--background-index=false',
  },
  callbacks = lsp_status.extensions.clangd.setup(),
    init_options = {
    clangdFileStatus = true,
  },
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

nvim_lsp.cmake.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

nvim_lsp.jsonls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

nvim_lsp.vimls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}
EOF

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

if !exists('g:colors_name') || g:colors_name != 'nord'
  let g:nord_underline = 1
  colorscheme nord
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
nnoremap <Space> za

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

autocmd vimrc BufWritePre /tmp/* setlocal noundofile
