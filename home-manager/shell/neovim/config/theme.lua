-- colorscheme
vim.o.termguicolors = true
require("catppuccin").setup({
    flavour = "mocha",
    integrations = {
        cmp = true,
        treesitter = true,
        telescope = {
            enabled = true,
        },
        markdown = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
        },
        gitsigns = true,
    }
})
vim.cmd.colorscheme("catppuccin")
