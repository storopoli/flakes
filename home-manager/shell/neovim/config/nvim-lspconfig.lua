-- setup language servers
local lsp = require("lspconfig")
-- needs nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- enable some language servers with the additional completion capabilities offered by nvim-cmp
lsp.ruff_lsp.setup({ -- requires ruff-lsp to be installed
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- disable hover in favor of pyright
        client.server_capabilities.hoverProvider = false
    end,
})
lsp.pyright.setup({ capabilities = capabilities })  -- requires pyright to be installed
lsp.bashls.setup({ capabilities = capabilities })   -- requires bash-language-server to be installed
lsp.html.setup({ capabilities = capabilities })     -- requires vscode-langservers-extracted to be installed
lsp.cssls.setup({ capabilities = capabilities })    -- requires vscode-langservers-extracted to be installed
lsp.jsonls.setup({ capabilities = capabilities })   -- requires vscode-langservers-extracted to be installed
lsp.eslint.setup({ capabilities = capabilities })   -- requires vscode-langservers-extracted to be installed
lsp.rnix.setup({ capabilities = capabilities })     -- requires rnix to be installed
lsp.taplo.setup({ capabilities = capabilities })    -- requires taplo to be installed
lsp.marksman.setup({ capabilities = capabilities }) -- requires marksman to be installed
lsp.julials.setup({ capabilities = capabilities })  -- requires julia to be installed
lsp.lua_ls.setup({                                  -- requires lua-language-server to be installed
    capabilities = capabilities,
    settings = {
        Lua = {
            telemetry = { enable = false },
            hint = { enable = true },
            workspace = {
                checkThirdParty = false,
            },
            completion = {
                callSnippet = "Replace",
            },
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})
lsp.rust_analyzer.setup({ -- requires rust-analyzer to be installed
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
            },
            checkOnSave = true,
            -- Add clippy lints for Rust
            check = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
            },
            imports = {
                granularity = {
                    enforce = true,
                    group = "create",
                },
            },
        },
    },
})
lsp.yamlls.setup({ -- requires yaml-language-server to be installed
    capabilities = capabilities,
    settings = {
        yamlls = {
            schemas = {
                ["kubernetes"] = "*.yaml",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
                "docker-compose.yaml",
                ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.yaml",
                ["https://json.schemastore.org/github-action.json"] = ".github/actions/*/action.yaml",
            },
        },
    },
})
lsp.texlab.setup({ -- requires texlab to be installed
    capabilities = capabilities,
    settings = {
        build = {
            executable = "tectonic",
            args = { "-X", "build", "--keep-logs", "--keep-intermediates" },
            latexFormatter = "texlab",
            forwardSearchAfter = false,
            onSave = false,
        },
    },
})
lsp.typst_lsp.setup({ capabilities = capabilities }) -- requires typst-lsp to be installed


-- global mappings.
-- see `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>k", vim.diagnostic.setloclist)

-- use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>d", require("telescope.builtin").lsp_document_symbols, opts)
        vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
        end, opts)
        vim.keymap.set("n", "<leader>D", "<CMD>DiagnosticsToggle<CR>", opts)
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

        -- enable autoformat on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = { "*.rs", "*.py", "*.nix", "*.jl", "*.yml", "*.yaml", "*.toml", "*.html", "*.css", "*.sh", "*.lua", ".tex", ".typ", ".bib" },
            callback = function()
                vim.lsp.buf.format() -- { async = true }
            end
        })

        -- command to toggle inline diagnostics
        vim.api.nvim_create_user_command(
            "DiagnosticsToggleVirtualText",
            function()
                local current_value = vim.diagnostic.config().virtual_text
                if current_value then
                    vim.diagnostic.config({ virtual_text = false })
                else
                    vim.diagnostic.config({ virtual_text = true })
                end
            end,
            {}
        )

        -- Command to toggle diagnostics
        vim.api.nvim_create_user_command(
            "DiagnosticsToggle",
            function()
                local current_value = vim.diagnostic.is_disabled()
                if current_value then
                    vim.diagnostic.enable()
                else
                    vim.diagnostic.disable()
                end
            end,
            {}
        )

        -- enable inlay hints
        local inlay_hint = vim.lsp.buf.inlayhints or vim.lsp.inlayhints
        if vim.fn.has("nvim-0.10.0") and inlay_hint then
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if client.supports_method("textDocument/inlayHint") then
                vim.g.inlay_hints_visible = true
                vim.lsp.inlay_hint(ev.buf, true)
                -- set the keymap to toggle on/off
                vim.keymap.set("n", "<leader>ch", function()
                    vim.lsp.inlay_hint(ev.buf, nil)
                end, opts)
            end
        end
    end,
})
