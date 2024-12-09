return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            defaults = {
                initial_mode = "normal",
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown{}
                }
            }
        },
        config = function(_, opts)
            local telescope = require('telescope')
            local builtin   = require('telescope.builtin')
            local plugins   = {
                'ui-select',
                'file_browser'
            }

            telescope.setup(opts)

            for _, plugin in ipairs(plugins) do
                telescope.load_extension(plugin)
            end

            vim.keymap.set('n', '<leader>ff', ':Telescope find_files hidden=true <CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set("n", "<leader>fb", ':Telescope file_browser hidden=true <CR>', { noremap = true, silent = true })
        end
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
         dependencies = { "nvim-telescope/telescope.nvim" }
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" }
    }
}
