" General settings
nnoremap <SPACE> <Nop>
let mapleader=" "

syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler                               " Show the cursor position all the time
set cmdheight=1                         " More space for displaying messages
" set iskeyword+=-                      " treat dash separated words as a word text object
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=4                           " Insert 2 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=0                        " Always display the status line
set relativenumber                      " Line numbers
set number
set cursorline                          " Enable highlighting of the current line
set hlsearch
set incsearch
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set scrolloff=8
set signcolumn=yes
" set clipboard=unnamedplus               " Use system clipboard instead of a separate vim clipboard

" ======================= REMAPS
" <ESC> remappings
inoremap jk <Esc>
inoremap kj <Esc>
" Buffer navigation
nnoremap <S-l> :bn<CR>
nnoremap <S-h> :bp<CR>
nnoremap <S-q> :bd<CR>
nnoremap <leader>ff :e<Space>
" No highlight
nnoremap <leader>h :nohl<CR>
" Keep selection after indenting and outdenting
vnoremap < <gv
vnoremap > >gv
" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Window resizing
nnoremap <C-Up> :resize -2<CR>
nnoremap <C-Down> :resize +2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>
