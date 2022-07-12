--global 
local o = vim.o

o.hlsearch = true
o.hidden = true
o.errorbells = false
o.incsearch = true
o.scrolloff = 8
o.showmode = false
o.autochdir = true
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

  inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

]]


--keybindings


