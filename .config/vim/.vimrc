" ==============================================
" Modern vim configuration for productivity
" Based on your VSCode vim preferences
" ==============================================

" Basic settings
set nocompatible              " Disable vi compatibility
set encoding=utf-8            " UTF-8 encoding
set number                    " Show line numbers
set relativenumber            " Show relative line numbers
set ruler                     " Show cursor position
set showcmd                   " Show command in status line
set showmode                  " Show current mode
set laststatus=2              " Always show status line

" Search settings (matching your VSCode preferences)
set incsearch                 " Incremental search
set hlsearch                  " Highlight search results
set ignorecase                " Case insensitive search
set smartcase                 " Smart case sensitivity

" Indentation and formatting
set autoindent                " Auto indent new lines
set smartindent               " Smart indentation
set tabstop=2                 " Tab width
set shiftwidth=2              " Indent width
set expandtab                 " Use spaces instead of tabs
set wrap                      " Enable line wrapping
set textwidth=100             " Wrap at 100 characters (matching VSCode)
set linebreak                 " Break lines at word boundaries

" Visual settings
set cursorline                " Highlight current line
set scrolloff=8               " Keep 8 lines above/below cursor
set sidescrolloff=8           " Keep 8 characters left/right of cursor
set backspace=indent,eol,start " Better backspace behavior
set whichwrap+=<,>,h,l        " Cursor wrap at line edges

" Show whitespace (matching your VSCode preference)
set list
set listchars=tab:→\ ,trail:•,extends:⟩,precedes:⟨,nbsp:␣

" File handling
set autoread                  " Auto reload changed files
set hidden                    " Allow hidden buffers
set backup                    " Create backup files
set backupdir=$XDG_STATE_HOME/vim/backup// " Backup directory
set directory=$XDG_STATE_HOME/vim/swap//   " Swap file directory
set undofile                  " Persistent undo
set undodir=$XDG_STATE_HOME/vim/undo//     " Undo directory

" Create directories if they don't exist
if !isdirectory($XDG_STATE_HOME."/vim/backup")
    call mkdir($XDG_STATE_HOME."/vim/backup", "p", 0700)
endif
if !isdirectory($XDG_STATE_HOME."/vim/swap")
    call mkdir($XDG_STATE_HOME."/vim/swap", "p", 0700)
endif
if !isdirectory($XDG_STATE_HOME."/vim/undo")
    call mkdir($XDG_STATE_HOME."/vim/undo", "p", 0700)
endif

" Performance settings
set lazyredraw                " Don't redraw during macros
set ttyfast                   " Fast terminal connection
set timeoutlen=500            " Timeout for key sequences
set updatetime=300            " Faster completion

" ==============================================
" Key mappings (based on your VSCode vim config)
" ==============================================

" Set leader key to space (matching your preference)
let mapleader = " "

" Insert mode mappings
" jj to escape (matching your VSCode config)
inoremap jj <Esc>

" Normal mode mappings
" Clear search highlighting with Ctrl-n (matching VSCode)
nnoremap <C-n> :nohlsearch<CR>

" Line navigation shortcuts (matching your VSCode config)
nnoremap <leader>h ^
nnoremap <leader>l $

" Leader d for dd (matching your VSCode config)
nnoremap <leader>d dd

" Better line joining
nnoremap J mzJ`z

" Center screen on search
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>

" Better indenting (keep selection)
vnoremap < <gv
vnoremap > >gv

" Move lines up/down (Alt+j/k)
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Buffer navigation
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>
nnoremap <leader>bd :bdelete<CR>

" Window navigation (if using splits)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Window resizing
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Quick file operations
nnoremap <leader>fn :enew<CR>
nnoremap <leader>fs :w<CR>

" Quick substitute (replace word under cursor)
nnoremap <leader>sr :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Toggle settings
nnoremap <leader>tw :set wrap!<CR>
nnoremap <leader>tl :set number!<CR>
nnoremap <leader>tr :set relativenumber!<CR>

" ==============================================
" Status line configuration
" ==============================================
set statusline=
set statusline+=%#PmenuSel#
set statusline+=\ %f\                    " File name
set statusline+=%#LineNr#
set statusline+=\ %m%r%h%w\               " Modified, readonly, help, preview flags
set statusline+=%=                        " Right align
set statusline+=%#CursorColumn#
set statusline+=\ %y\                     " File type
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}\  " Encoding
set statusline+=\ %{&fileformat}\        " File format
set statusline+=\ %p%%\                  " Percentage through file
set statusline+=\ %l:%c\                 " Line:Column
set statusline+=\ 

" ==============================================
" Color scheme and syntax
" ==============================================
syntax enable                 " Enable syntax highlighting
set background=dark           " Dark background

" Try to set a good color scheme
if has('termguicolors')
    set termguicolors
endif

" Fallback color scheme that works in most terminals
colorscheme default

" Custom highlight groups for better visibility
highlight CursorLine cterm=NONE ctermbg=235 guibg=#2c2c2c
highlight LineNr ctermfg=245 guifg=#8a8a8a
highlight CursorLineNr ctermfg=220 guifg=#ffd700 cterm=bold gui=bold
highlight Search ctermbg=226 ctermfg=16 guibg=#ffff00 guifg=#000000
highlight Visual ctermbg=240 guibg=#585858

" ==============================================
" Auto commands
" ==============================================
if has('autocmd')
    " Remove trailing whitespace on save
    autocmd BufWritePre * :%s/\s\+$//e
    
    " Return to last edit position when opening files
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
    
    " Auto reload vimrc when edited
    autocmd BufWritePost .vimrc source %
endif

" ==============================================
" Minimal plugin-like features for vanilla vim
" ==============================================

" Simple file fuzzy finder (basic implementation)
command! -nargs=1 Find :args **/*<args>*
nnoremap <leader>ff :Find 

" Simple grep functionality
command! -nargs=+ Grep :grep -r <args> .
nnoremap <leader>sg :Grep 

" Quick note taking (similar to your note function)
command! Note :e ~/notes/$(date +\%Y-\%m-\%d).txt
nnoremap <leader>nn :Note<CR>

" ==============================================
" Tips for vanilla vim usage
" ==============================================
" Use :help <topic> for help on any vim feature
" Use :e filename to open files
" Use :ls to list buffers
" Use :b<number> or :b<name> to switch buffers
" Use Ctrl-o and Ctrl-i to navigate jump history
" Use . to repeat last command
" Use @: to repeat last ex command