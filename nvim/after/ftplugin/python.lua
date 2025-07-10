vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        vim.opt_local.foldmethod = "expr" -- Use treesitter-based folding
        vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
        --vim.opt_local.foldlevel = 1 default foldlevel. is 0

        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true
    end,
})
