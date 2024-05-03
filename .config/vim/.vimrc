" Delete letters with backspace when in insertaion mode.
set backspace=indent,eol,start

"----------------------------------------
" Search
"----------------------------------------
" Don't distinguish small letters and large letters.
set ignorecase
" Don't distinguish small letters and large letter when using small ones.
set smartcase
" Incremental search.
set incsearch
" Highlight display search results.
set hlsearch

"----------------------------------------
" Display
"----------------------------------------
"
" Turn syntax highlighting on.
syntax on
" Add row numbers.
set number
" Highlight cursor line underneath the cursor horizontally.
set cursorline
" Highlight cursor line underneath the cursor vertically.
"set cursorcolumn
" Set shift width to 4 spaces.
set shiftwidth=4
" Set tab width to 4 columns.
set tabstop=4
" Use space characters instead of tabs.
set expandtab

"----------------------------------------
" Others
"----------------------------------------
"
" Do not save backup files.
set nobackup
" Set the commands to save in history default number is 20.
set history=1000
