return {
  {
    'slavanorm/leetcode.nvim',
    dir = '~/Py/nvim/leetcode.nvim/',
    dev = true,
    build = ':TSUpdate html',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'folke/snacks.nvim',
    },
    config = function()
      require('leetcode').setup {
        storage = {
          home = os.getenv 'HOME' .. '/.leetcode',
          cache = vim.fn.stdpath 'cache' .. '/leetcode',
        },
        lang = 'python3',
        arg = 'lc',
        plugins = {
          non_standalone = true,
        },
        --console = { open_on_runcode = false },
        dir = 'col',
        keys = { toggle = { 'x' } },
        description = { position = 'bottom', show_stats = false },
      }
    end,
  },
}
