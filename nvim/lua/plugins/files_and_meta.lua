-- Two important keymaps to use while in Telescope are:
--  - Insert mode: <c-/>
--  - Normal mode: ?
-- This opens a window that shows you all of the keymaps for the current
--  `:help telescope.setup()`
--  :Telescope help_tags

--  Try it with ya*, e.g. yap in normal mode
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
local defaults = {
  --border = false,
  layout_strategy = 'flex',
  layout_config = {
    flex = {
      height = 0.80,
      width = 0.95,
      prompt_position = 'top',
      flip_columns = 80,
    },
    horizontal = {
      prompt_position = 'top',
      height = 0.70,
      width = 0.95,
      preview_width = 40,
      preview_cutoff = 80,
    },
    vertical = {
      prompt_position = 'top',
      height = 0.8,
      width = 0.95,
    },
  },
  initial_mode = 'normal',
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

-- KEYMAPS BELOW

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
      require('telescope').setup {
        defaults = defaults,
      }
      local builtin = require 'telescope.builtin'
      -- Enable Telescope extensions only if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
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
        builtin.live_grep {
          cwd = vim.fn.stdpath 'config',
          prompt_title = 'grep config',
          sorter = Sort_by_mtime(),
        }
      end, { unpack(Keymap_opts), desc = '[S]earch [N]eovim files (grep)' })
      vim.keymap.set('n', '<leader>fl', function()
        require('telescope.builtin').live_grep {
          search_dirs = { vim.fn.stdpath 'data' .. '/lazy' },
        }
      end, { desc = '[S]Grep [L]azy.nvim plugin contents' })
    end,
  },
}
