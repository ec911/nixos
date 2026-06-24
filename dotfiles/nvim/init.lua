vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.cmd("colorscheme catppuccin") 
-- Add this directly to your configuration where you load themes
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local groups = { "Normal", "NormalNC", "LineNr", "SignColumn", "EndOfBuffer" }
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
    end
  end,
})
require("keymaps")
require("options")
require("plugins")

