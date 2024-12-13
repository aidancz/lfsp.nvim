local M = {}

M.setup = function(config)
	if config == nil or next(config) == nil then
		M.config = M.config
	else
		M.config = config
	end

	for _, i in ipairs(M.config) do
		if i.type == "lf" then
			require("lfsp/lf")
			vim.keymap.set(
				"n",
				i.backward,
				function() return lf.map_expr(false, i.follow) end,
				{expr = true}
			)
			vim.keymap.set(
				"n",
				i.forward,
				function() return lf.map_expr(true,  i.follow) end,
				{expr = true}
			)
		end
		if i.type == "sp" then
			require("lfsp/sp")
			vim.keymap.set(
				"n",
				i.backward,
				function() return sp.map_expr(false, i.follow) end,
				{expr = true}
			)
			vim.keymap.set(
				"n",
				i.forward,
				function() return sp.map_expr(true,  i.follow) end,
				{expr = true}
			)
		end
	end
end

M.config = {
	{
		type = "lf",
		follow = true,
		backward = "<up>",
		forward = "<down>",
	},
	{
		type = "sp",
		follow = true,
		backward = "<left>",
		forward = "<right>",
	},
}

return M
