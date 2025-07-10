return {
    {
        'bkad/CamelCaseMotion',
        config = function()
            vim.cmd [[runtime macros/camelcasemotion.vim]]
        end,
    },
    {
        'tpope/vim-dadbod',
        dependencies = { "kristijanhusak/vim-dadbod-ui" }
    },
    {
        "andythigpen/nvim-coverage",
        version = "*",
        opts = {
            auto_reload = true,
        },
    },
    {
        'folke/noice.nvim',
        opts = function(_, opts)
            table.insert(opts.routes, {
                filter = {
                    event = 'notify',
                    find = 'No information available',
                },
                opts = { skip = true },
            })
        end,
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        'stevearc/aerial.nvim',
        opts = {
            layout = {
                default_direction = 'prefer_left',
                max_width = 0.6,
                placement = 'edge',
                autojump = 'true',
            },
            post_jump_cmd = 'normal! zt',
            close_on_select = true,
            show_guides = true,
        },
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
        keys = {
            { '<leader>ta', ':AerialToggle<CR>', silent = true, desc = 'aerial' },
        },
    },
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                python = { 'ruff', 'ruff_fix', 'ruff_format', 'ruff_imports' },
                go = { 'gofumpt', 'goimports', 'goimports-reviser', 'golines' },
                sql = { 'sqlfmt' },
            },
        },
    },
    {
        'gbprod/yanky.nvim',
        opts = {
            highlight = { timer = 150 },
        },
        keys = {
            {
                '<leader>p',
                function()
                    if LazyVim.pick.picker.name == 'telescope' then
                        require('telescope').extensions.yank_history.yank_history {}
                    else
                        vim.cmd [[YankyRingHistory]]
                    end
                end,
                mode = { 'n', 'x' },
                desc = 'Open Yank History',
            },
            -- TODO: move to keymaps
            -- stylua: ignore
            { "y",  "<Plug>(YankyYank)",                      mode = { "n", "x" },                           desc = "Yank Text" },
            { 'P',  '<Plug>(YankyPutBefore)',                 mode = { 'n', 'x' },                           desc = 'Put Before Cursor' },
            { 'p',  '<Plug>(YankyPutBefore)',                 mode = { 'n', 'x' },                           desc = 'Put Text Before Cursor' },
            { 'gP', '<Plug>(YankyGPutAfter)',                 mode = { 'n', 'x' },                           desc = 'Put Text After Selection' },
            { 'gp', '<Plug>(YankyGPutBefore)',                mode = { 'n', 'x' },                           desc = 'Put Text Before Selection' },
            { '[y', '<Plug>(YankyCycleForward)',              desc = 'Cycle Forward Through Yank History' },
            { ']y', '<Plug>(YankyCycleBackward)',             desc = 'Cycle Backward Through Yank History' },
            { ']P', '<Plug>(YankyPutIndentAfterLinewise)',    desc = 'Put Indented After Cursor (Linewise)' },
            { '[P', '<Plug>(YankyPutIndentBeforeLinewise)',   desc = 'Put Indented Before Cursor (Linewise)' },
            { ']p', '<Plug>(YankyPutIndentAfterLinewise)',    desc = 'Put Indented After Cursor (Linewise)' },
            { '[p', '<Plug>(YankyPutIndentBeforeLinewise)',   desc = 'Put Indented Before Cursor (Linewise)' },
            { '>P', '<Plug>(YankyPutIndentAfterShiftRight)',  desc = 'Put and Indent Right' },
            { '<P', '<Plug>(YankyPutIndentAfterShiftLeft)',   desc = 'Put and Indent Left' },
            { '>p', '<Plug>(YankyPutIndentBeforeShiftRight)', desc = 'Put Before and Indent Right' },
            { '<p', '<Plug>(YankyPutIndentBeforeShiftLeft)',  desc = 'Put Before and Indent Left' },
            { '=P', '<Plug>(YankyPutAfterFilter)',            desc = 'Put After Applying a Filter' },
            { '=p', '<Plug>(YankyPutBeforeFilter)',           desc = 'Put Before Applying a Filter' },
        },
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            keywords = {
                FIX = {
                    alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'fixme' },
                },
                TODO = { alt = { 'todo' } },
            },
            colors = {
                error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
                warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
                info = { 'DiagnosticInfo', '#2563EB' },
                hint = { 'DiagnosticHint', '#10B981' },
                default = { 'Identifier', '#7C3AED' },
                test = { 'Identifier', '#FF00FF' },
            },
            search = {
                command = 'rg',
                args = {
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                },
                pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
            },
        },
    },
}
