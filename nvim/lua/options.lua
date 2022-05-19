local opt = vim.opt
opt.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.wo.wrap = false -- Display long lines as just one line
opt.fileencoding = "utf-8" -- The encoding written to file
opt.cmdheight = 1 -- More space for displaying messages
opt.mouse = "" -- Enable your mouse
opt.splitbelow = true -- Horizontal splits will automatically be below
opt.termguicolors = true -- set term giu colors most terminals support this
opt.splitright = true -- Vertical splits will automatically be to the right
opt.conceallevel = 0 -- So that I can see `` in markdown files
vim.bo.expandtab = false -- Converts tabs to spaces
vim.bo.smartindent = true -- Makes indenting smart
vim.wo.number = true -- set numbered lines
vim.wo.cursorline = true -- Enable highlighting of the current line
opt.showtabline = 2 -- Always show tabs
opt.showmode = false -- We don't need to see things like -- INSERT -- anymore
opt.backup = false -- This is recommended by coc
opt.writebackup = false -- This is recommended by coc
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.updatetime = 300 -- Faster completion
opt.timeoutlen = 1000 -- By default timeoutlen is 1000 ms
opt.clipboard = "unnamedplus" -- Copy paste between vim and everything else
opt.shiftwidth = 4
opt.tabstop = 4
--vim.o.guifont = "JetBrainsMono\\ Nerd\\ Font\\ Mono:h18"
-- opt.guifont = "DejaVu SansMono for PowerlineBook:h20"
-- opt.guifont = "Droid SansMono for Powerline:h20"
-- opt.guifont = "Source Code Pro for Powerline:h16"
opt.guifont = "JetBrains Mono Regular:h18"
opt.smarttab = true
opt.autoindent = true
opt.laststatus = 3
opt.background = "dark"
opt.syntax = "on"
opt.filetype = "on"
opt.number = true
opt.shell = "/bin/bash"
vim.cmd("set nowritebackup")
vim.cmd("set backspace=0")
vim.cmd("set t_ut=")
vim.cmd("set history=1000")
vim.cmd("set diffopt+=iwhite")
vim.cmd("set diffopt+=vertical")
vim.cmd("set noshowmode")
vim.cmd("set iskeyword+=-") -- treat dash separated words as a word text object"
vim.cmd("set shortmess+=c") -- Don't pass messages to |ins-completion-menu|.
vim.cmd("set whichwrap+=<,>,[,],h,l") -- move to next line with theses keys
vim.cmd("set ts=4") -- Insert 2 spaces for a tab
vim.cmd("set nocompatible")
vim.cmd("set relativenumber")
vim.o.pumblend = 5
vim.o.winblend = 5
vim.fn.has("")
if vim.fn.has("termguicolors") then
	opt.termguicolors = true
end
vim.cmd("set formatoptions-=cro")
vim.g.mapleader = O.leader_key
vim.g.maplocalleader = ";"
vim.cmd("highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15")
vim.cmd("highlight ColorColumn ctermbg=1")
vim.cmd("hi Search cterm=NONE ctermfg=grey ctermbg=blue")
vim.cmd("highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15")
vim.g.highlightedyank_highlight_duration = 10000
vim.g.gruvbox_material_background = 'dark'
vim.cmd("colorscheme " .. O.colorscheme)
vim.opt.listchars:append("eol:↴")
if vim.g.neovide then
	vim.cmd("set mouse=a")
end
vim.notify = require("notify")
