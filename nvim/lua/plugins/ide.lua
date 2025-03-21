return {
  'lukas-reineke/indent-blankline.nvim',
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
    'kdheepak/lazygit.nvim',
    keys = {
      { '<leader>tl', '<cmd>LazyGit<cr>', desc = '[T] [L]azyGit' },
    },
    {
      'gbprod/yanky.nvim',
      opts = {},
      lazy = false,
    },
  },
}
