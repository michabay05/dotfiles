local opt = vim.opt -- for conciseness

-- Decrease update time
opt.updatetime = 200

-- Indicator for max col width
vim.opt.colorcolumn = "100"

-- Decrease mapped sequence wait time
opt.timeoutlen = 300

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 4 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 4 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = true -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.hlsearch = true
opt.incsearch = true

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- cursor line
opt.cursorline = true  -- highlight the current cursor line

-- appearance
opt.scrolloff = 3
opt.sidescrolloff = 5
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

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
--     vim.opt.clipboard = "unnamedplus"
-- end)
vim.opt.clipboard = ""


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

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
