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

-- Global autocmd for hover
vim.g.auto_hover_enabled = false -- default

vim.api.nvim_create_user_command('ToggleAutoHover', function()
    vim.g.auto_hover_enabled = not vim.g.auto_hover_enabled
    print('Auto-hover ' .. (vim.g.auto_hover_enabled and 'enabled' or 'disabled'))
end, {})

vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    callback = function()
        if not vim.g.auto_hover_enabled then
            return
        end
        local bufnr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_active_clients { bufnr = bufnr }
        for _, client in ipairs(clients) do
            if client.server_capabilities.hoverProvider then
                vim.lsp.buf.hover()
                vim.schedule(function()
                    -- Refocus
                    vim.api.nvim_set_current_win(0)
                end)
                -- exits after first provider returned hover
                return
            end
        end
    end,
})

-- override keymaps on bufenter
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    callback = function()
        package.loaded['keymap'] = nil
        require 'keymap'
    end,
})

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        -- load plugin only when invoked with path
        if #vim.v.argv > 2 and vim.fn.getftype(vim.v.argv[3]) == 'dir' then
                require 'persistence'.load()
                vim.cmd("filetype detect")
        end
    end
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.html",
  callback = function()
    vim.fn["jinja#AdjustFiletype"]()
  end,
})
