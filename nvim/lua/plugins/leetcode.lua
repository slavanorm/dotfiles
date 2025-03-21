return {
  {
    'slavanorm/leetcode.nvim',
    build = ':TSUpdate html',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
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
      }
    end,
  },
}
