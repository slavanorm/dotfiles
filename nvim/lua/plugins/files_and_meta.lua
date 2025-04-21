local telescope_defaults = {
    --initial_mode = 'normal',
    --border = false,
    layout_strategy = 'flex',
    layout_config = {
        flex = {
            height = 0.95,
            width = 0.95,
            prompt_position = 'top',
            flip_columns = 90,
            flip_lines = 20,
        },
        horizontal = {
            prompt_position = 'top',
            preview_width = 0.6,
            preview_cutoff = 90,
            height = 0.6,
        },
        vertical = {
            prompt_position = 'top',
            preview_cutoff = 20,
            preview_height = 0.5,
        },
    },
    pickers = {
        colorscheme = {
            enable_preview = true,
        },
    },
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
        },
    },
}

return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-telescope/telescope-ui-select.nvim',
            'nvim-tree/nvim-web-devicons',
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
        config = function()
            local t = require 'telescope'
            t.setup { defaults = telescope_defaults }
            pcall(t.load_extension, 'fzf')
            pcall(t.load_extension, 'ui-select')
        end,
    },
    {
        'bkad/CamelCaseMotion',
        config = function()
            vim.cmd [[runtime macros/camelcasemotion.vim]]
        end,
    },
}
