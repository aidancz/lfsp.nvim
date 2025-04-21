lfsp.nvim - insert newline/space without entering insert mode

# demo

- dot-repeatable
- support supplying a count
- support choosing whether the cursor follows

# setup

```lua
vim.keymap.set({"n", "x", "o"}, "<down>",  function() return require("lf").expr("next", true) end, {expr = true})
vim.keymap.set({"n", "x", "o"}, "<up>",    function() return require("lf").expr("prev", true) end, {expr = true})
vim.keymap.set({"n", "x", "o"}, "<left>",  function() return require("sp").expr("prev", true) end, {expr = true})
vim.keymap.set({"n", "x", "o"}, "<right>", function() return require("sp").expr("next", true) end, {expr = true})
```
