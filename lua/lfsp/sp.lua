sp = {}

sp.fun = function(direction)
	sp.direction = direction
	vim.go.operatorfunc = "v:lua.sp.fun_callback"
	return "g@l"
end

sp.fun_callback = function()
	vim.api.nvim_put({string.rep(" ", vim.v.count1)}, "c", sp.direction, true)
	if sp.direction then
		vim.api.nvim_feedkeys("h", "n", false)
	else
		vim.api.nvim_feedkeys(vim.v.count1 .. "h", "n", false)
	end
end
