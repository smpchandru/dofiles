local M = {}
M.config = function()
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"go","yaml","json","python"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    -- TODO seems to be broken
    ignore_install = {"haskell"},
    highlight = {
        enable = true -- false will disable the whole extension
    },
	playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
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
