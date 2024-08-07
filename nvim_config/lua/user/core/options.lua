local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 4 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 4 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.hlsearch = false
opt.incsearch = true

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
-- vim.cmd([[ set iskeyword-=_ ]])

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
-- opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- opt.iskeyword:append("-") -- consider string-string as whole word
vim.cmd([[ 
augroup masm_ft
au!
autocmd BufNewFile,BufRead *.masm   set filetype=masm
augroup END
]])

-- set fasm syntax highlighting by default when opening a fasm file
vim.cmd([[
autocmd BufNew,BufRead *.fasm set ft=fasm
autocmd BufNew,BufRead *.inc set ft=fasm
]])

-- set nasm syntax highlighting by default when opening a nasm file
vim.cmd([[
autocmd BufNew,BufRead *.nasm set ft=nasm
]])

-- Netrw config
vim.g.netrw_banner = 0        -- gets rid of the annoying banner of Netrw
vim.g.netrw_liststyle = 3     -- tree style view in Netrw

-- Needed for the 'obsidian.nvim' plugin
vim.opt.conceallevel = 1

vim.cmd([[
let g:pencil#conceallevel = 1     " 0=disable, 1=one char, 2=hide char, 3=hide all (def)
" let g:pencil#concealcursor = 'c'  " n=normal, v=visual, i=insert, c=command (def)
]])
