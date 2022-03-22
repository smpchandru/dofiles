-- Normal mode key bindgings
local map = vim.api.nvim_set_keymap
map("n", "<Space>", "<NOP>", { noremap = true, silent = true })
-- no hl
if O.plugin.nvimtree.enable == true then
	map("n", "<Leader>e", ":lua require'ch-nvtree'.toggle_tree()<CR>", { silent = true })
end
-- map('n' , '<Leader>t'  , ':TagbarToggle<CR>'                           , {noremap = true   , silent = true})
map("n", "<Leader>t", ":SymbolsOutline<CR>", { noremap = true, silent = true })
map("n", "<Leader>m", ':lua require("utils").ToggleMouse()<CR>', { noremap = true, silent = true })
-- map('n' , '<Leader>z'  , ':ZoomToggle<CR>'                      , {noremap = true   , silent = true})
if O.plugin.symbol_outline.enable == true then
	map("n", "<leader>o", ":SymbolsOutline<CR>", { silent = true })
end
-- resize windows
map("n", "<M-j>", ":resize -2<CR>", { noremap = true, silent = true })
map("n", "<M-k>", ":resize +2<CR>", { noremap = true, silent = true })
map("n", "<M-h>", ":vertical resize -2<CR>", { noremap = true, silent = true })
map("n", "<M-l>", ":vertical resize +2<CR>", { noremap = true, silent = true })
-- windows navigation
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })
map("n", "<leader><leader>s", "<cmd>luafile ~/.config/nvim/lua/snippets.lua<CR>", { silent = false })

if O.plugin.floaterm.enable == true then
	vim.cmd([[ 
	tnoremap <F4> <C-\><C-n>:FloatermToggle<CR>
    nnoremap <F4> :FloatermToggle<CR>
	inoremap <F4> <ESC>:FloattermToggle<CR>

	]])
end
map("n", "<C-y>", ":e $MYVIMRC<CR>", { noremap = true, silent = true })
-- Needs to figureout why these
map("n", "<C-f>", "<C-f>M", { noremap = true, silent = true })
map("n", "<C-b>", "<C-b>M", { noremap = true, silent = true })
-- navigate buffers
map("n", "<TAB>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
map("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
map("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
-- map('n' , '<C-p>'     , ':lua require("telescope").extensions.fzf_writer.files()<CR>'       , {noremap = true , silent = true})
map("n", "<leader>b", ":Telescope buffers<CR>", { noremap = true, silent = true })
map(
	"n",
	"<C-g>",
	':lua require("telescope").extensions.fzf_writer.staged_grep()<CR>',
	{ noremap = true, silent = true }
)
map(
	"n",
	"<C-s>",
	':lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>',
	{ noremap = true, silent = true }
)
-- Insert mode mapings
vim.cmd([[
        inoremap <A-h> <C-\><C-N><C-w>h
        inoremap <A-j> <C-\><C-N><C-w>j
        inoremap <A-k> <C-\><C-N><C-w>k
        inoremap <A-l> <C-\><C-N><C-w>l
        imap <C-v> <esc>:set paste<CR>i<C-r>*<esc>:set nopaste<CR>i
]])

-- visual mode mapings
-- Use tab to move visully selected text
map("v", "<S-TAB>", "<gv", { noremap = true, silent = true })
map("v", "<TAB>", ">gv", { noremap = true, silent = true })
-- Use C-c to copy visully selected text
map("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- if O.plugin.kommentary.enable == true
-- then
--[[ map('v' , '<C-/>' , 'gb' , {silent = true})
	map('n' , '<C-/>' , 'gcc' , {silent = true}) ]]
map("v", "<C-_>", "gb", { silent = true })
map("n", "<C-_>", "gcc", { silent = true })
--[[ end ]]

--"visual
--" Search patterns in visully selected texts
--" copied from http://vim.wikia.com/wiki/Search_for_visually_selected_text
vim.cmd([[
vnoremap <silent> / :<C-U>:lua require('utils').RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
vnoremap <silent> ? :<C-U>:lua require('utils').RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>
]])

-- hop.nvim
if O.plugin.hop.enable == true then
	map("n", "s", ":HopChar2<cr>", { silent = true })
	map("n", "S", ":HopWord<cr>", { silent = true })
	map("n", "-", "<Plug>(choosewin)", { silent = true })
end

-- navigte back with mouse right clicks
map("n", "<C-RightMouse>", "<C-t>", { silent = true })
map("n", "<C-LeftMouse>",":lua vim.lsp.buf.definition()<CR>", { silent = true })
-- projects explorer
map("n", "<leader>w", ":Telescope projects<CR>", { silent = true })
