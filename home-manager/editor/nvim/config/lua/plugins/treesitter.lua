return {
    {
        "nvim-treesitter/nvim-treesitter",
        tag = "v0.10.0",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "astro",
                    "bash",
                    "c",
                    "css",
                    "diff",
                    "go",
                    "gomod",
                    "gowork",
                    "gosum",
                    "graphql",
                    "html",
                    "javascript",
                    "jsdoc",
                    "json",
                    "json5",
                    "lua",
                    "luadoc",
                    "luap",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "regex",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                    "ruby",
                    "zig",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true }
            })
        end
    }
}

