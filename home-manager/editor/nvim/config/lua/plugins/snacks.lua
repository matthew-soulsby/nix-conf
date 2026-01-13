local default_header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]]
local angled_header = [[
       ████ ██████           █████      ██                    
      ███████████             █████                            
      █████████ ███████████████████ ███   ███████████  
     █████████  ███    █████████████ █████ ██████████████  
    █████████ ██████████ █████████ █████ █████ ████ █████  
  ███████████ ███    ███ █████████ █████ █████ ████ █████ 
 ██████  █████████████████████ ████ █████ █████ ████ ██████
]]

return {
    {
        "folke/snacks.nvim",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        priority = 1000,
        lazy = false,
        opts = {
            picker = {
                enabled = true,
            },
            explorer = {
                enabled = true,
            },
            gh = {
                enabled = true,
            },
            lazygit = {
                enabled = true,
                win = {
                    border = "rounded",
                },
            },
            dashboard = {
                enabled = true,
                preset = {
                    header = angled_header,
                    keys = {
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                        { icon = " ", key = "t", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                        { icon = " ", key = "b", desc = "Browse Files", action = ":lua Snacks.dashboard.explorer()" },
                        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                        { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                        { icon = " ", key = "u", desc = "Update Plugins", action = ":Lazy update", enabled = package.loaded.lazy ~= nil },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
                formats = {
                    header = {
                        "%s",
                        align = "center",
                        padding = 100,
                        hl = 'Type',
                    },
                },
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 2 },
                    { section = "startup" },
                },
            },
        },
        keys = {
            -- Picker
            { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<leader>fb", function() Snacks.explorer() end, desc = "File Browser" },
            { "<leader>tb", function() Snacks.picker.buffers() end, desc = "Buffers" },

            -- LSP
            { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
            { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
            { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
            { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },

            -- Lazygit
            { "<leader>og", function() Snacks.lazygit.open() end, desc = "Open Lazygit" },
            { "<leader>ol", function() Snacks.lazygit.log() end, desc = "Open Lazygit (log view)" },
            { "<leader>oL", function() Snacks.lazygit.log_file() end, desc = "Open Lazygit (log view of current file)" },

            -- Github
            { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
            { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
            { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
            { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
        },
    },

    -- 
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
