-- Lspkind config
local M = {}
function getLuaLibPath()
	local i, t, popen = 0, {}, io.popen
	local parentDir = { vim.fn.stdpath('data') .. "/site/pack/packer/start/", vim.fn.stdpath('data') .. "/site/pack/packer/opt/" }
	for _, k in pairs(parentDir) do
		print(k)
		local pfile = popen('ls -1D "' .. k .. '"')
		for filename in pfile:lines() do
			print(filename)
			i = i + 1
			t[i] = k .. filename .. "/lua"
		end
		pfile:close()
	end
	return t
end

require("lspkind").init({
	mode = "symbol_text",
	preset = "codicons",
})
-- nvim-cmp settings
require("plugincfg.comp").config()
require("plugincfg.autopairs")
-- lsp signature related settings
local sigConfig = {
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	-- If you want to hook lspsaga or other signature handler, pls set to false
	doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
	-- set to 0 if you DO NOT want any API comments be shown
	-- This setting only take effect in insert mode, it does not affect signature help in normal
	-- mode, 10 by default

	floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
	fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
	hint_enable = false, -- virtual hint enable
	hint_prefix = "🐼 ", -- Panda for parameter
	hint_scheme = "String",
	use_lspsaga = false, -- set to true if you want to use lspsaga popup
	hi_parameter = "Underlined", -- how your parameter will be highlight
	max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
	-- to view the hiding contents
	max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
	transpancy = 100,
	handler_opts = {
		border = "single", -- double, single, shadow, none
	},
	extra_trigger_chars = { "(", "," }, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
	-- deprecate !!
	-- decorator = {"`", "`"}  -- this is no longer needed as nvim give me a handler and it allow me to highlight active parameter in floating_window
}

require("lsp_signature").on_attach(sigConfig)
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- vim.lsp.protocol.CompletionItemKind = {
-- 	"  ",
-- 	"  ",
-- 	" ಫ  ",
-- 	" ಕ  ",
-- 	" ಅ  ",
-- 	"[] ",
-- 	"   ",
-- 	" {} ",
-- 	"   ",
-- 	" 襁 ",
-- 	"   ",
-- 	"   ",
-- 	" ಈ  ",
-- 	"   ",
-- 	"   ",
-- 	"   ",
-- 	"   ",
-- 	" ರ  ",
-- 	"   ",
-- 	" ಇ  ",
-- 	" ಖ  ",
-- 	" ಸ  ",
-- 	"   ",
-- 	"   ",
-- 	" ಋ  ",
-- }

-- local function documentHighlight(client, bufnr)
-- 	-- Set autocommands conditional on server_capabilities
-- 	if client.resolved_capabilities.document_highlight then
-- 		vim.api.nvim_exec(
-- 			[[
--       hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
--       hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
--       hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
--       augroup lsp_document_highlight
--         autocmd! * <buffer>
--         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--       augroup END
--     ]],
-- 			false
-- 		)
-- 	end
-- end
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "single",
})
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.settings({
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})
lsp_installer.on_server_ready(function(server)
	-- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
	local opts = {
		on_attach = require("lsp.setup").on_attach,
		-- capabilities = capabilities,
		flags = {
			-- This will be the default in neovim 0.7+
			debounce_text_changes = 150,
		},
	}

	-- (optional) Customize the options passed to the server
	-- if server.name == "tsserver" then
	--     opts.root_dir = function() ... end
	-- end
	if server.name == "sumneko_lua" then
		opts.settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = {
					-- library = getLuaLibPath(),
					library = {
						vim.fn.stdpath('data') .. "/site/pack/packer/start/nvim-treesitter/lua",
						vim.fn.stdpath('config') .. "/lua"
					}
				}
			}

		}
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { "gopls", "rust_analyzer" }
-- for _, lsp in pairs(servers) do
-- 	require("lspconfig")[lsp].setup({
-- 		on_attach = on_attach,
-- 		flags = {
-- 			-- This will be the default in neovim 0.7+
-- 			debounce_text_changes = 150,
-- 		},
-- 	})
-- end
