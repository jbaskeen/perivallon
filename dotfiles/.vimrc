" General Settings
set autoread
set backspace=2
set clipboard=unnamed
set foldnestmax=2
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:→\ ,trail:･
set noshowmode
set number
" set relativenumber
set ruler
set showcmd
set smartcase
set splitbelow
set splitright
set ttimeoutlen=50
set colorcolumn=100
set nojoinspaces
set encoding=utf8
" set termguicolors

let mapleader = " "
" Plugins
call plug#begin('~/.config/nvim/plugged')

let g:NERDTreeShowBookmarks = 1
let g:NERDTreeIgnore = ['node_modules$[[dir]]']
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeMapOpenVSplit = 'v'
nmap <silent> <leader>e :edit .<CR>

Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim'
Plug 'junegunn/fzf', { 'dir': '~/.config/nvim/fzf', 'do': 'yes n \| ./install' }
Plug 'junegunn/fzf.vim'

" FileType specific
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh', 'for': 'go' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': 'javascript' }
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript' }
Plug 'starcraftman/vim-eclim', { 'for': 'java' }

" Visual Enhancements
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-vinegar'
Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree' | Plug 'svenwin/vim-splitted-nerdtree'
Plug 'ryanoasis/vim-devicons'

" Shortcuts
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'vim-scripts/camelcasemotion'
Plug 'justinmk/vim-sneak'

" Syntax Plugins
Plug 'justinmk/molokai'
Plug 'Valloric/MatchTagAlways', { 'for':  'html' }
Plug 'junegunn/rainbow_parentheses.vim'
" Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'groenewege/vim-less', { 'for': 'less' }

Plug 'jiangmiao/auto-pairs'

call plug#end()

" colorscheme molokai
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE
hi NonText ctermbg=NONE

let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_refresh_always = 1
let g:tern_request_timeout = 50000
au InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
au FocusGained * if &autoread | silent checktime | endif

" Filetype
au FileType css setlocal ts=4 sw=4 sts=4 et
au FileType scss setlocal ts=4 sw=4 sts=4 et
au FileType html setlocal ts=4 sw=4 sts=4 noet omnifunc=
au FileType javascript setlocal ts=2 sw=2 sts=2 et
au FileType sh setlocal ts=2 sw=2 sts=2 et
au Filetype json setlocal ts=2 sw=2 sts=2 et
au FileType markdown setlocal spell ts=4 sw=4 sts=4 et
au FileType yaml setlocal ts=2 sw=2 sts=2 et
au FileType java setlocal ts=4 sw=4 sts=4 noet
au FileType go setlocal ts=4 sw=4 sts=4 noet
au FileType gitcommit setlocal spell textwidth=72

au BufNewFile,BufRead *.ejs, *.hbs set filetype=html
au BufNewFile,BufRead *.xml set filetype=xhtml
au BufNewFile,BufRead *.jsx set filetype=javascript
au BufNewFile,BufRead *.yml set filetype=yaml

" Neomake
let g:neomake_open_list = 2
let g:neomake_javascript_enabled_makers = ['eslint_d']
let g:neomake_html_enabled_makers = []
let g:neomake_verbose = 0
autocmd! BufReadPost,BufWritePost * Neomake

" Netrw
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_list_hide='.git/,node_modules/'
nmap <silent> <leader>e :Explore<CR>

" Fzf.vim
let g:fzf_layout = { 'down': '~12%' }
nnoremap <silent> <c-p> :Files<cr>

let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{','}']]
augroup rainbow_parens
  autocmd!
  autocmd FileType json,java,javascript,python RainbowParentheses
augroup END

highlight ColorColumn guibg=#282828
highlight Folded      gui=bold guifg=#458588 guibg=#353535

" Task Warrior
let g:task_rc_override = 'rc.defaultwidth=999'
let g:task_default_prompt = ['project', 'description', 'tag', 'depends']

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Better navigation for wrapped lines
nnoremap j gj
nnoremap k gk

" Pane Navigation
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

" Neovim :term
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <Leader>q <C-\><C-n>
if has('nvim')
  " dark0 + gray
  let g:terminal_color_0 = "#171717"
  let g:terminal_color_8 = "#686868"

  " neurtral_red + bright_red
  let g:terminal_color_1 = "#fe4386"
  let g:terminal_color_9 = "#fa80ac"

  " neutral_green + bright_green
  let g:terminal_color_2 = "#a6e32d"
  let g:terminal_color_10 = "#bde371"

  " neutral_yellow + bright_yellow
  let g:terminal_color_3 = "#e6da73"
  let g:terminal_color_11 = "#fff27f"

  " neutral_blue + bright_blue
  let g:terminal_color_4 = "#0094d9"
  let g:terminal_color_12 = "#00beff"

  " neutral_purple + bright_purple
  let g:terminal_color_5 = "#9b37ff"
  let g:terminal_color_13 = "#be9eff"

  " neutral_aqua + faded_aqua
  let g:terminal_color_6 = "#50b7d9"
  let g:terminal_color_14 = "#5ed7ff"

  " light4 + light1
  let g:terminal_color_7 = "#c7c7c7"
  let g:terminal_color_15 = "#ffffff"
endif


" Terminal/Node REPL splits
command! Term sp term://zsh
command! TermV vsp term://zsh
command! Node sp term://node
command! NodeV vsp term://node
noremap <silent> <leader>T :Term<CR>I
noremap <silent> <leader>t :TermV<CR>I
noremap <silent> <leader>N :Node<CR>I
noremap <silent> <leader>n :NodeV<CR>I


" Clear Highlighting
noremap <silent> <c-c> :noh<cr><c-c>

" Close location window (error window)
noremap <silent> <Leader>c :lcl<CR>

" Close current buffer
noremap <silent> <Leader>q :bd<CR>

" Unimpared-style shortcuts
nmap <silent> [t :tabp<CR>
nmap <silent> ]t :tabn<CR>
nmap <silent> [b :bprevious<CR>
nmap <silent> ]b :bnext<CR>
nmap <silent> [e :lprevious<CR>
nmap <silent> ]e :lnext<CR>

" Filetype specific commands
au FileType javascript noremap <silent> <Leader>re :TernRename<CR>
au FileType go nmap K <Plug>(go-doc-vertical)
au FileType go nmap <leader>ru <Plug>(go-run)
au FileType go nmap <leader>re <Plug>(go-rename)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

augroup reload_vimrc
    autocmd!
    autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END
nmap <silent> <leader>rr :source $MYVIMRC<CR>

" Show different tabstop and EOL characters
noremap <silent> <Leader>I :set list!<CR>
match ColorColumn '\s\+$'

" Save folds on write, restore on read
au BufWritePost * mkview
au BufWinEnter * silent! loadview

" Lightline configuration
let g:lightline = {
      \ 'colorscheme': 'Tomorrow_Night_Bright',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'filename' ] ],
      \   'right': [ [ 'lineinfo' ], ['percent'], [ 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightLineFilename',
      \   'mode': 'LightLineMode',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? 'Tagbar' :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

if exists("g:loaded_webdevicons") && exists("g:NERDTree")
    call webdevicons#refresh()
endif

inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
