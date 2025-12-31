local language_servers = {
    {
        "lua_ls",
        {
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim" },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                },
            },
        }
    },
    { "nixd" },         -- Nix
}
local autoformat_files = {
    "*.cs"
}

return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            for _, language_server in ipairs(language_servers) do
                local name, config = language_server[1], language_server[2]
                vim.lsp.enable(name)
                if config ~= nil then
                    vim.lsp.config(name, config)
                end
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
}

