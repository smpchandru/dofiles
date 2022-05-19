local M = {}
function M.SetPythonIndent()
	vim.o.tabstop = 4
	vim.o.softtabstop = 4
	vim.o.shiftwidth = 4
	vim.o.textwidth = 0
	vim.o.expandtab = true
	vim.o.autoindent = true
	vim.o.fileformat = 'unix'
end

-- C/C++ indentation settings
function M.SetCCIndent()
	vim.o.tabstop = 2
	vim.o.softtabstop = 2
	vim.o.shiftwidth = 2
	vim.o.textwidth = 0
	vim.o.expandtab = true
	vim.o.fileformat = 'unix'
end

-- Toggle mouse enable
-- copied from http://unix.stackexchange.com/questions/156707/how-to-toggle-mouse-support-in-vim
function M.ToggleMouse()

	-- check if mouse is enabled
	if vim.o.mouse == 'a'
	then
		-- disable mouse
		vim.o.mouse = ''
	else
		-- enable mouse everywhere
		vim.o.mouse = 'a'
	end
end

--Retain the cursor position across the vim sessions
function M.ResCur()
	if vim.fn.line("'\"") <= vim.fn.line("$")
	then
		vim.cmd([[ normal! g`" ]])
		return 1
	end
end

--function to search in range
function M.RangeSearch(direction)
	vim.fn.inputsave()
	vim.g.srchstr = vim.fn.input(direction)
	vim.fn.inputrestore()
	if vim.fn.strlen(vim.g.srchstr) > 0
	then
		vim.g.srchstr = vim.g.srchstr .. '\\%>' .. (vim.fn.line("'<") - 1) .. 'l' .. '\\%<' .. (vim.fn.line("'>") + 1) .. 'l'
	else
		vim.g.srchstr = ''
	end
end

local opts = { noremap = true, silent = true }
M.map = function(mode, key, action, opt)
	vim.api.nvim_set_keymap(mode, key, action, opt or opts)
end

-- Get go function info
function M.get_go_func_info()
	local ts_utils = require "nvim-treesitter.ts_utils"
	local locals = require "nvim-treesitter.locals"
	local cur_node = ts_utils.get_node_at_cursor()
	local scope = locals.get_scope_tree(cur_node, 0)
	local method_node = nil
	for _, node in ipairs(scope) do
		if node:type() == "function_declaration" then
			method_node = node
		end
	end
	if not method_node then
		return
	end
	local query      = vim.treesitter.parse_query('go', [[
	(function_declaration
	  name:(identifier) @name
	  parameters: (parameter_list) @params
	  result: [ 
	  	(parameter_list) 
		(type_identifier) 
	  ]? @results
	  )
	]])
	local paramInfo  = {}
	local returnInfo = {}
	local funcName   = nil
	for _, matches, _ in query:iter_matches(method_node, 0) do
		funcName = vim.treesitter.query.get_node_text(matches[1], 0)
		local param_node = matches[2]
		local return_node = matches[3]
		for par in param_node:iter_children() do
			if par:type() == 'parameter_declaration' then
				table.insert(paramInfo, {
					type = vim.treesitter.get_node_text(par:field('name')[1], 0),
					name = vim.treesitter.get_node_text(par:field('type')[1], 0)
				})
			end
		end
		local isMultiRet = false
		if return_node then
			for par in return_node:iter_children() do
				if par:type() == 'parameter_declaration' then
					table.insert(returnInfo,
						vim.treesitter.get_node_text(par:field('type')[1], 0)
					)
					isMultiRet = true
				end
				print(vim.inspect(par))
			end
			if not isMultiRet then
				table.insert(returnInfo,
					vim.treesitter.query.get_node_text(matches[3], 0)
				)
			end
		end
	end
	return {
		name = funcName,
		ret = returnInfo,
		param = paramInfo,
		funcStart = method_node:start(),
	}
end

return M
