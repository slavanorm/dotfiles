local ignore_list = {
    commands = {
        "EditQuery", "ZenMode", "InspectTree", "Inspect", "UpdateRemotePlugins","KanagawaCompile" },
    plugins = { "Mason", "LspInfo" },
}
local wk_browse_commands = function()
    -- !command browser using wk.
    local wk = require("which-key")
    -- Define the ignore list for commands and plugins
    -- Fetch all available commands
    local commands = vim.api.nvim_get_commands({})

    -- Helper function to filter items based on the ignore list
    local function filter_items(items, ignore)
        local filtered = {}
        for name, _ in pairs(items) do
            if not vim.tbl_contains(ignore, name) then
                filtered[name] = true
            end
        end
        return filtered
    end

    -- Filter commands based on the ignore list
    local filtered_commands = filter_items(commands, ignore_list.commands)

    -- Discover plugins using lazy.nvim
    local function discover_plugins()
        local lazy = require("lazy")
        local plugins = {}

        -- Get the list of all installed plugins
        for _, plugin in ipairs(lazy.plugins()) do
            local plugin_name = plugin.name or plugin[1]
            plugins[plugin_name] = true
        end

        return plugins
    end

    -- Fetch all plugins and filter them based on the ignore list
    local all_plugins = discover_plugins()
    local filtered_plugins = filter_items(all_plugins, ignore_list.plugins)

    -- Helper function to register unique bindings
    local function register_unique_bindings(bindings, base_key)
        local prefix_map = {}

        -- Group bindings by their first letter
        for name, _ in pairs(bindings) do
            local prefix = string.lower(string.sub(name, 1, 1))
            if not prefix_map[prefix] then
                prefix_map[prefix] = {}
            end
            table.insert(prefix_map[prefix], name)
        end

        -- Generate unique keybindings
        local command_bindings = {}
        for prefix, names in pairs(prefix_map) do
            for i, name in ipairs(names) do
                if #names == 1 then
                    table.insert(
                        command_bindings,
                        {
                            base_key .. prefix,
                            ":" .. name .. "<CR>",
                            desc = name,
                            mode = 'n'
                        }
                    )
                else
                    table.insert(
                        command_bindings,
                        {
                            base_key .. prefix .. i,
                            ":" .. name .. "<CR>",
                            desc = name,
                            mode = 'n'
                        }
                    )
                end
            end
        end

        return command_bindings
    end

    -- Register commands
    local command_bindings = register_unique_bindings(filtered_commands, "<leader>C")

    -- Register plugins
    local plugin_bindings = register_unique_bindings(filtered_plugins, "<leader>p")

    -- Combine all bindings
    local all_bindings = vim.tbl_extend("force", command_bindings, plugin_bindings)
    --wk.add()
    -- Register with WhichKey
    wk.add(all_bindings)
end

local telescope_defaults = {
    --initial_mode = 'normal',
    --border = false,
    layout_strategy = 'flex',
    layout_config = {
        flex = {
            height = 0.95,
            width = 0.95,
            prompt_position = 'top',
            flip_columns = 90,
            flip_lines = 20,
        },
        horizontal = {
            prompt_position = 'top',
            preview_width = 0.6,
            preview_cutoff = 90,
            height = 0.6,
        },
        vertical = {
            prompt_position = 'top',
            preview_cutoff = 20,
            preview_height = 0.5,
        },
    },
    pickers = {
        colorscheme = {
            enable_preview = true,
        },
    },
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
        },
    },
}

return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-telescope/telescope-ui-select.nvim',
            'nvim-tree/nvim-web-devicons',
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
        config = function()
            local t = require 'telescope'
            t.setup { defaults = telescope_defaults }
            pcall(t.load_extension, 'fzf')
            pcall(t.load_extension, 'ui-select')
        end,
    },
    {
        'bkad/CamelCaseMotion',
        config = function()
            vim.cmd [[runtime macros/camelcasemotion.vim]]
        end,
    },
    {
        'folke/which-key.nvim',
        opts = {
            spelling = { enabled = false }
        },
        keys = { { "<leader>C", wk_browse_commands, 'allcmds' } }
    },
}
