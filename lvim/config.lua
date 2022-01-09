local B = lvim.builtin
local statusline = require "lualine.components"
local icons = require "lualine.icons"


B.lualine.sections = statusline.sections
B.lualine.options.theme = 'rose-pine'
B.lualine.options.component_separators = { right = icons.vertical_bar_thin, left = icons.vertical_bar_thin }


-- general
lvim.colorscheme = 'rose-pine'
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "rose-pine"
vim.opt.relativenumber = true
vim.opt.wrap = false


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
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

formatters.setup({{
  exe = "prettierd",
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "css" }
}})

formatters.setup({{
  exe = "prettier",
  filetypes = { "yaml" },
  args = {"--parser", "yaml"}
}})

formatters.setup({{
  exe = "prettier",
  filetypes = { "html" },
  args = {"--parser", "html"}
}})

formatters.setup({{
  exe = "prettier",
  filetypes = { "css" },
  args = {"--parser", "css"}
}})

linters.setup({
  {
  exe = "eslint_d",
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact"}
  }
})




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
  {
    'Saecki/crates.nvim',
    ft = { "toml", "rs" },
    requires = { 'nvim-lua/plenary.nvim' }
  },
  {
    'norcalli/nvim-colorizer.lua',
    event = "BufRead",
    ft = {
      "css",
      "scss",
      "sass",
      "javascriptreact",
      "typescriptreact",
      "lua",
    },
    config = function()
      require 'user.colorizer'.config()
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require "user.blankline"
    end,
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
    requires = "kyazdani42/nvim-web-devicons",
  },
  {
    'projekt0n/github-nvim-theme',
    after = 'lualine.nvim',
    config = function()
      require "user.github_theme".config()
    end,
  },
  {
    'booperlv/nvim-gomove'
  },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("user.rust-tool").config()
    end,
    ft = { "rust", "rs" },
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    config = function()
      require("bqf").setup({
        auto_enable = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
        },
        func_map = {
          vsplit = "",
          ptogglemode = "z,",
          stoggleup = "",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        },
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "typescriptreact", "javascriptreact", "html" },
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("user.better_escape").config()
    end,
  }
}


vim.api.nvim_command("autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab")
