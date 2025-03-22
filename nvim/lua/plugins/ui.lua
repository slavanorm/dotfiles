return {
  {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        width = 0.62,
        backdrop = 0.5,
        options = {
          signcolumn = 'no',
          number = false,
          relativenumber = false,
          foldcolumn = '0',
          list = false,
        },
      },
      plugins = {
        gitsigns = { enabled = false },
        twilight = { enabled = false },
        options = {
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
      },
    },
    keys = { {
      '<leader>tz',
      '<cmd>ZenMode<cr>',
      desc = '[T]oggle [Z]en',
    } },
  },
  {
    'folke/snacks.nvim',
    ---@type snacks.Config
    opts = {
      indent = { enabled = false },
      spell = { enabled = false },
      image = {
        enabled = true,
        max_width = 16,
        max_height = 30,
        doc = {
          inline = false,
        },
      },
      notifier = {
        enabled = true,
        timeout = 6000,
      },
      quickfile = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
          relative = 'editor',
        },
        snacks_image = {
          relative = 'editor',
          col = -1,
        },
      },
    },
  },
  {
    'rebelot/kanagawa.nvim',
    config = function()
      require('kanagawa').setup {
        undercurl = false,
        underline = false,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = 'none',
              },
            },
          },
        },
      }
      vim.cmd 'colorscheme kanagawa'
    end,
    overrides = function(colors)
      require 'telescope'
  local makeDiagnosticColor = function(color)
    local c = require("kanagawa.lib.color")
    return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
  end
      local theme = colors.theme
      return {
        NormalFloat = { bg = 'none' },
        FloatBorder = { bg = 'none' },
        FloatTitle = { bg = 'none' },
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
    DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
    DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
    DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
    DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
        PmenuThumb = { bg = theme.ui.bg_p2 },
        -- todo: this doesnt work
        TelescopeTitle = { fg = theme.ui.special },
        TelescopeBorder = { fg = false },
        TelescopePromptNormal = { bg = theme.ui.bg_p1 },
        TelescopePromptBorder = { fg = false, bg = theme.ui.bg_p1 },
        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
        TelescopeResultsBorder = { fg = false, bg = theme.ui.bg_m1 },
        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
        TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = false },
      }
    end,
  },
}
