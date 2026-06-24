-- Keymaps
local map = vim.keymap.set
local opts = { silent = true }


map("n", "<leader>cd", function()
  local buf_name = vim.api.nvim_buf_get_name(0)
  local path = vim.fn.filereadable(buf_name) == 1 and vim.fs.dirname(buf_name) or nil
  require("mini.files").open(path)
end, { desc = "Open mini.files (current directory)" })
map('n', '<leader>ff', '<cmd>Pick files<cr>', { desc = 'Find Files' })
map('n', '<leader>fg', '<cmd>Pick grep_live<cr>', { desc = 'Live Grep' })
map('n', '<leader>fb', '<cmd>Pick buffers<cr>', { desc = 'Find Buffers' })
