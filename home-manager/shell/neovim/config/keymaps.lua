-- Keymaps for better default experience
-- See `:help vim.keymap.set()`

-- set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "Q", "<nop>")

-- disable highlights
vim.keymap.set({ "n", "v" }, "<leader><CR>", "<CMD>noh<CR>", { silent = true })

-- resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<CMD>resize +2<CR>")
vim.keymap.set("n", "<C-Down>", "<CMD>resize -2<CR>")
vim.keymap.set("n", "<C-Left>", "<CMD>vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", "<CMD>vertical resize +2<CR>")

-- better movement
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- J/K to move up/down visual lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- spell
vim.keymap.set({ "n", "v" }, "<leader>s", "<CMD>setlocal spell!<CR>")

-- easy save
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", { silent = true, })

-- easy quit
vim.keymap.set("n", "<leader>q", "<CMD>q<CR>", { silent = true, })
vim.keymap.set("n", "<leader>Q", "<CMD>qa!<CR>", { silent = true, })

-- split window
vim.keymap.set("n", "<leader>-", "<C-W>s", { remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { remap = true })

-- global yank
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { noremap = true, silent = true }
)

-- paste without losing the buffer
vim.keymap.set("x", "<leader>p", [["_dP]], { noremap = true, silent = true })
