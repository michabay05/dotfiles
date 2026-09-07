vim.cmd([[
syntax on
filetype plugin on
]])

local opt = vim.opt -- for conciseness
opt.exrc = true

opt.cmdheight = 0
opt.updatetime = 200
opt.colorcolumn = "100"
opt.showmode = false
opt.relativenumber = true
opt.number = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.wrap = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "split"
opt.breakindent = true
opt.undofile = true
opt.cursorline = true
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
