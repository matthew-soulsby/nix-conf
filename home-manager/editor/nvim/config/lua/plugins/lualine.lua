local noice = require('noice')

return {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = 'auto',
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {
                    {
                        function ()
                            return vim.g.remote_neovim_host and vim.uv.os_gethostname() or ""
                        end,
                        padding = { right = 1, left = 1 },
                    },
                    'branch',
                    'diff',
                    'diagnostics'
                },
                lualine_c = {'filename'},
                lualine_x = {
                    {
                        function ()
                            return noice.api.status.has and noice.api.status.command.get() or ""
                        end,
                    },
                    {
                        function ()
                            return noice.api.status.search.has and noice.api.status.search.get() or ""
                        end,
                    },
                    {
                        function ()
                            return (noice.api.statusline.mode.has and noice.api.statusline.mode.get():find('recording', 1, true) and noice.api.statusline.mode.get()) or ""
                        end
                    }
                },
                lualine_y = {'filetype'},
                lualine_z = {'location'}
            }
        },
    },
    {
        "vimpostor/vim-tpipeline" -- <- Embeds inside of tmux line
    }
}
