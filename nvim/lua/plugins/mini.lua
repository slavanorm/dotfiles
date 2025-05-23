return {
    {
        'echasnovski/mini.animate',
        enabled = false,
        -- opts = function(_, opts)
        --     opts.scroll = { enable = false }
        -- end,
    },
    {
        'echasnovski/mini.pairs',
        enabled = false,
    },
    {
        'echasnovski/mini.nvim',
        config = function()
            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require('mini.surround').setup()

            -- Simple and easy statusline.
            --  You could remove this setup call if you don't like it,
            --  and try some other statusline plugin
            --local statusline = require 'mini.statusline'
            -- set use_icons to true if you have a Nerd Font
            --statusline.setup { use_icons = false }--vim.g.have_nerd_font }

            -- You can configure sections in the statusline by overriding their
            -- default behavior. For example, here we set the section for
            -- cursor location to LINE:COLUMN
            ---@diagnostic disable-next-line: duplicate-set-field
            -- statusline.section_location = function()
            --   return '' --%2l:%-2v'
            -- end
            require('mini.operators').setup()
            --  - ci'  - [C]hange [I]nside [']quote
            local ai = require 'mini.ai'
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter { -- code block
                        a = { '@block.outer', '@conditional.outer', '@loop.outer' },
                        i = { '@block.inner', '@conditional.inner', '@loop.inner' },
                    },
                    f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' }, -- function
                    c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },       -- class
                    t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },          -- tags
                    d = { '%f[%d]%d+' },                                                         -- digits
                    e = {                                                                        -- Word with case
                        { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
                        '^().*()$',
                    },
                    u = ai.gen_spec.function_call(),                          -- u for "Usage"
                    U = ai.gen_spec.function_call { name_pattern = '[%w_]' }, -- without dot in function name
                },
            }
        end,
    },
}
