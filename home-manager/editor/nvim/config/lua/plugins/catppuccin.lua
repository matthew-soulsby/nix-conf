return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "mocha",
            transparent_background = true,
            dim_inactive = {
                enabled = false,
            },
            integrations = {
                noice = true,
                mason = true,
                notify = true
            }
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")

            local colors = require("catppuccin.palettes").get_palette()
            local highlight_groups = {
                GeneralColor = {
                    FloatBorder = { fg = colors.flamingo },
                },
                TelescopeColor = {
                    TelescopeMatching = { fg = colors.flamingo },
                    TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
                },
                NoiceColor = {
                    NoiceCmdlineIcon = { fg = colors.lavender },
                },
                LazyColor = {
                    LazyComment = { fg = colors.flamingo },
                    LazyH2 = { fg = colors.flamingo },
                },
            }

            for _, hlg in pairs(highlight_groups) do
                for hl, col in pairs(hlg) do
                    vim.api.nvim_set_hl(0, hl, col)
                end
            end
        end
    }
}
