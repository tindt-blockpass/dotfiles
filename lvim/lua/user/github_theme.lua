local M = {}

M.config = function()
  local status_ok, github_theme = pcall(require, 'github-theme')
  if not status_ok then
    return
  end

  github_theme.setup({
    theme_style = 'light_default',
    comment_style = "italic",
  })
end

return M
