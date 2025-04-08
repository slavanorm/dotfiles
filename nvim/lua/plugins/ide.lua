local root_dir = vim.fn.expand '%:h:p'

local function x ()
   
end


local function setup_lsp()
  -- note: diagnostics are not exclusive to lsp servers
  -- so these can be global keybindings
  vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
  vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
      local opts = { buffer = event.buf }

      -- these will be buffer-local keybindings
      -- because they only work if you have an active language server
      -- todo: document these? move to keymaps?
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
      vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
      vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
      vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
      vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
      vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
      vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
      vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
  })
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local cmp = require 'cmp'

  cmp.setup {
    sources = {
      { name = 'nvim_lsp' },
    },
    mapping = cmp.mapping.preset.insert {
      -- Enter key confirms completion item
      ['<CR>'] = cmp.mapping.confirm { select = false },

      -- Ctrl + space triggers completion menu
      ['<C-Space>'] = cmp.mapping.complete(),
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
  }
  local c = require 'lspconfig'
  -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ruff_lsp
  --c.ruff.setup { capabilities = capabilities }
  c.lua_ls.setup { capabilities = capabilities }
  c.pylsp.setup { root_dir = root_dir, capabilities = capabilities }
end

return {
   {
'mfussenegger/nvim-dap',
dependencies={
'rcarriga/nvim-dap-ui',
'theHamsta/nvim-dap-virtual-text',
}
   },

   {
    'folke/noice.nvim',
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = 'notify',
          find = 'No information available',
        },
        opts = { skip = true },
      })
    end,
  },
  'hrsh7th/cmp-nvim-lsp',
  'L3MON4D3/LuaSnip',
  {
    'neovim/nvim-lspconfig',
    config = function()
      setup_lsp()
    end,
    dependencies = {
      'folke/lazydev.nvim',
      ft = 'lua',
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = '~/.local/share/nvim' },
        'LazyVim',
      },
      'neovim/nvim-lspconfig',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'neovim/nvim-treesitter',
    },
  },
  {
    'neovim/nvim-treesitter',
    config = function()
      local c = require 'nvim-treesitter'
      c.setup {
        ensure_installed = { 'help', 'lua', 'python' },
        auto_install = true,
        highlight = {
          enable = true,
        },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter' },
    opts = { max_lines = 1 },
  },
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
        python = { 'ruff_fix' },
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
        -- TODO: move to keymaps
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
      signature = { enabled = true },

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
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      keywords = {
        FIX = {
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'fixme' },
        },
        TODO = { alt = { 'todo' } },
      },
      colors = {
        error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
        warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
        info = { 'DiagnosticInfo', '#2563EB' },
        hint = { 'DiagnosticHint', '#10B981' },
        default = { 'Identifier', '#7C3AED' },
        test = { 'Identifier', '#FF00FF' },
      },
      search = {
        command = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
        pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    },
  },
}
