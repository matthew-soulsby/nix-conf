return {
    {
        "folke/snacks.nvim",
        opts = {
            picker = {},
            explorer = {},
        },
        keys = {
            { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<leader>fb", function() Snacks.explorer() end, desc = "File Browser" },
            { "<leader>tb", function() Snacks.picker.buffers() end, desc = "Buffers" },

            -- LSP
            { "<leader>gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
            { "<leader>gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
            { "<leader>gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
            { "<leader>gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "snacks.nvim", words = { "Snacks" } },
            },
        },
    },
}
