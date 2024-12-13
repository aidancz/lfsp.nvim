lfsp.nvim - insert newline/space without entering insert mode

# demo

- dot-repeatable
- support supplying a count
- support choosing whether the cursor follows

# setup

## setup example 1:

```
require("lfsp").setup()
```

this uses default settings, which is equivalent to:

```
require("lfsp").setup({
	{
		type = "lf",
		follow = true,
		backward = "<up>",
		forward = "<down>",
	},
	{
		type = "sp",
		follow = true,
		backward = "<left>",
		forward = "<right>",
	},
})
```

## setup example 2:

if you want `lf` only:

```
require("lfsp").setup({
	{
		type = "lf",
		follow = true,
		backward = "<up>",
		forward = "<down>",
	},
})
```

## setup example 3:

if you want to test the difference between `follow = true` and `follow = false`, you may:

```
require("lfsp").setup({
	{
		type = "lf",
		follow = true,
		backward = "<up>",
		forward = "<down>",
	},
	{
		type = "lf",
		follow = false,
		backward = "<leader>k",
		forward = "<leader>j",
	},
})
```

## setup example 4:

if you are using `lazy.nvim`:

```
{
	"aidancz/lfsp.nvim",
	config = function()
		require("lfsp").setup()
	end,
}
```
