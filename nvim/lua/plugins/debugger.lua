return {
    {
        'mfussenegger/nvim-dap',
        ft = { 'python' },
        dependencies = {
            {
                'igorlfs/nvim-dap-view',
                opts = {
                    winbar = {
                        sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
                        headers = {
                            breakpoints = "bp",
                            scopes = "sc",
                            exceptions = "ex",
                            watches = "wa",
                            threads = "th",
                            repl = "re",
                            console = "co",
                        },
                    },
                }
            },
            'nvim-neotest/nvim-nio',
            --'leoluz/nvim-dap-go',
            'theHamsta/nvim-dap-virtual-text',
            'mfussenegger/nvim-dap-python',
        },
        config = function()
            local dap = require 'dap'
            require('dap-python').setup '/opt/homebrew/bin/python3.11'
            local ui = require 'dap-view'
            Map('[B]p line dbg', 'n', '<leader>bB', dap.toggle_breakpoint)
            Map('de[b]ug to cursor', 'n', '<leader>gb', dap.run_to_cursor)
            vim.keymap.set('n', '<F1>', dap.continue)
            vim.keymap.set('n', '<F2>', dap.step_into)
            vim.keymap.set('n', '<F3>', dap.step_over)
            vim.keymap.set('n', '<F4>', dap.step_out)
            vim.keymap.set('n', '<F5>', dap.step_back)
            vim.keymap.set('n', '<F12>', dap.restart)

            --[[
            --require('dap-go').setup()
            Map('eval cursor', 'n', '<leader>bE', function()
                ui.eval(nil, { enter = true })
            end)
            --]]
            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                --ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                --ui.close()
            end
        end,
    },
}
