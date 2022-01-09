local M = {}

M.config = function()
  if lvim.colorscheme == "rose-pine" then
    vim.g.rose_pine_variant = 'dawn'
    vim.g.rose_pine_disable_italics = true
    vim.cmd('colorscheme rose-pine')
    vim.cmd("hi IndentBlanklineChar guifg=#e4dfde")
    vim.cmd("hi BufferCurrentSign guifg=#d7827e")
  end
end

return M
