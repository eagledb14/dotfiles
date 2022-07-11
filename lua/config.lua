--global 
local o = vim.o

o.hlsearch = true
o.hidden = true
o.errorbells = false
o.incsearch = true
o.scrolloff = 8

-- window
local w = vim.wo

w.relativenumber = true
w.nu = true

--buffer
local b = vim.bo

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true



vim.cmd[[
  colorscheme gruvbox-flat
  hi Normal guibg=NONE ctermbg=NONE
]]
