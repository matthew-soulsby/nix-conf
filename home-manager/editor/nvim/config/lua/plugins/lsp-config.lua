local language_servers = {
    "lua_ls",       -- Lua
    "pyright",      -- Python
    "dockerls",     -- Docker
--    "zls",          -- Zig
    "ts_ls",        -- JS/TS
    "volar",        -- Vue
}


return {
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                border = "rounded"
            }
        }
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = language_servers
        }
    },
    {
        "Hoffs/omnisharp-extended-lsp.nvim"
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local autoformat_files = {
                "*.cs"
            }

            for _, language_server in ipairs(language_servers) do
                lspconfig[language_server].setup({
                    capabilities = capabilities
                })
            end

            lspconfig.zls.setup({
                capabilities = capabilities
            })

            lspconfig["omnisharp"].setup({
                capabilities = capabilities,
                --on_attach = on_attach,
                cmd = { "OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
                handlers = {
                    ["textDocument/definition"] = require("omnisharp_extended").handler,
                },
                enable_editorconfig_support = true,
                enable_ms_build_load_projects_on_demand = false,
                enable_roslyn_analyzers = true,
                organize_imports_on_format = true,
                enable_import_completion = true,
                sdk_include_prereleases = true,
                analyze_open_documents_only = true,
                settings = {
                    FormattingOptions = {
                        EnableEditorConfigSupport = true,
                    },
                },
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Buffer local mappings.
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<leader>fo', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })

            vim.api.nvim_create_autocmd('BufWritePost', {
                group = vim.api.nvim_create_augroup('FormatAutogroup', {}),
                pattern = autoformat_files,
                callback = function()
                    vim.lsp.buf.format()
                end
            })
        end
    }
}

