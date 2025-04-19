function print_table(tbl)
    for key, value in pairs(tbl) do
        vim.notify(key, value)
    end
end

function Map(desc, mode, lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = opts.noremap == nil and true or opts.noremap
    opts.silent = opts.silent == nil and true or opts.silent
    opts.desc = desc
    vim.keymap.set(mode, lhs, rhs, opts)
end

