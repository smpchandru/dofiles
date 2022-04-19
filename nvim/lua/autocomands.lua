Aucom = {}
function Aucom.define_augroups(definitions) -- {{{1
	-- Create autocommand groups based on the passed definitions
	--
	-- The key will be the name of the group, and each definition
	-- within the group should have:
	--    1. Trigger
	--    2. Pattern
	--    3. Text
	-- just like how they would normally be defined from Vim itself
	for group_name, definition in pairs(definitions) do
		vim.cmd("augroup " .. group_name)
		vim.cmd("autocmd!")

		for _, def in pairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			vim.cmd(command)
		end

		vim.cmd("augroup END")
	end
end
Aucom.define_augroups({
	numbertoggle = {
		{ "BufEnter,FocusGained,InsertLeave", "*", "set nu rnu" },
		{ "BufLeave,FocusLost,InsertEnter", "*", "set norelativenumber" },
	},
})
Aucom.define_augroups({
	fugutive = {
		{ "BufEnter,FocusGained,InsertLeave", "*", "set nu rnu" },
		{
			"User",
			"fugitive",
			"if fugitive#buffer().type() =~# '^\\%(tree\\|blob\\)$' | nnoremap <buffer> <C-o> ..  :edit %:h<CR> endif",
		},
	},
})
Aucom.define_augroups({
	general_setting = {
		{
			"BufEnter      , FocusGained    , InsertLeave",
			"*",
			"set nu rnu",
		},
		{
			"User",
			"fugitive",
			"if fugitive#buffer().type() =~# '^\\%(tree\\|blob\\)$' | nnoremap <buffer> <C-o> ..  :edit %:h<CR> endif",
		},
		{ "BufReadPost", "fugitive://*", "set bufhidden=delete" },
		{
			"BufNewFile    , BufRead",
			"*.py",
			':lua require("utils").SetPythonIndent()',
		},
		{
			"BufNewFile    , BufRead",
			"*.{c                                                                                                       , cpp                                        , cc                                     , h , hpp}",
			':lua require("utils").SetCCIndent()',
		},
		{
			"BufNewFile    , BufReadPost",
			"*.{yaml                                                                                                    , yml}",
			"set filetype=yaml foldmethod=indent",
		},
		{ "FileType", "yaml", "setlocal ts=2 sts=2 sw=2 expandtab" },
		{
			"BufNewFile    , BufRead",
			"Jenkinsfile",
			"setf groovy",
		},
		{ "FileType", "qf", "nnoremap <buffer><silent> <esc> :quit<cr>" },
		{ "CursorHold", "*", ':lua require("plugincfg.gitblame").BlameVirtText()' },
		{ "CursorMoved", "*", ':lua require("plugincfg.gitblame").ClearBlameVirtText()' },
		{ "CursorMovedI", "*", ':lua require("plugincfg.gitblame").ClearBlameVirtText()' },
	},
})
--[[ function OrgImports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = {only = {"source.organizeImports"}}
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for _, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				vim.lsp.util.apply_workspace_edit(r.edit)
			else
				vim.lsp.buf.execute_command(r.command)
			end
		end
	end
end ]]

if O.lsp_client == true then
	Aucom.define_augroups({
		signature_help = {
			{ "BufReadPost,FileReadPost", "*", ':lua require "lsp_signature".on_attach()' },
			{ "BufWritePre", "*", ":lua vim.lsp.buf.formatting()" },
			-- {'BufWritePre', '*.go','lua OrgImports(1000)'}
		},
	})
end
-- Run gofmt + goimport on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)


