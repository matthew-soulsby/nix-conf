return {
    "amitds1997/remote-nvim.nvim",
    version = "*", -- Pin to GitHub releases
    dependencies = {
        "nvim-lua/plenary.nvim", -- For standard functions
        "MunifTanjim/nui.nvim", -- To build the plugin UI
        "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    opts = {
        ssh_config = {
            ssh_binary = "ssh",
            scp_binary = "rsync"
        },
        offline_mode = {
            enabled = true,
            no_github = false,
        },
    }
}
