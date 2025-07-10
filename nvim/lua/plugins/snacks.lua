return {
    {
        'folke/snacks.nvim',
        opts = {
            explorer = {
                replace_netrw = false
                -- else it breaks persistence interaction on startup
            },
            picker = {
                formatters = { file = { filename_first = true } },
                sources = {
                    files = { hidden = false, ignored = false },
                    explorer = { tree = true },
                },
                hidden = false,
                ignored = false,
            },
            dashboard = {
                preset = {
                    keys = {
                        { icon = '', key = 'q', desc = '', action = ':qa' },
                    },
                    --header = [[123],[456]],
                },
                width = 48,
                formats = {
                    key = function(item)
                        return { { '[', hl = 'special' }, { item.key, hl = 'key' }, { ']', hl = 'special' } }
                    end,
                },
                sections = {
                    { section = 'recent_files', cwd = true,                        limit = 4,  padding = 1 },
                    { section = 'projects',     padding = 1 },
                    { section = 'keys',         padding = 1 },
                    { section = 'terminal',     cmd = 'date +"%H:%M %d.%M %V/51"', padding = 1 },
                    --{ section = 'terminal', hl = 'footer', cmd = 'cbonsai -l -t 0.1 -l -M 10 -b 2' },
                    --{ section = 'recent_files', limit = 4, padding = 1 },
                },
            },

            indent = { enabled = false },
            image = {
                enabled = true,
                max_width = 16,
                max_height = 30,
                doc = {
                    inline = false,
                },
            },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            quickfile = { enabled = true },
            styles = {
                notification = {
                    wo = { wrap = false }, -- Wrap notifications
                    relative = 'editor',
                },
                snacks_image = {
                    relative = 'editor',
                    col = -1,
                },
            },
        },
    },
}
