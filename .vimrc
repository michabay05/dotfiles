set mouse=a
set number
set cursorline
set hlsearch
set incsearch
set background=dark
set nobackup
set scrolloff=5

" Handy thing to highlight trailing whitespace
hi TrailingWhitespace ctermbg=red guibg=red
call matchadd("TrailingWhitespace", '\v\s+$')
