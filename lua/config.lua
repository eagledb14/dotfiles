
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

vim.cmd[[
  let mapleader = " "
  nnoremap ; :
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
]]

--terminal
vim.cmd[[
  tnoremap <ESC> <C-\><C-n><C-w><c-q>
  let mapleader = " "
  nnoremap <Leader>t :terminal<CR>
]]

--telescope
vim.cmd[[
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
]]


--coc.nvm
vim.cmd[[
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice.
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  
]]
