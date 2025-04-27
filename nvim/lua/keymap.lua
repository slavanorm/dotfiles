-- ! for opinionated mapping.

Map('auto[H]over t', 'n', '<leader>th', '<cmd>ToggleAutoHover<CR>')
Map('[z]en [n]arrow', 'n', '<leader>tzn', '<cmd>ZenMode<CR>')
Map('!esc using jk', 'i', 'jk', '<Esc>')

Map('v always multiline', 'v', '<leader>V', 'V')

Map('append1', { 'n', 'v', 'x' }, 'a', 'A')
Map('0->^', { 'n', 'v', 'x' }, '0', '^')

Map('split newline', 'n', 'K', 'i<CR><Esc>')

Map('qq exit', 'n', 'qq', ':qa<CR>')
Map('q macros off', 'n', 'q', '<Nop>')

--Map('I/N modes toggle', { 'n', 'i' }, '<Down>', function() r = vim.api.nvim_get_mode().mode == 'n' and 'i' or '<Esc>' return r end, { expr = true })

Map('[L]aststatus line t', 'n', '<leader>tl', function()
    vim.opt.laststatus = vim.opt.laststatus:get() == 0 and 3 or 0
end)

Map('[z]en [w]ide t', 'n', '<leader>tzw', function()
    vim.opt.number = vim.opt.laststatus:get() == 0
    vim.opt.relativenumber = vim.opt.laststatus:get() == 0
    print('Status ' .. (vim.opt.laststatus:get() == 0 and 'hidden' or 'shown'))
end)

Map('yankless d', { 'n', 'v', 'x' }, 'd', '"_d', { noremap = false })
Map('yankless c', { 'n', 'v', 'x' }, 'c', '"_c', { noremap = false })
Map('yankless x', { 'n', 'v', 'x' }, 'x', '"_x', { noremap = false })

Map('cw fix', 'n', 'cw', '"_ciw')
Map('dw fix', 'n', 'dw', '"_diw')

Map('cwp fix', 'n', 'cwp', '"_ciw<Esc>p')
Map('dwp fix', 'n', 'dwp', '"_diw<Esc>p')

Map('yank and del line', 'n', 'yd', 'yydd')

-- todo: loses
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

-- plugins
Map('W casesensitive', { 'n', 'v' }, 'w', '<Plug>CamelCaseMotion_w')
Map('B casesensitive', { 'n', 'v' }, 'b', '<Plug>CamelCaseMotion_b')
Map('E casesensitive', { 'n', 'v' }, 'e', '<Plug>CamelCaseMotion_e')

Map('[q]uickfixlist', 'n', '<leader>q', vim.diagnostic.setloclist)
