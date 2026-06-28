vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd("colorscheme catppuccin") 

-- Options
local options = {
  number 	    = true,
  relativenumber = true,
  shiftwidth 	= 2,
  tabstop   	= 2,
  clipboard 	= "unnamedplus",
  termguicolors = true,
  expandtab 	= true,
  smartcase 	= true,
  wrap = false,
}

for key, value in pairs(options) do 
  vim.opt[key] = value
end

-- Keymaps
local map = vim.keymap.set
local opts = { silent = true }

vim.pack.add({
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/xiyaowong/transparent.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim'
})  

require('lualine').setup()
require('transparent').setup()
require('plugins.hipatterns')
require('plugins.mover')
require('plugins.icons')
