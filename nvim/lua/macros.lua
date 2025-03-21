local lspconfig = require 'lspconfig'
--[[
lspconfig.ruff.setup {
  init_options = {
    cmd = { 'ruff', 'server', '--config', '~/pyproject.toml' },
  },
}
--]]
function print_table(tbl)
  for key, value in pairs(tbl) do
    print(key, value)
  end
end

return {}
