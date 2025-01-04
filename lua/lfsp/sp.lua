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
		if sp.direction then
			-- vim.api.nvim_buf_set_text(0, l-1, c+1, l-1, c+1, {" "})
			vim.api.nvim_buf_set_text(
				0,
				l-1,
				c+1+vim.str_utf_end(vim.fn.getline("."), c+1),
				l-1,
				c+1+vim.str_utf_end(vim.fn.getline("."), c+1),
				{" "}
			)
		else
			vim.api.nvim_buf_set_text(0, l-1, c,   l-1, c,   {" "})
		end

		if sp.follow then
			if sp.direction then
				vim.api.nvim_feedkeys("l", "n", false)
			else
				vim.api.nvim_feedkeys("h", "n", false)
			end
		end
	end
end
