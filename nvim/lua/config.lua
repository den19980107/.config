require("toggleterm").setup{
  direction = 'float',
  on_open = function()
    vim.cmd("startinsert!")
  end,
}
