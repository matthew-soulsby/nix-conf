return {
    'goolord/alpha-nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local alpha = require 'alpha'
        local dashboard = require 'alpha.themes.dashboard'

        _Gopts = {
            position = 'center',
            hl = 'Type',
            wrap = 'overflow',
        }

        local logo = [[


                                              
       ████ ██████           █████      ██
      ███████████             █████ 
      █████████ ███████████████████ ███   ███████████
     █████████  ███    █████████████ █████ ██████████████
    █████████ ██████████ █████████ █████ █████ ████ █████
  ███████████ ███    ███ █████████ █████ █████ ████ █████
 ██████  █████████████████████ ████ █████ █████ ████ ██████

      ]]

        dashboard.section.header.val = vim.split(logo, '\n')

        dashboard.section.buttons.val = {
            dashboard.button('n', '  New file', ':ene <BAR> startinsert <CR>'),
            dashboard.button('f', '  Find file', ':lua require("snacks").picker.files() <CR>'),
            dashboard.button('t', '  Find text', ':lua require("snacks").picker.grep() <CR>'),
            dashboard.button('b', '  Browse files', ':lua require("snacks").explorer() <CR>'),
            dashboard.button('r', '󰄉  Recent files', ':lua require("snacks").picker.recent() <CR>'),
            dashboard.button('u', '  Update plugins', ':Lazy update<CR>'),
            dashboard.button('p', '  Projects', ':lua require("snacks").picker.projects() <CR>'),
            dashboard.button('q', '󰿅  Quit', ':qa<CR>'),
        }

        vim.api.nvim_create_autocmd('User', {
            pattern = 'LazyVimStarted',
            desc = 'Add Alpha dashboard footer',
            once = true,
            callback = function()
                local stats = require('lazy').stats()
                local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
                dashboard.section.footer.val = { ' ', ' ', ' ', ' Loaded ' ..
                stats.count .. ' plugins  in ' .. ms .. ' ms ' }
                dashboard.section.header.opts.hl = 'DashboardFooter'
                pcall(vim.cmd.AlphaRedraw)
            end,
        })

        dashboard.opts.opts.noautocmd = true
        alpha.setup(dashboard.opts)
    end
}
