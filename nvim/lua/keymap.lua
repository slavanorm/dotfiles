-- Keymaps, ordered from opinionated to common sense
function Map(desc, mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  opts.silent = opts.silent == nil and true or opts.silent
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

Map('v always multiline', 'v', '<leader>V', 'V')

Map('append1', { 'n', 'v', 'x' }, 'a', 'A')
Map('append2', { 'n', 'v', 'x' }, 'i', 'a')

Map('N newline', 'n', 'K', 'i<cr><Esc>')

Map('BS 2 lead', 'n', '<BS>', '<leader><leader>')

Map('qq exit', 'n', 'qq', ':qa<CR>')
Map('q macros off', 'n', 'q', '<Nop>')

Map('I/N modes toggle', { 'n', 'i' }, '<Down>', function()
  r = vim.api.nvim_get_mode().mode == 'n' and 'i' or '<Esc>'
  return r
end, { expr = true })
Map('[Line] toggle', 'n', '<leader>tl', function()
  vim.opt.laststatus = vim.opt.laststatus:get() == 0 and 2 or 0
end)

Map('[z]en [w]ide toggle', 'n', '<leader>tzw', function()
  vim.opt.laststatus = vim.opt.laststatus:get() == 0 and 2 or 0
  vim.opt.number = vim.opt.laststatus:get() == 0
  vim.opt.relativenumber = vim.opt.laststatus:get() == 0
  print('Status ' .. (vim.opt.laststatus:get() == 0 and 'hidden' or 'shown'))
end)

-- has some sense
Map('yankless d', { 'n', 'v', 'x' }, 'd', '"_d', { noremap = false })
Map('yankless x', { 'n', 'v', 'x' }, 'x', '"_x', { noremap = false })
Map('Y keeps V', 'v', 'y', 'ygv') -- good since i changed d

Map('tab', 'n', '<Tab>', '>>')
Map('tab', 'v', '<Tab>', '>gv')
Map('Stab', 'n', '<S-Tab>', '<<')
Map('Stab', 'v', '<S-Tab>', '<gv')

Map('Njump and focus', 'n', '{', '{zt')
Map('Bjump and focus', 'n', '}', '}zt')
Map('NSearch and focus', 'n', 'n', 'nzt')
Map('BSearch and focus', 'n', 'N', 'Nzt')

Map('Exit term', 't', '<Esc><Esc>', '<C-\\><C-n>')

-- window management CTRL+<hjkl> , `:help wincmd`
Map('w< focus', 'n', '<C-h>', '<C-w><C-h>')
Map('w> focus', 'n', '<C-l>', '<C-w><C-l>')
Map('wv focus', 'n', '<C-j>', '<C-w><C-j>')
Map('w^ focus', 'n', '<C-k>', '<C-w><C-k>')

-- plugins
Map('W casesensitive', { 'n', 'v' }, 'w', '<Plug>CamelCaseMotion_w')
Map('B casesensitive', { 'n', 'v' }, 'b', '<Plug>CamelCaseMotion_b')
Map('E casesensitive', { 'n', 'v' }, 'e', '<Plug>CamelCaseMotion_e')

-- TODO: not complete
Map('cw fix', 'n', 'cw', 'ciw')
Map('dw fix', 'n', 'dw', 'diw')

Map('cw fix', 'n', 'cwp', 'ciwp')
Map('dw fix', 'n', 'dwp', 'diwp')

Map('[q]uickfixlist', 'n', '<leader>q', vim.diagnostic.setloclist)
Map('[c]olorscheme', { 'n', 'v' }, '<leader>tc', function()
  require('telescope.builtin').colorscheme {
    enable_preview = true, -- Show live preview
  }
end)

local builtin = require 'telescope.builtin'
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
vim.keymap.set('n', '<leader>fl', function()
  require('telescope.builtin').live_grep {
    search_dirs = { vim.fn.stdpath 'data' .. '/lazy' },
  }
end, { desc = '[S]Grep [L]azy.nvim plugin contents' })
