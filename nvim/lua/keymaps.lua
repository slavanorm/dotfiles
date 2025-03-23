-- [[ Global Keymaps ]]
-- manage Tab
vim.keymap.set('n', '<Tab>', '>>', Keymap_opts)
vim.keymap.set('n', '<S-Tab>', '<<', Keymap_opts)
vim.keymap.set('v', '<Tab>', '>gv', Keymap_opts)
vim.keymap.set('v', '<S-Tab>', '<gv', Keymap_opts)

vim.keymap.set('n', 'K', 'i<cr><Esc>', Keymap_opts)

vim.keymap.set('n', '{', '{zt', { desc = 'jump next and move to top', unpack(Keymap_opts) })
vim.keymap.set('n', '}', '}zt', { desc = 'jump back and move to top', unpack(Keymap_opts) })
vim.keymap.set('n', 'n', 'nzt', { desc = 'Search next and move to top', unpack(Keymap_opts) })
vim.keymap.set('n', 'N', 'Nzt', { desc = 'Search previous and move to top', unpack(Keymap_opts) })

vim.keymap.set('n', '$', 'g_', { desc = 'sticky EOL but it doesnt select space', unpack(Keymap_opts) })

--[[
  todo: not working
vim.api.nvim_set_keymap('n', 'p', 'h"0p', 
	{desc = "paste before cursor", unpack(Keymap_opts)}
)
--]]
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window', unpack(Keymap_opts) })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window', unpack(Keymap_opts) })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window', unpack(Keymap_opts) })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window', unpack(Keymap_opts) })

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

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sN', function()
  builtin.live_grep {
    cwd = vim.fn.stdpath 'config',
    prompt_title = 'grep config',
    sorter = Sort_by_mtime(),
  }
end, { unpack(Keymap_opts), desc = '[S]earch [N]eovim files (grep)' })

vim.keymap.set({ 'n', 'v', 'x' }, 'p', '<Plug>(YankyPutBefore)', { desc = 'always put before', unpack(Keymap_opts) })
vim.keymap.set('n', 'qq', ':qa<CR>', { desc = 'exit on q spam', unpack(Keymap_opts) })
vim.keymap.set('n', 'q', '<Nop>', { desc = 'disable macros rec', unpack(Keymap_opts) })
--vim.keymap.set({ 'n','v', 'x' }, 'p', 'P', {desc='always put before'})
