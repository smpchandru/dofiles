local M = {}
M.config = function()
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"go","yaml","json","python"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    -- TODO seems to be broken
    ignore_install = {"haskell"},
    highlight = {
        enable = true -- false will disable the whole extension
    },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "<s-up>",
			scope_incremental = "<a-up>",
			node_decremental = "<a-down>",
		},
	},
	indent = {
			enable = true,
			disable = {"go","python"}
	},
	autopairs = {enable = true},
    rainbow = {enable = true},
	refactor = {
		highlight_definitions = {enable = true},
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr",
			},
		},
		highlight_current_scope = {
			disable = {},
			enable = false,
			module_path = "nvim-treesitter-refactor.highlight_current_scope"
		}
	}
}
-- vim.opt.foldmethod="expr"
-- vim.opt.foldexpr="nvim_treesitter#foldexpr()"
	
end
return M
