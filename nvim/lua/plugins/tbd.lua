return {
  --'ThePrimeagen/vim-be-good',
  --"benlubas/wrapping-paper.nvim",
  'folke/flash.nvim',
  {
    -- this is useless for now
    'mfussenegger/nvim-lint',
    event = 'LazyFile',
    opts = {
      linters_by_ft = {
        --python = { 'pylint', 'pyright', 'ruff' },
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    enabled = false,
  },
}
