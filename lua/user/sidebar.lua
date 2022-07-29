
local M = {}

M.config = function ()
  local status_ok, sidebar = pcall(require, 'sidebar-nvim')
  if not status_ok then
    return
  end

  sidebar.setup({
    bindings = nil,
    open = false,
    side = "left",
    initial_width = 35,
    update_interval = 1000,
    sections = { "datetime", "git-status", "lsp-diagnostics" },
    section_separator = "-----",
  })
end

return M
