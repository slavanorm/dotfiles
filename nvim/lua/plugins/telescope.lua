local telescope_defaults = {
    --initial_mode = 'normal',
    --border = false,
    defaults = {
        ripgrep_arguments = {
            'rg', '--hidden', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'
        }
    },
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
local builtin = require 'telescope.builtin'
Map('BS buffers', 'n', '<BS>', builtin.buffers)
Map('[c]olorscheme', 'n', '<leader>tc', function()
    builtin.colorscheme { enable_preview = true }
end)

vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
Map('[ ] Find existing buffers', 'n', '<leader><leader>', builtin.buffers)
vim.keymap.set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {})
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
    }
end, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>sN', function()
    function Sort_by_mtime()
        return require('telescope.sorters').new {
            scoring_function = function(entry)
                local path = entry.filename
                if not path then
                    return 0
                end

                local stat = vim.loop.fs_stat(path)
                return stat and stat.mtime.sec or 0
            end,
        }
    end

    builtin.live_grep {
        cwd = vim.fn.stdpath 'config',
        prompt_title = 'grep config',
        sorter = Sort_by_mtime(),
    }
end, { unpack(Keymap_opts), desc = '[S]earch [N]eovim files (grep)' })
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
            pcall(t.load_extension, 'git_worktree')
            pcall(t.load_extension, 'fzf')
            pcall(t.load_extension, 'ui-select')
        end,
    }
}
