local root_dir = vim.fn.expand '%:h:p'

local function setup_lsp()
    -- keybindings
    -- note: diagnostics are not exclusive to lsp servers
    -- so these can be global keybindings
    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
            local opts = { buffer = event.buf }

            vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
            vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
            vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

            -- these will be buffer-local keybindings
            -- because they only work if you have an active language server
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
        sources = cmp.config.sources {
            { name = 'buffer' },
            --{ name = 'path' },
            { name = 'snippets' },
            { name = 'nvim_lsp' },
        },
        cmp.mapping.preset.insert {
            -- confirm completion item
            ['<Tab>'] = cmp.mapping.confirm { select = false },

            -- Ctrl + space triggers completion menu
            --['<C-Space>'] = cmp.mapping.complete(),
        },
        -- snippet = {
        --     expand = function(args)
        --         require('luasnip').lsp_expand(args.body)
        --     end,
        -- },
        -- Add a space at the end of the completion item
        formatting = {
            format = function(entry, vim_item)
                vim_item.word = vim_item.word .. ' '
                if vim_item.insertText then
                    vim_item.insertText = vim_item.insertText .. ' '
                end
                return vim_item
            end,
        },
        mapping = {
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.confirm { select = true }
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(' ', true, true, true), 'n', true)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        },
    }
    local c = require 'lspconfig'
    --c.gopls.setup { capabilities = capabilities }
    c.ruff.setup { capabilities = { unpack(capabilities), hoverProvider = false } }
    c.lua_ls.setup { capabilities = capabilities }
    c.pylsp.setup { root_dir = root_dir, capabilities = capabilities }
end



return {
    {
        'neovim/nvim-treesitter',
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = { 'lua', 'python' },
                auto_install = true,
                highlight = {
                    enable = true,
                }
            }
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = { 'nvim-treesitter' },
        opts = { max_lines = 1 },
    },
    {
        'neovim/nvim-lspconfig',
        config = setup_lsp,
        dependencies = {
            {
                'folke/lazydev.nvim',
                ft = 'lua',
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                    { path = '~/.local/share/nvim' },
                    'LazyVim',
                }
            },
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'neovim/nvim-treesitter',
            'L3MON4D3/LuaSnip',
        },
    },
}
