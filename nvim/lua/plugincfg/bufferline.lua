
vim.opt.termguicolors = true
require("bufferline").setup({
	options = {
		numbers = "none",
		close_command = "bdelete! %d",
		right_mouse_command = "bdelete! %d",
		left_mouse_command = "buffer %d",
		middle_mouse_command = nil,
		indicator_icon = "▎",
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		name_formatter = function(buf)
			if buf.name:match("%.md") then
				return vim.fn.fnamemodify(buf.name, ":t:r")
			end
		end,
		max_name_length = 18,
		max_prefix_length = 15,
		tab_size = 18,
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			return "(" .. count .. ")"
		end,
		offsets = { { filetype = "NvimTree", text = "File Explorer" } },
		show_buffer_icons = true,
		persist_buffer_sort = true,
		separator_style = "thin",
	},
	highlights = {
		--[[ fill = {
			guifg = {attribute = "fg", highlight = "Normal"},
			guibg = {attribute = "bg", highlight = "StatusLineNC"},
		},
		background = {
			guifg = {attribute = "fg", highlight = "Normal"},
			guibg = {attribute = "bg", highlight = "StatusLine"}
		},
		buffer_visible = {
			gui = "",
			guifg = {attribute = "fg", highlight="Normal"},
			guibg = {attribute = "bg", highlight = "Normal"}
		},
	buffer_selected = {
			gui = "",
			guifg = {attribute = "fg", highlight="Normal"},
			guibg = {attribute = "bg", highlight = "Normal"}
		},
		separator = {
			guifg = {attribute = "bg", highlight = "Normal"},
			guibg = {attribute = "bg", highlight = "StatusLine"},
		},
		separator_selected = {
			guifg = {attribute = "fg", highlight="Special"},
			guibg = {attribute = "bg", highlight = "Normal"}
		},
		separator_visible = {
			guifg = {attribute = "fg", highlight = "Normal"},
			guibg = {attribute = "bg", highlight = "StatusLineNC"},
		},
		close_button = {
			guifg = {attribute = "fg", highlight = "Normal"},
			guibg = {attribute = "bg", highlight = "StatusLine"}
		},
		close_button_selected = {
			guifg = {attribute = "fg", highlight="normal"},
			guibg = {attribute = "bg", highlight = "normal"}
		},
		close_button_visible = {
			guifg = {attribute = "fg", highlight="normal"},
			guibg = {attribute = "bg", highlight = "normal"}
		},
]]
	},
})
