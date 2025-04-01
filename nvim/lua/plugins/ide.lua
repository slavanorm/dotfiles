return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'stevearc/aerial.nvim',
    opts = {
      layout = {
        default_direction = 'prefer_left',
        max_width = 0.6,
        placement = 'edge',
        autojump = 'true',
      },
      post_jump_cmd = 'normal! zt',
      close_on_select = true,
      show_guides = true,
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<leader>ta', ':AerialToggle<CR>', silent = true, desc = 'aerial' },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { 'ruff_fix', 'black', 'isort' },
        go = { 'gofumpt', 'goimports', 'goimports-reviser', 'golines' },
        sql = { 'sqlfmt' },
      },
    },
    {
      'gbprod/yanky.nvim',
      opts = {
        highlight = { timer = 150 },
      },
      lazy = false,
      keys = {
        {
          '<leader>p',
          function()
            if LazyVim.pick.picker.name == 'telescope' then
              require('telescope').extensions.yank_history.yank_history {}
            else
              vim.cmd [[YankyRingHistory]]
            end
          end,
          mode = { 'n', 'x' },
          desc = 'Open Yank History',
        },
        -- stylua: ignore
        { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
        { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put Before Cursor' },
        { 'p', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put Text Before Cursor' },
        { 'gP', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put Text After Selection' },
        { 'gp', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put Text Before Selection' },
        { '[y', '<Plug>(YankyCycleForward)', desc = 'Cycle Forward Through Yank History' },
        { ']y', '<Plug>(YankyCycleBackward)', desc = 'Cycle Backward Through Yank History' },
        { ']P', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put Indented After Cursor (Linewise)' },
        { '[P', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put Indented Before Cursor (Linewise)' },
        { ']p', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put Indented After Cursor (Linewise)' },
        { '[p', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put Indented Before Cursor (Linewise)' },
        { '>P', '<Plug>(YankyPutIndentAfterShiftRight)', desc = 'Put and Indent Right' },
        { '<P', '<Plug>(YankyPutIndentAfterShiftLeft)', desc = 'Put and Indent Left' },
        { '>p', '<Plug>(YankyPutIndentBeforeShiftRight)', desc = 'Put Before and Indent Right' },
        { '<p', '<Plug>(YankyPutIndentBeforeShiftLeft)', desc = 'Put Before and Indent Left' },
        { '=P', '<Plug>(YankyPutAfterFilter)', desc = 'Put After Applying a Filter' },
        { '=p', '<Plug>(YankyPutBeforeFilter)', desc = 'Put Before Applying a Filter' },
      },
    },
  },
  {
    'saghen/blink.cmp',
    enabled = false,
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {
      snippets = {
        expand = function(snippet, _)
          return LazyVim.cmp.expand(snippet)
        end,
      },
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = false,
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },
      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { 'lsp' },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },

      -- experimental signature help support
      -- signature = { enabled = true },

      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = {},
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      cmdline = {
        enabled = false,
      },

      keymap = {
        preset = 'enter',
        ['<C-y>'] = { 'select_and_accept' },
      },
    },
  },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup {
        providers = {
          pyright = false,
        },
      }
    end,
  },
}
