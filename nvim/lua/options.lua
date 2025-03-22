Keymap_opts = {
  silent = true,
  noremap = true,
}

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

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
-- Disable hints and warnings globally (including signs and underlines)
vim.diagnostic.config {
  virtual_text = function(namespace, bufnr, diagnostics)
    -- Filter out hints and warnings
    local filtered = vim.tbl_filter(function(diagnostic)
      return diagnostic.severity ~= vim.diagnostic.severity.HINT and diagnostic.severity ~= vim.diagnostic.severity.WARN
    end, diagnostics)
    return #filtered > 0 and filtered or nil
  end,
  signs = function(namespace, bufnr, diagnostics)
    -- Filter out hints and warnings from signs
    local filtered = vim.tbl_filter(function(diagnostic)
      return diagnostic.severity ~= vim.diagnostic.severity.HINT and diagnostic.severity ~= vim.diagnostic.severity.WARN
    end, diagnostics)
    return #filtered > 0 and filtered or nil
  end,
  underline = function(namespace, bufnr, diagnostics)
    -- Filter out hints and warnings from underlines
    local filtered = vim.tbl_filter(function(diagnostic)
      return diagnostic.severity ~= vim.diagnostic.severity.HINT and diagnostic.severity ~= vim.diagnostic.severity.WARN
    end, diagnostics)
    return #filtered > 0 and filtered or nil
  end,
}
-- Disable confirmation prompts
vim.opt.confirm = false

-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`
-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'no'
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 120

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = false

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 1

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = false

-- Enable true color
vim.o.termguicolors = true

vim.o.lazyredraw = false

-- Configure shada to remember cursor positions
vim.o.shada = "'100,<50,s10,h"

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
-- Global settings
vim.opt.tabstop = 2 -- Display tabs as 2 spaces
vim.opt.shiftwidth = 2 -- Use 2 spaces for indentation
vim.opt.softtabstop = 2 -- Make <Tab> behave as 2 spaces
--vim.o.textwidth = 80
vim.o.formatoptions = vim.o.formatoptions .. 't'
--vim.o.expandtab = true

-- show 4 spaces as 2
vim.opt.conceallevel = 2

-- Define a custom highlight group for concealed spaces
vim.api.nvim_set_hl(0, 'Conceal', { bg = 'NONE', fg = 'NONE' })

-- Conceal every 4 spaces and replace them with 2 spaces visually
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'py',
  callback = function()
    vim.opt_local.list = false -- Disable listchars to avoid interference
    vim.opt_local.concealcursor = 'niv' -- Conceal in normal, insert, and visual modes
    vim.fn.matchadd('Conceal', '\\s\\{4}', 10, -1, { conceal = '  ' })
    --   vim.fn.matchadd('Conceal', '\t', 10, -1, { conceal = '  ' })
  end,
})

vim.opt.breakat = '.,?:; '
vim.opt.linebreak = true
vim.opt.wrap = true
