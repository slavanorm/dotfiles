return {
    {
        'folke/zen-mode.nvim',
        opts = {
            window = {
                width = 0.64,
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
                                bg = '#000000',
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
