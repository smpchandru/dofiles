local actions = require('telescope.actions')
-- if O.plugin.trouble.active then
--     local trouble = require("trouble.providers.telescope")
-- end
-- Global remapping
------------------------------
-- '--color=never',
require('telescope').setup {
    defaults = {
        find_command = {
            'rg', '--no-heading', '--with-filename', '--line-number',
            '--column', '--smart-case'
        },
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
            width = 0.75,
            --prompt_position = "bottom",
		-- preview_width = 0.5,
            preview_cutoff = 0,
            horizontal = {mirror = false},
            vertical = {mirror = true}
        },
        --[[ layout_config = {
            width = 0.75,
            prompt_position = "bottom",
			preview_width = 0.60,
            preview_cutoff = 120,
            horizontal = {mirror = false},
            vertical = {mirror = false}
        }, ]]
        file_sorter = require'telescope.sorters'.get_fzy_sorter,
        file_ignore_patterns = {},
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
        mappings = {
            i = {
                ["<C-c>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                -- ["<c-t>"] = trouble.open_with_trouble,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                -- To disable a keymap, put [map] = false
                -- So, to not map "<C-n>", just put
                -- ["<c-x>"] = false,
                -- ["<esc>"] = actions.close,

                -- Otherwise, just set the mapping to the function that you want it to be.
                -- ["<C-i>"] = actions.select_horizontal,

                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center

                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                -- ["<c-t>"] = trouble.open_with_trouble,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist
                -- ["<C-i>"] = my_cool_custom_action,
            }
        }
    },
    extensions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = {"png", "webp", "jpg", "jpeg"},
			find_cmd = "rg" -- find command (defaults to `fd`)
		}
	},
	pickers = {
		-- Your special builtin config goes in here
		buffers = {
			sort_lastused = true,
			theme = "dropdown",
			previewer = false,
			mappings = {
				i = {
					["<c-d>"] = require("telescope.actions").delete_buffer,
					-- Right hand side can also be the name of the action as a string
					["<c-d>"] = "delete_buffer",
				},
				n = {
					["<c-d>"] = require("telescope.actions").delete_buffer,
				}
			}
		},
		find_files = {
			previewer = false,
			theme = "dropdown"
		},
	},
}
--vim.cmd([[
--highlight TelescopeSelection      guifg=#D79921
--highlight TelescopeSelectionCaret guifg=#CC241D
--highlight TelescopeMultiSelection guifg=#928374
--highlight TelescopeNormal         guibg=#00000
--highlight TelescopeBorder         guifg=#ffdab9
--highlight TelescopePromptBorder   guifg=#ffffff
--highlight TelescopeResultsBorder  guifg=#ffffff
--highlight TelescopePreviewBorder  guifg=#ffffff
--highlight TelescopeMatching       guifg=blue
--highlight TelescopePromptPrefix   guifg=red
--]])
require('telescope').load_extension('media_files')
require('telescope').load_extension('projects')
