vim.api.nvim_set_hl(0, "SLSep", { fg = "#bbc2cf", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLProgress", { fg = "#b668cd", bg = "#32363e" })
vim.api.nvim_set_hl(0, "SLLocation", { fg = "#519fdf", bg = "#32363e" })
vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = "#fffaf3" })

if vim.fn.has "nvim-0.8" == 1 then
  vim.api.nvim_create_autocmd(
    { "CursorMoved", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
    {
      callback = function()
        require("user.winbar").get_winbar()
      end,
    }
  )
end
