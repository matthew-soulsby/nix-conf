local language_servers = {
    "lua_ls",       -- Lua
}
local autoformat_files = {
    "*.cs"
}

for _, language_server in ipairs(language_servers) do
    vim.lsp.enable(language_server)
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
