local M = {}

M.add_lf = function(direction, count, follow)
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

-- the following is for dot-repeat

M.cache = {
	direction = nil,
	count = nil,
	follow = nil,
}

M.update_cache = function(direction, follow)
	M.cache.direction = direction
	M.cache.count = vim.v.count1
	M.cache.follow = follow
end

M.apply_cache = function()
	M.add_lf(
		M.cache.direction,
		vim.v.count == 0 and M.cache.count or vim.v.count,
		M.cache.follow
	)
end

M.new = function(direction, follow)
	M.update_cache(direction, follow)
	M.apply_cache()
end

-- the following is for expr mapping

M.expr = function(direction, follow)
	M.update_cache(direction, follow)
	vim.o.operatorfunc = [[v:lua.require'lf'.apply_cache]]
	return "g@l"
end

return M
