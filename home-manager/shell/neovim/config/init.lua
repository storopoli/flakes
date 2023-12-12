vim.o.autoread = true
vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true
vim.o.ruler = true
vim.o.colorcolumn = "80"
vim.o.incsearch = true
vim.o.hlsearch = true

vim.o.timeoutlen = 500 -- http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
vim.o.ttyfast = true
vim.o.updatetime = 50
vim.o.completeopt = "menuone,noselect"

vim.o.wrap = false
vim.o.scrolloff = 8     -- better scrolling
vim.o.sidescrolloff = 8 -- better scrolling
vim.o.splitright = true -- vsplit put the new buffer on the right of the current buffer
vim.o.splitbelow = true -- split put the new buffer below the current buffer

-- neovim specific
vim.wo.signcolumn = "yes"
-- set command line height to zero lines
vim.opt.cmdheight = 0

-- statusbar
vim.opt.laststatus = 3

-- winbar on top of the windows
vim.opt.winbar = "%=%m %f"

-- Better undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"
vim.opt.undofile = true
