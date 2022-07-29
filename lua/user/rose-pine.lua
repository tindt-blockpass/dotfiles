local M = {}

M.config = function()
  if lvim.colorscheme == "rose-pine" then
    require('rose-pine').setup({
      dark_variant = 'main',
      disable_italics = true,
    })

    -- vim.g.rose_pine_variant = 'dawn'
    vim.cmd('colorscheme rose-pine')
    vim.cmd("hi IndentBlanklineChar guifg=#e4dfde")
  end
end

return M
