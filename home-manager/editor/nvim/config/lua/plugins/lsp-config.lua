local language_servers = {
    "lua_ls",       -- Lua
    "pyright",      -- Python
    "dockerls",     -- Docker
--    "zls",          -- Zig
    "ts_ls",        -- JS/TS
    "volar",        -- Vue
}


return {
    --[[
    {
        "williamboman/mason.nvim",
        dependencies = {
            { "mason-org/mason.nvim", version = "^1.0.0" },
            { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
        },
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
        "neovim/nvim-lspconfig",
        dependencies = {
            { "mason-org/mason.nvim", version = "^1.0.0" },
            { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
        },
        config = function()
            local lspconfig = vim.lsp.config
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local autoformat_files = {
                "*.cs"
            }

            for _, language_server in ipairs(language_servers) do
                lspconfig[language_server].setup({
                    capabilities = capabilities
                })
            end

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
    --]]
}

