require('mini.files').setup()
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesActionRename", -- Triggers safely when a file is manipulated/opened
  callback = function()
    -- Optional tweak to auto-close or refresh if needed
  end,
})
