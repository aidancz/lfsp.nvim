lf = {}

lf.map_expr = function(direction, follow)
	vim.o.operatorfunc = "v:lua.lf.callback"
	lf.direction = direction
	lf.follow = follow
	return "g@l"
end

lf.callback = function()
	for i = 1, vim.v.count1 do
		local l, c = unpack(vim.api.nvim_win_get_cursor(0))
		if lf.direction then
			vim.api.nvim_buf_set_lines(0, l,   l,   true, {""})
		else
			vim.api.nvim_buf_set_lines(0, l-1, l-1, true, {""})
		end

		if lf.follow then
			if lf.direction then
				vim.api.nvim_feedkeys("j", "n", false)
			else
				vim.api.nvim_feedkeys("k", "n", false)
			end
		end
	end
end
