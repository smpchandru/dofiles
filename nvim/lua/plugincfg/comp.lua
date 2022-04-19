local M = {}
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local      source_names = {
        nvim_lsp = "(LSP)",
        emoji = "(Emoji)",
        path = "(Path)",
        calc = "(Calc)",
        cmp_tabnine = "(Tabnine)",
        vsnip = "(Snippet)",
        luasnip = "(Snippet)",
        buffer = "(Buffer)",
      }
local       duplicates = {
        buffer = 1,
        path = 1,
        nvim_lsp = 0,
        luasnip = 1,
      }
local kind_icons= {
        Class = " ",
        Color = " ",
        Constant = "ﲀ ",
        Constructor = " ",
        Enum = "練",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = "",
        Folder = " ",
        Function = " ",
        Interface = "ﰮ ",
        Keyword = " ",
        Method = " ",
        Module = " ",
        Operator = "",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        Struct = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = "塞",
        Value = " ",
        Variable = " ",
      }
M.config = function()
	local compare = require("cmp.config.compare")
	local types = require("cmp.types")
	local comp = require("cmp")
	local WIDE_HEIGHT = 40
	vim.o.completeopt = "menu,menuone,noselect"
	local luasnip = require("luasnip")
local lspkind = require("lspkind")
	comp.setup({
		completion = {
			autocomplete = {
				types.cmp.TriggerEvent.InsertEnter,
				types.cmp.TriggerEvent.TextChanged,
			},
			-- autocomplete = false,
			completeopt = "menu,menuone,noselect",
			keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
			keyword_length = 1,
		},

		snippet = {
			expand = function(args)
				-- vim.fn['vsnip#anonymous'](args.body)
				luasnip.lsp_expand(args.body)
			end,
		},

		documentation = {
			-- border = { '', '', '', ' ', '', '', '', ' ' },
			-- border= {'╭','─','╮', '│','╯', '─','╰', '│'},

			border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
			winhighlight = "NormalFloat:CmpDocumentation,FloatBorder:CmpDocumentationBorder",
			maxwidth = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
			maxheight = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
		},

		confirmation = {
			default_behavior = comp.ConfirmBehavior.Replace,
		},

		sorting = {
			priority_weight = 2,
			comparators = {
				compare.offset,
				compare.exact,
				compare.score,
				compare.kind,
				compare.sort_text,
				compare.length,
				compare.order,
			},
		},

		-- event = {},

		mapping = {
			["<C-p>"] = comp.mapping.select_prev_item(),
			["<C-n>"] = comp.mapping.select_next_item(),
			["<C-d>"] = comp.mapping.scroll_docs(-4),
			["<C-f>"] = comp.mapping.scroll_docs(4),
			["<C-Space>"] = comp.mapping.complete(),
			["<C-e>"] = comp.mapping.close(),
			["<CR>"] = comp.mapping.confirm({
				behavior = comp.ConfirmBehavior.Replace,
				select = true,
			}),
			["<Tab>"] = comp.mapping(function(fallback)
				if comp.visible() then
					comp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					comp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = comp.mapping(function(fallback)
				if comp.visible() then
					comp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = lspkind.cmp_format({
				with_text = false,
				maxwidth = 50,
				menu = {
					buffer = "[buf]",
					nvim_lsp = "[lsp]",
					luasnip = "[snp]",
					nvim_lua = "[lua]",
					latex_symbols = "[ltx]",
					dictionary = "[dic]",
				},
			}),
		},
		--[[ formatting= {
			fomrat=lspkind.cmp_format({
				duplicates_default = 0,
				fields = { "kind", "abbr", "menu" },
				mode = 'symbol', -- show only symbol annotations
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				before = function (entry, vim_item)
				vim_item.kind = kind_icons[vim_item.kind]
				vim_item.menu = source_names[entry.source.name]
				vim_item.dup = duplicates[entry.source.name]
				return vim_item
				end
			})}, ]]
			--[[ formatting = {
			fields = { "kind", "abbr", "menu" },
			duplicates_default = 0,
			format = function(entry, vim_item)
			vim_item.kind = kind_icons[vim_item.kind]
			vim_item.menu = source_names[entry.source.name]
			vim_item.dup = duplicates[entry.source.name]
			return vim_item
			end,
			}, ]]
			experimental = {
				native_menu = false,
				ghost_text = true,
			},

		sources = {
			{ name = "nvim_lua" },
			{ name = "luasnip" },
			{ name = "nvim_lsp" },
			{ name = "calc" },
			{ name = "spell" },
			{ name = "path" },
			{ name = "vim-dadbod-completion" },
			{ name = "latex_symbols" },
			{ name = "buffer", keyword_length = 5 },
			{ name = "dictionary", keyword_length = 4 },
			{ name = "nvim_lsp_signature_help" },
		},
	})
	comp.setup.cmdline("/", {
		sources = {
			{ name = "buffer" },
		},
	})
	comp.setup.cmdline(":", {
		sources = comp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
	-- require'lspinstall'.setup() -- important
	-- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
	-- local servers = require'lspinstall'.installed_servers()
	-- local lspconfig = require("lspconfig")
	-- local configs = require("lspconfig.configs")
	--[[ for _, server in pairs(servers) do
	  -- note we are indexing configs here, not lspconfig
	  if not configs[server] then
		  configs[server] = {
			  default_config = {
				  cmd = { 'golangci-lint-langserver' },
				  root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
				  filetypes = { 'go' },
				  init_options = {
					  command = { 'golangci-lint', 'run', '--fast', '--out-format', 'json' },
				  },
			  },
		  }
	  end
	  lspconfig[server].setup{capabilities = capabilities}
	  -- lspconfig.golangcilsp.setup{}
  end ]]
	-- local lspconfig = require("lspconfig")

	--[[ lspconfig["sumneko_lua"].setup({
		command = "~/.local/share/nvim/site/pack/packer/start/lua-language-server/bin/lua-language-server",
		args = { "-E", "~/.local/share/nvim/site/pack/packer/start/lua-language-server/bin/main.lua" },
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	}) ]]
	-- vim.opt.dictionary:append("/usr/share/dict/words")
end
require("cmp_dictionary").setup({
	dic = {
		["*"] = "/usr/share/dict/words",
	},
	exact = 2,
	async = false,
	capacity = 5,
	debug = false,
})
return M
