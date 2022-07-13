
local o = vim.o

o.hlsearch = true
o.hidden = true
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

--terminal
vim.cmd[[
  tnoremap <ESC> <C-\><C-n>
  let mapleader = " "
  nnoremap <Leader>tt :terminal<CR> 
]]

--nvim tree
vim.cmd[[
  let mapleader = " " 

  nnoremap <Leader>c :NvimTreeClose<CR>
  nnoremap <Leader>f :NvimTreeFocus<CR>
]]

--tabs
vim.cmd[[
  let mapleader = " "


  nnoremap <A-n> :tabnew<cr>
  tnoremap <A-c> <Cmd>BufferClose<cr>

  " Move to previous/next
  nnoremap <silent>    <A-,> <Cmd>BufferPrevious<CR>
  nnoremap <silent>    <A-.> <Cmd>BufferNext<CR>
  " Re-order to previous/next
  nnoremap <silent>    <A-<> <Cmd>BufferMovePrevious<CR>
  nnoremap <silent>    <A->> <Cmd>BufferMoveNext<CR>
  " Goto buffer in position...
  nnoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
  nnoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
  nnoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
  nnoremap <silent>    <A-4> <Cmd>BufferGoto 4<CR>
  nnoremap <silent>    <A-5> <Cmd>BufferGoto 5<CR>
  nnoremap <silent>    <A-6> <Cmd>BufferGoto 6<CR>
  nnoremap <silent>    <A-7> <Cmd>BufferGoto 7<CR>
  nnoremap <silent>    <A-8> <Cmd>BufferGoto 8<CR>
  nnoremap <silent>    <A-9> <Cmd>BufferGoto 9<CR>
  nnoremap <silent>    <A-0> <Cmd>BufferLast<CR>
  " Pin/unpin buffer
  nnoremap <silent>    <A-p> <Cmd>BufferPin<CR>
  " Close buffer
  nnoremap <silent>    <A-c> <Cmd>BufferClose<CR>
  " Wipeout buffer
  "                          :BufferWipeout
  " Close commands
  "                          :BufferCloseAllButCurrent
  "                          :BufferCloseAllButPinned
  "                          :BufferCloseAllButCurrentOrPinned
  "                          :BufferCloseBuffersLeft
  "                          :BufferCloseBuffersRight
  " Magic buffer-picking mode
  nnoremap <silent> <C-p>    <Cmd>BufferPick<CR>

]]


