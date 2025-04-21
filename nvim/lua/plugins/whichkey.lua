-- command browser using wk
local keymap_root = "<leader>C" -- location for built results
local wk_ignore_list = {
    "EditQuery", "ZenMode", "InspectTree", "Inspect", "UpdateRemotePlugins", "KanagawaCompile"
}

local function filter_items(items, ignore)
    local filtered = {}
    for name, _ in pairs(items) do
        if not vim.tbl_contains(ignore, name) then
            filtered[name] = true
        end
    end
    return filtered
end
local function map_prefixes(bindings)
    local result = {}

    for name, _ in pairs(bindings) do
        -- Extract capitalized (e.g. "Conform" from "ConformInfo")
        local prefix = name:match("^[A-Z]+[a-z]*")
        if #prefix == 1 then
            goto continue
        end
        local checks = (prefix:sub(2, 2):match("[A-Z]") ~= nil) and (prefix:sub(1, -1):match("[a-z]") ~= nil)
        if checks then
            prefix = prefix:match("^[A-Z]+"):sub(1, -2)
        end
        prefix = prefix:lower()
        local letter = prefix:sub(1, 1)

        if not result[letter] then
            result[letter] = {}
        end
        if not result[letter][prefix] then
            result[letter][prefix] = {}
        end
        table.insert(result[letter][prefix], name)
        ::continue::
    end
    return result
end

local function order_prefixes(bindings)
    local function order(a, b)
        return a:lower() < b:lower()
    end

    for _, prefixes in pairs(bindings) do
        for _, names in pairs(prefixes) do
            table.sort(names, order)
        end
        table.sort(prefixes, order)
    end
end

local function make_bindings(prefix_map)
    local result = {}
    for letter, e in pairs(prefix_map) do
        local i = 0
        for prefix, names in pairs(e) do
            table.insert(result,
                {
                    keymap_root .. letter .. i, group = prefix, desc = prefix
                })
            for j, name in ipairs(names) do
                if i > 9 then
                    j = j + 1
                    i = 0
                end
                table.insert(result,
                    {
                        keymap_root .. letter .. i .. j,
                        ":" .. name .. "<CR>",
                        desc = name,
                        mode = 'n',
                    }
                )
            end
            i = i + 1
        end
    end

    return result
end

local wk_browse_commands = function()
    local wk = require("which-key")
    local c1 = vim.api.nvim_get_commands({})

    local c2 = filter_items(c1, wk_ignore_list)
    local c3 = map_prefixes(c2)
    order_prefixes(c3)
    local c4 = make_bindings(c3)
    wk.add(c4)
end

return {
    {
        'folke/which-key.nvim',
        opts = {
            spelling = { enabled = false }
        },
        keys = { { "<leader>C", wk_browse_commands, 'command binder' } }
    },
}
