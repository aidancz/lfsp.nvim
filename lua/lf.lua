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

M.add_lf_opts = function(opts)
	M.add_lf(opts.count, opts.direction, opts.follow)
end

M.cache_opts = nil

M.apply_cache_opts = function()
	if vim.v.count ~= 0 then
		M.cache_opts.count = vim.v.count
	end
	M.add_lf_opts(M.cache_opts)
end

---@param opts {
---	count?: number,
---	direction: "prev"|"next",
---	follow: boolean,
---}
M.expr = function(opts)
	opts.count = opts.count or vim.v.count1

	M.cache_opts = opts
	vim.o.operatorfunc = [[v:lua.require'lf'.apply_cache_opts]]
	return "g@l"
end

return M
