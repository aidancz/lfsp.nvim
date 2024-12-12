lf = {}

lf.fun = function(direction)
	lf.direction = direction
	vim.go.operatorfunc = "v:lua.lf.fun_callback"
	return "g@l"
end

lf.fun_callback = function()
	local lnum_current = vim.fn.line(".")
	vim.fn.append((lf.direction and lnum_current or lnum_current - 1), vim.fn["repeat"]({""}, vim.v.count1))
	if lf.direction then
		vim.api.nvim_feedkeys(vim.v.count1 .. "j", "n", false)
	else
		vim.api.nvim_feedkeys(vim.v.count1 .. "k", "n", false)
	end
end
