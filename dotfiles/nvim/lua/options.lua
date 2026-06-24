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
}

for key, value in pairs(options) do 
  vim.opt[key] = value
end
