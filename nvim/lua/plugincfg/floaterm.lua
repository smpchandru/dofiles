-- floatting popup transparent
local M = {}
M.config = function()
-- vim.cmd('set pumblend=10')
-- vim.cmd('set winblend=10')
vim.g.floaterm_borderchars={'─', '│', '─', '│', '╭', '╮', '╯', '╰'}
vim.g.floaterm_title='Terminal'
vim.g.floaterm_width=0.9
--vim.g.floaterm_height=0.4
--vim.g.floaterm_position='bottom'
end
return M
