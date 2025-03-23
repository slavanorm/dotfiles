--[[
local lspconfig = require 'lspconfig'
lspconfig.ruff.setup {
  init_options = {
    cmd = { 'ruff', 'server', '--config', '~/pyproject.toml' },
  },
}
--]]
function print_table(tbl)
  for key, value in pairs(tbl) do
    print(key, value)
  end
end

require('noice').setup {
  views = {
    cmdline_popup = {
      border = {
        style = 'none', -- No borders
      },
    },
  },
}
require('telescope').setup {
  defaults = {
    border = false, -- Disable borders
    layout_strategy = 'flex',
    layout_config = {
      flex = {
        height = 0.90,
        width = 0.90,
        prompt_position = 'top',
        horizontal = {
          prompt_position = 'top',
          height = 0.60,
          width = 0.90,
          preview_width = 0.65,
          preview_cutoff = 100,
        },
        vertical = {
          prompt_position = 'top',
          height = 0.80,
          width = 0.7,
          preview_cutoff = 55,
        },
      },
    },
  },
}
--[[
-- Disable underlines for all highlight groups
for _, group in ipairs(vim.fn.getcompletion('', 'highlight')) do
  vim.api.nvim_set_hl(0, group, { underline = false })
end
--]]
-- Disable underlines for LSP diagnostics
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { underline = false })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { underline = false })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { underline = false })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { underline = false })
