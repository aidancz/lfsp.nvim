-- help functions

local H = {}

H.virtcol_cursor = function()
	return vim.fn.virtcol(".", true)[1]
end

H.width_editable_text = function()
	local wininfo = vim.fn.getwininfo(vim.fn.win_getid())[1]
	local textoff = wininfo.textoff
	local width = wininfo.width
	local width_editable_text = width - textoff
	-- https://stackoverflow.com/questions/26315925/get-usable-window-width-in-vim-script

	return width_editable_text
end

H.virtcol_remainder = function(virtcol)
	local width_editable_text = H.width_editable_text()
	local virtcol_remainder = virtcol % width_editable_text
	return virtcol_remainder
end

H.set_cursor = function(lnum, virtcol)
	local col = vim.fn.virtcol2col(0, lnum, virtcol)
	if virtcol >= vim.fn.virtcol({lnum, "$"}) then
	-- HACK: fix virtcol2col
		col = col + 1
	end

	local off
	local virtcol_max = vim.fn.virtcol({lnum, "$"})
	if virtcol > virtcol_max then
		off = virtcol - virtcol_max
	else
		off = 0
	end

	-- local curswant = H.virtcol_remainder(virtcol)
	-- local curswant = vim.fn.getcurpos()[5]
	local curswant = virtcol

	vim.fn.cursor({lnum, col, off, curswant})
end

return H
