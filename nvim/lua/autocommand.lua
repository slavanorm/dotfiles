-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Automatically save on buffer leave
vim.api.nvim_create_autocmd('BufLeave', {
  callback = function()
    if vim.bo.modified then
      vim.cmd 'silent! write'
    end
  end,
})

-- Automatically save on quit
vim.api.nvim_create_autocmd('QuitPre', {
  callback = function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[bufnr].modified then
        vim.cmd('silent! buffer ' .. bufnr)
        vim.cmd 'silent! write'
      end
    end
  end,
})

-- Automatically save on focus loss
vim.api.nvim_create_autocmd('FocusLost', {
  callback = function()
    if vim.bo.modified then
      vim.cmd 'silent! write'
    end
  end,
})

-- Autocommand to jump to the last cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

--[[
-- override keymaps on bufenter
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    package.loaded['keymap'] = nil
    require 'keymap'
    vim.opt.spell = false
  end,
})
--]]
