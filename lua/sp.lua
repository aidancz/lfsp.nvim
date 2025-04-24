local M = {}

---@param count number
---@param direction "prev"|"next"
---@param follow boolean
M.add_sp = function(count, direction, follow)
	for _ = 1, count do
		local row1 = vim.api.nvim_win_get_cursor(0)[1]
		local row0 = row1 - 1
		local col0 = vim.api.nvim_win_get_cursor(0)[2]
		local col1 = col0 + 1
		if col1 == vim.fn.col("$") and direction == "next" then
		-- special case: cursor on eol and append space
			vim.api.nvim_buf_set_text(0, row0+1, 0, row0+1, 0, {" "})
			if follow then
				vim.api.nvim_win_set_cursor(0, {row1+1, 0})
			end
			return
		end
		if direction == "next" then
			vim.api.nvim_buf_set_text(
				0,
				row0,
				col1 + vim.str_utf_end(vim.fn.getline("."), col1),
				row0,
				col1 + vim.str_utf_end(vim.fn.getline("."), col1),
				{" "}
			)
			if follow then
				vim.api.nvim_win_set_cursor(0, {row1, col1 + vim.str_utf_end(vim.fn.getline("."), col1)})
			end
		else
			vim.api.nvim_buf_set_text(0, row0, col0, row0, col0, {" "})
			if follow then
				vim.api.nvim_win_set_cursor(0, {row1, col0})
			end
		end
	end
end

-- # the following is for dot-repeat

M.add_sp_opts = function(opts)
	M.add_sp(opts.count, opts.direction, opts.follow)
end

M.cache_opts = nil

M.apply_cache_opts = function()
	if vim.v.count ~= 0 then
		M.cache_opts.count = vim.v.count
	end
	M.add_sp_opts(M.cache_opts)
end

---@param opts {
---	count?: number,
---	direction: "prev"|"next",
---	follow: boolean,
---}
M.expr = function(opts)
	opts.count = opts.count or vim.v.count1

	M.cache_opts = opts
	vim.o.operatorfunc = [[v:lua.require'sp'.apply_cache_opts]]
	return "g@l"
end

return M
