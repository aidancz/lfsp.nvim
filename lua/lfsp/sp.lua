sp = {}

sp.map_expr = function(direction, follow)
	vim.o.operatorfunc = "v:lua.sp.callback"
	sp.direction = direction
	sp.follow = follow
	return "g@l"
end

sp.callback = function()
	for i = 1, vim.v.count1 do

		local l, c = unpack(vim.api.nvim_win_get_cursor(0))

		if sp.direction and c == vim.fn.col("$")-1 then
			vim.api.nvim_buf_set_text(0, l-1+1, 0, l-1+1, 0, {" "})
			if not sp.follow then return end
			vim.api.nvim_win_set_cursor(0, {l+1, 0})
		elseif sp.direction then
			vim.api.nvim_buf_set_text(
				0,
				l-1,
				c+1+vim.str_utf_end(vim.fn.getline("."), c+1),
				l-1,
				c+1+vim.str_utf_end(vim.fn.getline("."), c+1),
				{" "}
			)
			if not sp.follow then return end
			vim.api.nvim_win_set_cursor(0, {l, c+1+vim.str_utf_end(vim.fn.getline("."), c+1)})
		elseif not sp.direction then
			vim.api.nvim_buf_set_text(0, l-1, c, l-1, c, {" "})
			if not sp.follow then return end
			vim.api.nvim_win_set_cursor(0, {l, c})
		end

	end
end
