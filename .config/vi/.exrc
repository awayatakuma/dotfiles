" Minimal vi configuration (works with traditional vi)
" Compatible with your preferences but vi-safe

" Basic settings
set number
set showmode
set ignorecase
set autoindent
set tabstop=2
set shiftwidth=2

" Search settings
set incsearch

" Show cursor position
set ruler

" Map jj to escape in insert mode (if supported)
map! jj 

" Basic leader key mappings (space as leader)
" Note: vi has limited mapping capabilities
map   ^
map  $

" Some vi implementations support these
set showmatch
set wrapscan

" If your vi supports it, enable line wrapping at 100 chars
set wrapmargin=100