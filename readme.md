lfsp.nvim - insert newline/space without entering insert mode

# demo

- dot-repeatable
- support supplying a count
- support choosing whether the cursor follows

# setup

```lua
vim.keymap.set(
	"n",
	"<down>",
	function()
		return
		require("lf").expr({
			direction = "next",
			follow = true,
		})
	end,
	{expr = true}
)
vim.keymap.set(
	"n",
	"<up>",
	function()
		return
		require("lf").expr({
			direction = "prev",
			follow = true,
		})
	end,
	{expr = true}
)
vim.keymap.set(
	"n",
	"<left>",
	function()
		return
		require("sp").expr({
			direction = "prev",
			follow = true,
		})
	end,
	{expr = true}
)
vim.keymap.set(
	"n",
	"<right>",
	function()
		return
		require("sp").expr({
			direction = "next",
			follow = true,
		})
	end,
	{expr = true}
)
```
