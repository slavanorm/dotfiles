vim.api.nvim_clear_autocmds({ group = "lazyvim_wrap_spell" })
vim.o.signcolumn = "no"
require('treesitter-context').setup {
  enable = false,
}
