require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        disable = {},
    },
    autotag = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-space>",
            node_decremental = "<M-space>",
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,             -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
    },
})
