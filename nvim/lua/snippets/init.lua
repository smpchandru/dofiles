local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

local fun_ret = function()
	local funInf = require 'utils'.get_go_func_info()
	local ret = ""
	local first = true
	for _, v in pairs(funInf.ret) do
		if not first then
			ret = ret .. ", "
		end
		if v == "error" then
			ret = ret .. "errors.Wrap(err,\"" .. funInf.name .. "\")"
		else
			ret = ret .. v
		end
		first = false
	end
	return ret
end

ls.snippets = {
	go = {
		s("fn", fmt([[
		func {}({} {}){}{{
			{}
		}}
		]], {
			i(1, "Name"),
			i(2, "arg"),
			i(3, "type"),
			c(4, {
				t("(ret,error)"),
				t("")
			}),
			i(0)

		})),
		s("ret", fmt("return  {}", {
			d(1, function()
				return sn(nil, c(1, { f(fun_ret), t "" }))
			end)
		}
		)),
		s("ifer", fmt(
			[[ 
			if err != nil {{
				mlog.Error("{}, %s",err.Error())
				return  {}
			}}
			]], {
			i(1, "message"),
			d(2, function()
				local node = {}
				local ret = fun_ret()
				table.insert(node, t(ret))
				table.insert(node, t "")
				return sn(nil, c(1, node))
			end)
		}
		))
	}
}
