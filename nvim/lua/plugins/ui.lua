return {
    { "nvim-lualine/lualine.nvim", enabled = false },
   {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        width = 0.6,
        backdrop = 0,
        options = {
          signcolumn = 'no',
          number = false,
          relativenumber = false,
          foldcolumn = '0',
          list = false,
        },
      },
      plugins = {
        gitsigns = { enabled = true },
        twilight = { enabled = false },
        options = {
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
      },
    },
    keys = { {
      '<leader>tzz',
      '<cmd>ZenMode<cr>',
      desc = '[z]en [z] narrow',
    } },
  },
  {
    'folke/snacks.nvim',
    opts = {
      dashboard = {
        preset = {
          keys = {
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
          --header = [[123],[456]],
        },
        width = 40,
        formats = {
          key = function(item)
            return { { '[', hl = 'special' }, { item.key, hl = 'key' }, { ']', hl = 'special' } }
          end,
        },
        sections = {
          { section = 'recent_files', cwd = true, limit = 4, padding = 1 },
          { section = 'projects' },
          { section = 'keys' },
          { section = 'terminal', cmd = 'date +"%H:%M %d.%M %V/51"', padding = 1 },
          { section = 'terminal', hl = 'footer', cmd = 'cbonsai -l -t 0.1 -l -M 10 -b 2' },
          --{ section = 'recent_files', limit = 4, padding = 1 },
        },
      },

      indent = { enabled = false },
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
  {},
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
    end,
    overrides = function(colors)
      require 'telescope'
      local makeDiagnosticColor = function(color)
        local c = require 'kanagawa.lib.color'
        return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
      end
      local theme = colors.theme
      return {
        NormalFloat = { bg = 'none' },
        FloatBorder = { bg = 'none' },
        FloatTitle = { bg = 'none' },
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
        PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
        DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
        DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
        DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
        PmenuThumb = { bg = theme.ui.bg_p2 },
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
