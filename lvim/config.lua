local B = lvim.builtin
local statusline = require "lualine.components"

-- B.lualine.options.theme = 'ayu_light'
B.lualine.sections = statusline.sections

-- general
lvim.colorscheme = 'rose-pine'
lvim.format_on_save = true
lvim.lint_on_save = true
vim.opt.relativenumber = true
vim.opt.wrap = false
-- vim.opt.background = 'light'

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["Y"] = "y$"
lvim.keys.term_mode["jk"] = "<C-\\><C-n>"

-- Builtins
B.dashboard.active = true
B.terminal.active = true
B.nvimtree.setup.view.side = "right"
B.nvimtree.show_icons.git = 0

-- Treesitter
B.treesitter.ensure_installed = {}
B.treesitter.ignore_install = { "haskell" }
B.treesitter.autotag.enable = true
B.treesitter.highlight.enabled = true
B.treesitter.rainbow.enable = true

-- Whichkey
B.which_key.mappings.s.s = { "<cmd>Telescope grep_string<cr>", "Search string under cursor" }
B.which_key.mappings.l.d = { "<cmd>TroubleToggle<cr>", "Diagnostics" }
B.which_key.mappings.l.R = { "<cmd>TroubleToggle lsp_references<cr>", "References" }
B.which_key.mappings.l.o = { "<cmd>SymbolsOutline<cr>", "Outline" }
B.which_key.mappings['t'] = {
  name = "+Terminal",
  t = { "<cmd>:execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>", "Horizontal" },
  v = { "<cmd>:execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>", "Vertical" },
  n = { "<cmd>:execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>", "New Window" },
}

-- Language linters and formatters
local formatters = require "lvim.lsp.null-ls.formatters"
local linters = require "lvim.lsp.null-ls.linters"

formatters.setup {
  {
    exe = "prettierd",
    filetypes = { "typescript", "typescriptreact" },
  },
}
linters.setup {
  { exe = "eslint_d", filetypes= { "typescript", "typescriptreact"} },
}
vim.list_extend(lvim.lsp.override, { "rust", "tsserver" })
local manager = require("lvim.lsp.manager")
manager.setup("tsserver", {})
manager.setup("rust", {})



-- Additional Plugins
lvim.plugins = {
  {"folke/tokyonight.nvim"},
  {
    "rose-pine/neovim",
    as = "rose-pine",
    config = function ()
      
      if lvim.colorscheme == 'rose-pine' then
        vim.g.rose_pine_variant = 'dawn'
        vim.cmd('colorscheme rose-pine')
        vim.cmd('hi IndentBlanklineChar guifg=#e4dfde')
      end
    end
  },
  {"p00f/nvim-ts-rainbow"},
  { 'Saecki/crates.nvim', requires = { 'nvim-lua/plenary.nvim' } },
  {
    'norcalli/nvim-colorizer.lua',
    event = "BufRead",
    config = function()
      require 'user.colorizer'.config()
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require "user.blankline"
    end
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("user.neoscroll").config()
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("user.outline").config()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    'projekt0n/github-nvim-theme',
    after = 'lualine.nvim',
    config = function()
      require "user.github_theme".config()
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("user.rust-tool").config()
    end,
    ft = { "rust", "rs" },
  },
}

