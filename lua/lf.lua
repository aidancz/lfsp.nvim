local M = {}

---@param count number
---@param direction "prev"|"next"
---@param follow boolean
M.add_lf = function(count, direction, follow)
	for _ = 1, count do
		local row1 = vim.api.nvim_win_get_cursor(0)[1]
		local row0 = row1 - 1
		if direction == "next" then
			vim.api.nvim_buf_set_lines(0, row0+1, row0+1, true, {""})
			if follow then
				vim.api.nvim_win_set_cursor(0, {row1+1, 0})
			end
		else
			vim.api.nvim_buf_set_lines(0, row0, row0, true, {""})
			if follow then
				vim.api.nvim_win_set_cursor(0, {row1, 0})
			end
		end
	end
end

-- # the following is for dot-repeat

M.cache = {
	count = 1,
	direction = "next",
	follow = true,
}

M.cache_apply = function()
	if vim.v.count ~= 0 then
		M.cache.count = vim.v.count
	end

	M.add_lf(
		M.cache.count,
		M.cache.direction,
		M.cache.follow
	)
end

---@param opts? {
---	count?: number,
---	direction:? "prev"|"next",
---	follow:? boolean,
---}
M.expr = function(opts)
	M.cache = vim.tbl_extend(
		"force",
		{
			count = 1,
			direction = "next",
			follow = true,
		},
		opts or {}
	)
	vim.o.operatorfunc = [[v:lua.require'lf'.cache_apply]]
	return "g@l"
end

return M
