vim.opt.spell = false
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

vim.opt.breakindent = true
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 120
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = false

vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = ' ', nbsp = ' ' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 1

vim.opt.confirm = false

vim.o.termguicolors = true
vim.o.lazyredraw = false

vim.o.shada = "'100,<50,s10,h"

-- Global settings
vim.opt.tabstop = 4 -- Display tabs as 3 spaces
vim.opt.shiftwidth = 4 -- Use 2 spaces for indentation
vim.opt.softtabstop = 4 -- Make <Tab> behave as 2 spaces
vim.o.formatoptions = vim.o.formatoptions .. 't'
vim.o.expandtab = true

vim.opt.breakat = '.,?:; '
vim.opt.linebreak = true
vim.opt.wrap = true

-- Disable borders for all floating windows
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'none',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'none',
})

vim.opt.showtabline = 0
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Disable underlines for all highlight groups
for _, group in ipairs(vim.fn.getcompletion('', 'highlight')) do
  vim.api.nvim_set_hl(0, group, { underline = false, bold = true })
end

-- Disable underlines for LSP diagnostics
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { underline = false, bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { underline = false, bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { underline = false, bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { underline = false, bold = true })

-- Allow h and l to wrap across lines
vim.opt.whichwrap:append '<,>,h,l'

-- Allow the cursor to move one character beyond the EOL
--Map('sticky EOL', 'n', '$', 'g_')
--vim.opt.virtualedit = 'onemore'
vim.opt.laststatus = 3
vim.cmd 'colorscheme kanagawa'
vim.opt.statusline = '%t '
-- set to sys python
vim.g.python3_host_prog = 'python3.11' --'/opt/homebrew/bin/python3.11'
-- Set a shorter updatetime for quicker hover response
vim.opt.updatetime = 1000
vim.g.lazyvim_python_lsp = 'pylsp'

vim.o.switchbuf='usetab' 
vim.o.tabpagemax = 20 
