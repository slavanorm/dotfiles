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
}
