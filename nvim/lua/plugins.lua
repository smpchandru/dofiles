local execute = vim.api.nvim_command
vim.opt.termguicolors = true
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute("packadd packer.nvim")
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
	return
end

packer.init({
	-- compile_path = vim.fn.stdpath('data')..'/site/pack/loader/start/packer.nvim/plugin/packer_compiled.vim',
	compile_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "plugin", "packer_compiled.vim"),
	git = { clone_timeout = 300 },
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})
vim.cmd("autocmd BufWritePost plugins.lua PackerCompile")
local pluginCommits = {
	bufferline_nvim="871495d9e2dbe3314a421fd2d5e46f47de7ee537",
	cmp_buffer="d66c4c2d376e5be99db68d2362cd94d250987525",
	cmp_calc="eb7bd1d7382ac26d8eb7346e36405c0ae94333a2",
	cmp_cmdline="f4beb74e8e036f9532bedbcac0b93c7a55a0f8b0",
	cmp_dictionary="54b1dcf78a8545ed08c3da6fb101e85acf5c0715",
	cmp_latex_symbols="29dc9e53d17cd1f26605888f85500c8ba79cebff",
	cmp_nvim_lsp="ebdfc204afb87f15ce3d3d3f5df0b8181443b5ba",
	cmp_nvim_lua="d276254e7198ab7d00f117e88e223b4bd8c02d21",
	cmp_path="466b6b8270f7ba89abd59f402c73f63c7331ff6e",
	cmp_spell="5602f1a0de7831f8dad5b0c6db45328fbd539971",
	cmp_luasnip="d6f837f4e8fe48eeae288e638691b91b97d1737f",
	Comment_nvim="00ed8f612b7bcbaf9df870781ed372ee8c00d6a8",
	diffview_nvim="cf32c3fcdbc2f6855f6bb883302c9f290e9c3d88",
	friendly_snippets="ad07b2844021b20797adda5b483265802559a693",
	galaxyline_nvim="4d4f5fc8e20a10824117e5beea7ec6e445466a8f",
	git_messenger_vim="2e67899355f3f631aad6845925e4c2c13546444d",
	impatient_nvim="7abfc924714d3b7f19f3674cca0231cf6ef2050f",
	indent_blankline_nvim="2e35f7dcdc72f39b37c21e43cdb538d7a41c7e07",
	lsp_signature_nvim="e4f7dad45a1a3bb390977b4e69a528993bcefeac",
	lspkind_nvim="93e98a0c900327ce7e9be1cbf24aebbe7170e375",
	lua_language_server="2107c1c82bccaaf2e2cce937412ef8d5e8741b45",
	LuaSnip="77bbe0a58d04e79126e5903ecf9cf73b8b17c474",
	neogit="f30879799f7c19d0047c6f3d3a86b818eaf0f201",
	nvcode_color_schemes_vim="3a0e624a67ecd2c7f990bc3c25a1044e85782b10",
	nvim_autopairs="7bc61885cca93958a5e6de4873f4b930e87c6f9f",
	nvim_bqf="dcb8a8762d9c93ddf7dc8f06009299c0bf11a14c",
	nvim_cmp="1001683bee3a52a7b7e07ba9d391472961739c7b",
	nvim_colorizer_lua="36c610a9717cc9ec426a07c8e6bf3b3abcb139d6",
	nvim_dap="edb22a824e33f5244c98dbaa91f749f0d6390a94",
	nvim_dap_ui="b4a596f149f87a6e93ae11c46a2121ff7c265170",
	nvim_dap_virtual_text="7f82fec9a1c7fce292c9a9a7310e7d121607db93",
	nvim_lsp_installer="f9299bb59c9e42d59fc57ed034fb84bdd23bbd77",
	nvim_lspconfig="54181ddb2709a4cd594e29bf82343c79196ec0c6",
	nvim_treesitter="8d92fa851e0dc698ab41efe7eec2a27ea0329fae",
	nvim_treesitter_context="b7d7aba81683c1cd76141e090ff335bb55332cba",
	nvim_treesitter_refactor="0dc8069641226904f9757de786a6ab2273eb73ea",
	nvim_treesitter_textobjects="7c6b5fe0926f52854f193d058cd98d2e74c3d483",
	nvim_ts_rainbow="0594067ae677a192a94e383c25a93ac1c3a844d1",
	packer_nvim="84698b84c2a7005446f072e0ba87799b0df84bd3",
	plenary_nvim="14dfb4071022b22e08384ee125a5607464b6d397",
	popup_nvim="b7404d35d5d3548a82149238289fa71f7f6de4ac",
	project_nvim="cef52b8da07648b750d7f1e8fb93f12cb9482988",
	telescope_fzf_native_nvim="8ec164b541327202e5e74f99bcc5fe5845720e18",
	telescope_fzf_writer_nvim="00a1ab1b0aeaa4ad9da238861325ea1ee6d90a44",
	telescope_media_files_nvim="513e4ee385edd72bf0b35a217b7e39f84b6fe93c",
	telescope_nvim="1ebf53d8db12ee500d87907ae520d0115fad5181",
	trouble_nvim="20469be985143d024c460d95326ebeff9971d714",
	vCoolor_vim="bc19d684af09b1e146cf72176eea1ecded84882c",
	vim_floaterm="6244d1739aad6682c6c1d5db18c846c342af6e3e",
	vim_highlightedyank="ff16bf3bac23fb4e17c976f4e1ff7941cd686c8d",
	vim_repeat="24afe922e6a05891756ecf331f39a1f6743d3d5a",
	vim_surround="baf89ad26488f6a7665d51b986f5c7ad2d22b30b",
	vim_visual_multi="e20908963d9b0114e5da1eacbc516e4b09cf5803",
	vscode_nvim="add5229df216fd43020db7aa0d69a4cf0e2d1e34",
	which_key_nvim="28d2bd129575b5e9ebddd88506601290bb2bb221",
	dashboard_nvim="d82ddae95fd4dc4c3b7bbe87f09b1840fbf20ecb",
	gitsigns_nvim="779f4eb59047ef7faa41e71d261d041edfabfb39",
	go_nvim="0fe0a9ee3367f7bd1e9c9ab30d5b7d5e66b83fc6",
	hop_nvim="75f73d3959a0df7ef3642fd5138acdb1ce50fdc8",
	markdown_preview_nvim="e5bfe9b89dc9c2fbd24ed0f0596c85fd0568b143",
	nvim_web_devicons="4415d1aaa56f73b9c05795af84d625c610b05d3b",
	symbols_outline_nvim="1361738c47892c3cee0d0b7a3b3bc7a8b48139c2",
	vim_delve="554b7997caba5d2b38bc4a092e3a468e4abb7f18",

}


return packer.startup({
	function(use)
		-- Packer can manage itself as an optional plugin
		use("lewis6991/impatient.nvim")
		use("wbthomason/packer.nvim")
		-- use 'tpope/vim-sleuth'
		use({
			"tpope/vim-surround",
			commit = pluginCommits.vim_surround,
			disable = not O.plugin.surround.enable,
		})
		use({
			"tpope/vim-repeat",
			commit = pluginCommits.vim_repeat,
			disable = not O.plugin.vim_repeat.enable,
		})
		use({
			"numToStr/Comment.nvim",
			commit = pluginCommits.Comment_nvim,
			config = function()
				require("Comment").setup()
			end,
		})
		use({
			"machakann/vim-highlightedyank",
			commit = pluginCommits.vim_highlightedyank,
			disable = not O.plugin.highlightedyank.enable,
		})
		use({
			"aklt/plantuml-syntax",
			ft = "puml",
			disable = not O.plugin.puml_syntax.enable,
		})
		use({
			"nvim-lua/popup.nvim",
			commit = pluginCommits.popup_nvim,
			lock = true,
			disable = not O.plugin.popup.enable,
		})
		-- project
		use({
			"ahmedkhalf/project.nvim",
			commit = pluginCommits.project_nvim,
			config = function()
				require("project_nvim").setup({
					manual_mode = false,
					detection_methods = { "lsp", "pattern" },
					patterns = { ".git","Makefile" },
					-- ignore_lsp = { "go" },
					show_hidden = false,
					exclude_dirs = { "~/go/*/*/*/*" },
					silent_chdir = true,
					datapath = vim.fn.stdpath("data"),
				})
				vim.g.nvim_tree_update_cwd = 1
				vim.g.nvim_tree_respect_buf_cwd = 1
			end,
		})

		use({
			"L3MON4D3/LuaSnip",
			commit = pluginCommits.LuaSnip,
			config = function()
				require("snippets")
				require("luasnip/loaders/from_vscode").load({
					include = { "go", "python", "bash" },
					paths = { "~/.local/share/nvim/site/pack/packer/opt/friendly-snippets/" },
				})
			end,
			requires = {
				"rafamadriz/friendly-snippets", event = "InsertCharPre" , commit = pluginCommits.friendly_snippets },
		})
		if O.lsp_client == true then
			use({
				"neovim/nvim-lspconfig",
			commit = pluginCommits.nvim_lspconfig,
			})
			use({
				"williamboman/nvim-lsp-installer",
			commit = pluginCommits.nvim_lsp_installer,
			})
			use({
				"hrsh7th/nvim-cmp",
			commit = pluginCommits.nvim_cmp,
				opt = false,
				requires = {
					{"hrsh7th/cmp-nvim-lsp",commit = pluginCommits.cmp_nvim_lsp},
					{"hrsh7th/cmp-buffer" , commit = pluginCommits.cmp_buffer} ,
					{"hrsh7th/cmp-path",commit = pluginCommits.cmp_path},
					{"hrsh7th/cmp-calc",commit = pluginCommits.cmp_calc},
					{"hrsh7th/cmp-nvim-lua",commit = pluginCommits.cmp_nvim_lua},
					{"f3fora/cmp-spell",commit = pluginCommits.cmp_spell},
					{"kdheepak/cmp-latex-symbols",commit = pluginCommits.cmp_latex_symbols},
					{"windwp/nvim-autopairs",commit = pluginCommits.nvim_autopairs},
					{"hrsh7th/cmp-cmdline",commit = pluginCommits.cmp_cmdline},
					{"uga-rosa/cmp-dictionary",commit = pluginCommits.cmp_dictionary},
					-- "hrsh7th/cmp-nvim-lsp-signature-help",
					{"saadparwaiz1/cmp_luasnip",commit = pluginCommits.cmp_luasnip},
				},
			})
			use({
				"ray-x/lsp_signature.nvim",
				commit = pluginCommits.lsp_signature_nvim,
			})
			use({
				"simrat39/symbols-outline.nvim",
				commit = pluginCommits.symbols_outline_nvim,
				cmd = "SymbolsOutline",
				setup = function()
					require("plugincfg.symboloutline")
				end,
				disable = not O.plugin.symbol_outline.enable,
			})
			use({
				"sumneko/lua-language-server",
				commit = pluginCommits.lua_language_server,
				disable = not O.plugin.sumneko.enable,
			})
			use({"onsails/lspkind-nvim" ,commit = pluginCommits.lspkind_nvim})
			require("lsp")
		end
		-- git related
		use({
			"lewis6991/gitsigns.nvim",
			commit = pluginCommits.gitsigns_nvim,
			lock = true,
			config = function()
				require("plugincfg.gitsign").config()
			end,
			requires = {
				commit = pluginCommits.plenary_nvim,
				"nvim-lua/plenary.nvim",
			},
			disable = not O.plugin.gitsigns.enable,
			event = "BufRead",
		})
		use({
			"rhysd/git-messenger.vim",
				commit = pluginCommits.git_messenger_vim,
			disable = not O.plugin.gitmessenger.enable,
		})
		use({
			"TimUntersberger/neogit",
				commit = pluginCommits.neogit,
			opt = false,
			requires = {
				{"nvim-lua/plenary.nvim",commit = pluginCommits.plenary_nvim},
				{"sindrets/diffview.nvim",commit = pluginCommits.diffview_nvim},
			},
			disable = not O.plugin.neogit.enable,
			config = function()
				require("plugincfg.neogit")
			end,
		})
		use({
			"kevinhwang91/nvim-bqf",
				commit = pluginCommits.nvim_bqf,
			disable = not O.plugin.bqbf.enable,
		})
		use({
			"nvim-telescope/telescope.nvim",
				commit = pluginCommits.telescope_nvim,
			config = function()
				require("plugincfg.telescope")
				require("telescope").load_extension("media_files")
				require("telescope").load_extension("fzf")
			end,
			disable = not O.plugin.telescope.enable,
			requires = {
				{ "nvim-telescope/telescope-media-files.nvim",commit = pluginCommits.telescope_media_files_nvim },
				{ "nvim-telescope/telescope-fzf-writer.nvim" ,commit = pluginCommits.telescope_fzf_writer_nvim},
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make",commit = pluginCommits.telescope_fzf_native_nvim },
			},
		})
		use({
			"phaazon/hop.nvim",
			commit = pluginCommits.hop_nvim,
			event = "BufRead",
			config = function()
				require("plugincfg.hop").config()
			end,
			disable = not O.plugin.hop.enable,
			opt = true,
		})
		-- select wondow
		--[[ use({
			"t9md/vim-choosewin",
			disable = not O.plugin.choosewin.enable,
		}) ]]
		-- golang related
		--[[ use({
			"fatih/vim-go",
			ft = "go",
			disable = not O.plugin.vim_go.enable,
			config = function()
				require("plugincfg.vimgo")
			end,
		}) ]]
		use({
			"ray-x/go.nvim",
			commit = pluginCommits.go_nvim,
			ft = "go",
			requires = {
				"mfussenegger/nvim-dap",
				"rcarriga/nvim-dap-ui",
				"theHamsta/nvim-dap-virtual-text",
			},
			config = function()
				require("go").setup()
			end,
		})
		use({
			"sebdah/vim-delve",
			commit = pluginCommits.vim_delve,
			-- disable = not O.plugin.delve.enable,
			ft = "go",
		})
		--[[ use({
			"nvim-lualine/lualine.nvim",
			config=function ()
				require('lualine').setup(
				{
					options = {
						theme = 'gruvbox-material' ,
						section_separators = { left = '', right = ''},
						component_separators = { left = '', right = ''},
						section_separators = { left = '', right = ''},
						component_separators = { left = '', right = ''},
					},
					sections = {
						lualine_a ={{ 'mode',fmt = function (str)
							if string.find(str, 'BLOCK') then
								return "VB"
							end
							return str:sub(1,1)
						end}},
						lualine_b = {'branch'},
						lualine_c = {{'filename'},   {
							'diff',
							colored = true, -- Displays a colored diff status if set to true
							diff_color = {
								-- Same color values as the general color option can be used here.
								added    = 'DiffAdd',    -- Changes the diff's added color
								modified = 'DiffChange', -- Changes the diff's modified color
								removed  = 'DiffDelete', -- Changes the diff's removed color you
							},
							symbols = {added = ' ', modified = ' ', removed = ' '}
						}},
						lualine_x = {{
							'diagnostics',

							-- Table of diagnostic sources, available sources are:
							--   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
							-- or a function that returns a table as such:
							--   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
							sources = { 'nvim_diagnostic'},

							-- Displays diagnostics for the defined severity types
							sections = { 'error', 'warn', 'info', 'hint' },

							diagnostics_color = {
								-- Same values as the general color option can be used here.
								error = 'DiagnosticError', -- Changes diagnostics' error color.
								warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
								info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
								hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
							},
							symbols = {error = ' ', warn = '  ', info = '  ', hint = '  '},
							colored = true,           -- Displays diagnostics status in color if set to true.
							update_in_insert = false, -- Update diagnostics in insert mode.
							always_visible = false,   -- Show diagnostics even if there are none.
						}},
						lualine_y = {'progress'},
						lualine_z = {'location'},
					} ,
					tabline = {},
					extensions = {}
				})
		end
		}) ]]
		-- status/tab line
		use({
			"NTBBloodbath/galaxyline.nvim",
			commit = pluginCommits.galaxyline_nvim,
			-- your statusline
			config = function()
				require("plugincfg.galaxyline")
			end,
			disable = not O.plugin.galaxyline.enable,
		})
		use({
		"akinsho/bufferline.nvim",
		commit = pluginCommits.bufferline_nvim,
		config = function () require('plugincfg.bufferline') end
		})

		-- markdown
		use({
			"iamcco/markdown-preview.nvim",
			commit = pluginCommits.markdown_preview_nvim,
			ft = "markdown",
			run = function()
				vim.fn["mkdp#util#install"]()
			end,
			disable = not O.plugin.markdown_preview.enable,
		})
		-- terminal related
		use({
			"voldikss/vim-floaterm",
			commit = pluginCommits.vim_floaterm,
			disable = not O.plugin.floaterm.enable,
			config = function()
				require("plugincfg.floaterm").config()
			end,
		})
		-- appearance and color schmes
		use({
			"christianchiarulli/nvcode-color-schemes.vim",
			commit = pluginCommits.nvcode_color_schemes_vim,
			disable = not O.plugin.nvcode.enable,
		})
		use({
			"nvim-treesitter/nvim-treesitter",
			commit = pluginCommits.nvim_treesitter,
		run = ":TSUpdate",
			config = function()
				require("plugincfg.treesitter").config()
			end,
			requires = {
				{"nvim-treesitter/nvim-treesitter-refactor",commit = pluginCommits.nvim_treesitter_refactor},
				{"nvim-treesitter/nvim-treesitter-textobjects",commit = pluginCommits.nvim_treesitter_textobjects},
				{"romgrk/nvim-treesitter-context",commit = pluginCommits.nvim_treesitter_context},
				{"p00f/nvim-ts-rainbow",commit = pluginCommits.nvim_ts_rainbow},
			},
			disable = not O.plugin.treesitter.enable,
		})

		use({
			"lukas-reineke/indent-blankline.nvim",
			commit = pluginCommits.indent_blankline_nvim,
			config = function()
				require("plugincfg.indentline").config()
			end,
			disable = not O.plugin.indentblankline.enable,
		})
		use({
			"folke/which-key.nvim",
			commit = pluginCommits.which_key_nvim,
			config = function()
				require("plugincfg.whichkey").config()
			end,
			disable = not O.plugin.whichkey.enable,
		})
		use({
			"mg979/vim-visual-multi",
			commit = pluginCommits.vim_visual_multi,
			disable = not O.plugin.visul_multi.enable,
		})
		use({
			"KabbAmine/vCoolor.vim",
			commit = pluginCommits.vCoolor_vim,
			disable = not O.plugin.vcolor.enable,
		})
		use({
			"andymass/vim-matchup",
			event = "CursorMoved",
			config = function()
				vim.g.matchup_matchparen_offscreen = {method = 'popup'}
			end,
			disable = not O.plugin.matchup.enable,
		})
		--   -- Dashboard
		use({
			"ChristianChiarulli/dashboard-nvim",
			commit = pluginCommits.dashboard_nvim,
			event = "BufWinEnter",
			config = function()
				require("plugincfg.dashboard").setup()
			end,
			disable = not O.plugin.dashboard.enable,
		})
		use({
			"norcalli/nvim-colorizer.lua",
			commit = pluginCommits.nvim_colorizer_lua,
			config = function()
				require("colorizer").setup()
			end,
		})
			use ({"kyazdani42/nvim-web-devicons",commit = pluginCommits.nvim_web_devicons})
		use({
			"folke/trouble.nvim",
			commit = pluginCommits.trouble_nvim,
			config = function()
				require("trouble").setup({})
			end,
		})
		use {
			'Mofiqul/vscode.nvim',
			commit = pluginCommits.vscode_nvim,
		}
		use {
			'sainnhe/gruvbox-material',
		}
		use {
			"cespare/vim-go-templates"
		}
		require("packer_compiled")
	end,
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
		compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
	},

})
