vim.api.nvim_clear_autocmds({ group = "lazyvim_wrap_spell" })

require('treesitter-context').setup {
  enable = false,
}
