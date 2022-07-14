
local o = vim.o

o.hlsearch = true
--o.hidden = true
o.errorbells = false
o.incsearch = true
o.scrolloff = 8
o.showmode = false

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
o.swapfile = false

--keybinginds
--mode lhs rhs

--ergo
vim.cmd[[
  inoremap jj <ESC>
  tnoremap jj <Esc>
]]


-- not using arrow keys, helps with muscle memory
vim.cmd[[
  noremap <Up>    <Nop>
  noremap <Down>  <Nop>
  noremap <Left>  <Nop>
  noremap <Right> <Nop>

  inoremap <Up>    <Nop>
  inoremap <Down>  <Nop>
  inoremap <Left>  <Nop>
  inoremap <Right> <Nop>
]]


-- colorscheme
vim.cmd[[
  colorscheme gruvbox-flat
  hi Normal guibg=NONE ctermbg=NONE
]]

--coc.nvm
vim.cmd[[
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

--window switch
vim.cmd[[
  let mapleader = " "

  nnoremap <Leader>j <c-w>j
  nnoremap <Leader>k <c-w>k
  nnoremap <Leader>l <c-w>l
  nnoremap <Leader>h <c-w>h

  nnoremap <Leader>s <c-w>s
  nnoremap <Leader>v <c-w>v
  nnoremap <Leader>q <c-w>q

  nnoremap <Leader>r :resize 10<cr>
]]


--terminal
vim.cmd[[
  tnoremap <ESC> <C-\><C-n>
  let mapleader = " "
  nnoremap <Leader>t :terminal<CR> 
]]

--nvim tree
vim.cmd[[
  let mapleader = " " 

  nnoremap <Leader>c :NvimTreeClose<CR>
  nnoremap <Leader>f :NvimTreeFocus<CR>
]]


