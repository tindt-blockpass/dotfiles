local M = {}

M.config = function()
  local status_ok, lsp_signature = pcall(require, 'lsp_signature')
  if not status_ok then
    return
  end

  lsp_signature.on_attach({
    floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
    fix_pos = true,  -- set to true, the floating window will not auto-close until finish all parameters
    hint_enable = false, -- virtual hint enable
  })
end

return M
