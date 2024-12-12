require("lfsp/lf")
vim.keymap.set("n", "<down>",  function() return lf.fun(true)  end, {expr = true})
vim.keymap.set("n", "<up>",    function() return lf.fun(false) end, {expr = true})

require("lfsp/sp")
vim.keymap.set("n", "<right>", function() return sp.fun(true)  end, {expr = true})
vim.keymap.set("n", "<left>",  function() return sp.fun(false) end, {expr = true})
