-- See `:help telescope` and `:help telescope.setup()`
local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<C-n>"] = "move_selection_next",
                ["<C-p>"] = "move_selection_previous",
                ["<C-u>"] = false,
                ["<C-d>"] = false,
                ["<C-Down>"] = function(...)
                    return actions.cycle_history_next(...)
                end,
                ["<C-Up>"] = function(...)
                    return actions.cycle_history_prev(...)
                end,
                ["<C-f>"] = function(...)
                    return actions.preview_scrolling_down(...)
                end,
                ["<C-b>"] = function(...)
                    return actions.preview_scrolling_up(...)
                end,
            },
            n = {
                ["q"] = function(...)
                    return actions.close(...)
                end,
            },
        },
    },
    extensions = {
        file_browser = {
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
        },
    },
})

-- nvim-telescope/telescope-fzf-native.nvim
require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")

-- keymaps
local telescope = require("telescope.builtin")
-- vim.keymap.set("n", "<leader>t", telescope.builtin)
vim.keymap.set("n", "<leader><leader>", telescope.resume)
vim.keymap.set("n", "<leader>f", telescope.git_files)
vim.keymap.set("n", "<leader>F", telescope.find_files)
vim.keymap.set("n", "<leader>B", "<CMD>Telescope file_browser<CR>")
vim.keymap.set("n", "<leader>b", telescope.buffers)
vim.keymap.set("n", "<leader>g", telescope.live_grep)
vim.keymap.set("n", "<leader>/", telescope.current_buffer_fuzzy_find)
