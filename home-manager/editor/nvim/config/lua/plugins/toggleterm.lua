return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {
            direction = 'float',
            float_opts = {
                border = 'curved'
            },
        },
        config = function (_, opts)
            require('toggleterm').setup(opts)

            local Terminal  = require('toggleterm.terminal').Terminal
            local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

            local lazygit_toggle = function ()
              lazygit:toggle()
            end

            vim.keymap.set("n", "<leader>og", lazygit_toggle, { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>ot", ":ToggleTerm <CR>", {noremap = true, silent = true})
        end
    },
}
