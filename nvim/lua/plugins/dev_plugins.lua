local lc_dir = vim.fn.expand '~/Py/nvim/'

local function dir_exists(path)
    local f = io.open(path, 'r')
    if f then
        f:close()
        return true
    end
    return false
end

if not dir_exists(lc_dir) then
    vim.notify 'work'
    vim.o.signcolumn ='auto'
    return {
        'harrisoncramer/gitlab.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
            'stevearc/dressing.nvim', --optional
        },
        build = function()
            -- build go lib
            require('gitlab.server').build(true)
        end,
        config = function()
            require('gitlab').setup()
        end
    }
end


return {
    {
        'slavanorm/leetcode.nvim',
        dir = lc_dir .. '/leetcode.nvim/',
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
            vim.opt.statusline = ''
            vim.opt.laststatus = 0


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
                console = { open_on_runcode = false },
                dir = 'col',
                keys = { toggle = { 'x' } },
                description = { position = 'bottom', show_stats = false },
            }
        end,
    },
}
