require("user.autocommands")
require("user.lsp_common_config").config()
local lualine_sections = require('lualine.components').sections

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- vim.o.breakindent = true
vim.o.undofile = true
vim.o.hlsearch = false
vim.o.background = 'light'
vim.opt.wrap = false
vim.opt.relativenumber = true

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>.', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader><leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

-- general
-- lvim.log.level = "warn"
lvim.format_on_save.enabled = true
-- lvim.format_on_save = {
--   timeout = 2000
-- }
lvim.colorscheme = "rose-pine"
lvim.builtin.dap.active = true
lvim.builtin.bufferline.options.indicator_icon = nil
lvim.builtin.bufferline.options.indicator = { style = "icon", icon = "▎" }

-- Add custom foldingRange
-- vim.cmd("set synmaxcol=2048")
vim.wo.foldcolumn = '1'
vim.wo.foldlevel = 99
vim.wo.foldenable = true
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-P>"] = ":Telescope resume<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<cr>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<cr>"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["ds"] = {
  "<cmd>lua if vim.bo.filetype == 'rust' then vim.cmd[[RustDebuggables]] else require'dap'.continue() end<CR>",
  "Start",
}
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>DiffviewFileHistory %<cr>",
  "File history"
}
lvim.builtin.which_key.mappings["dc"] = {
  "<cmd>DiffviewClose<cr>",
  "Close Diffview"
}
lvim.builtin.which_key.mappings.s.s = { "<cmd>Telescope grep_string<cr>", "Search string under cursor" }
lvim.builtin.which_key.mappings.g.y = {
  '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  'Open Git in browser' }
lvim.builtin.which_key.mappings.g.n = {
  '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".copy_to_clipboard})<cr>',
  "Copy Git permalink" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.filters.custom = { "\\.cache" }
lvim.builtin.nvimtree.setup.git.enable = false
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.view.width = 45
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- -- if you don't want all the parsers change this to a table of the ones you want
-- lvim.builtin.treesitter.ensure_installed = {
--   "bash",
--   "c",
--   "javascript",
--   "json",
--   "lua",
--   "python",
--   "typescript",
--   "tsx",
--   "css",
--   "rust",
--   "yaml",
-- }
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.highlight.disable = function(lang, bufnr)
  -- Disable in large file (> 1M chars, even single line), e.g: pdf.worker.min.js
  return lang == "javascript" and vim.fn.wordcount().chars > 500000
end
lvim.builtin.treesitter.rainbow.enable = true

-- Telescope configurations
lvim.builtin.telescope.defaults.file_ignore_patterns = {
  "%.min.js", ".git/", ".cache", "%.zip"
}

-- Bufferline settings
lvim.builtin.bufferline.options.diagnostics_indicator = function(count, level)
  local icon = level:match("error") and " " or " "
  return " " .. icon .. count
end


-- Lualine
lvim.builtin.lualine.style = 'none'
lvim.builtin.lualine.options.theme = 'rose-pine-dawn'
lvim.builtin.lualine.sections = lualine_sections
lvim.builtin.lualine.options.globalstatus = true
lvim.builtin.lualine.options.always_divide_middle = true


-- Language linters and formatters
-- local dprintSource = require "user.dprint"
-- require("null-ls").register(dprintSource)
local formatters = require "lvim.lsp.null-ls.formatters"
local linters = require "lvim.lsp.null-ls.linters"

formatters.setup {
  {
    command = "prettierd",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "css" }
  }
}

-- formatters.setup {
--   {
--     exe = "prettier",
--     filetypes = { "yaml" },
--     args = { "--parser", "yaml" }
--   }
-- }

-- formatters.setup {
--   {
--     exe = "prettier",
--     filetypes = { "html" },
--     args = { "--parser", "html" }
--   }
-- }

-- formatters.setup {
--   {
--     exe = "prettierd",
--     filetypes = { "css" },
--     args = { "--parser", "css" }
--   }
-- }

-- linters.setup {
--   {
--     command = "eslint_d",
--     filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
--     -- args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" }
--   }
-- }

-- linters.setup{
--   {
--     exe = "rust-analyzer",
--     filetypes = { "rust" },
--     settings = {
--       checkOnSave = {
--           allFeatures = true,
--           overrideCommand = {
--               'cargo', 'clippy', '--workspace', '--message-format=json',
--               '--all-targets', '--all-features'
--           }
--       }
--     }
--   }
-- }


-- Plugins
lvim.plugins = {
  {
    "rose-pine/neovim",
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      require 'user.rose-pine'.config()
    end,
  },
  {
    "p00f/nvim-ts-rainbow",
    enabled = false,
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
  -- {
  --   'lukas-reineke/indent-blankline.nvim',
  --   config = function()
  --     require "user.blankline"
  --   end,
  -- },
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
    -- dependencies = "kyazdani42/nvim-web-devicons",
  },
  {
    'booperlv/nvim-gomove'
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    config = function()
      require("user.bqf").config()
    end,
    ft = { "qf" },
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
  },
  {
    'nacro90/numb.nvim',
    config = function()
      require("user.numb").config()
    end,
  },
  {
    'windwp/nvim-spectre',
    config = function()
      require("user.spectre").config()
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup {
        text = {
          spinner = "moon"
        }
      }
    end
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   config = function()

  --   end
  -- },
  {
    "nvim-treesitter/playground",
    config = function()
      require "nvim-treesitter.configs".setup {
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
      }
    end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").load_extension("ui-select")
    end
  },
  {
    "sindrets/diffview.nvim"
  },
  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    dependencies = 'nvim-cmp',
    config = function()
      table.insert(lvim.builtin.cmp.sources, { name = "nvim_lsp_signature_help" })
    end
  },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("user.rust-tools").config()
    end
  },
  {
    'saecki/crates.nvim',
    config = function()
      require('crates').setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end
  },
  {
    "ruifm/gitlinker.nvim",
    event = "BufRead",
    config = function()
      require("gitlinker").setup {
        opts = {
          -- remote = 'github', -- force the use of a specific remote
          -- adds current line nr in the url for normal mode
          add_current_line_on_normal_mode = true,
          -- callback for what to do with the url
          action_callback = require("gitlinker.actions").copy_to_clipboard,
          -- print the url after performing the action
          print_url = true,
          -- mapping to call url generation
          mappings = "<leader>gn",
        },
      }
    end,
    dependencies = "nvim-lua/plenary.nvim",
  },
  {
    "fedepujol/move.nvim",
    event = "BufRead",
    config = function()
      local opts = { noremap = true, silent = true }
      -- Normal-mode commands
      vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)
      vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
      vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
      vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)

      -- Visual-mode commands
      vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
      vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
      vim.keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
      vim.keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)
    end
  },
  -- {
  --   'kevinhwang91/nvim-ufo',
  --   requires = 'kevinhwang91/promise-async',
  --   config = function()
  --     require('ufo').setup()
  --   end,
  --   ft = { "ts", "typescript", "typescriptreact" },
  -- }
  -- {
  --   "mhartington/formatter.nvim",
  --   config = function ()
  --     require("formatter").setup({
  --       filetype = {
  --         javascript = {
  --           function()
  --             return {
  --               exe = "prettierd",
  --               args = {vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
  --               stdin = true
  --             }
  --           end
  --         },
  --       }
  --     })
  --     require("formatter").setup({
  --       filetype = {
  --         javascript = {
  --           function()
  --             return {
  --               exe = "dprint",
  --               args = {"fmt", "--stdin", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
  --               stdin = true
  --             }
  --           end
  --         },
  --       }
  --     })
  --   end
  -- }
}

local function sep_os_replacer(str)
  local result = str
  local path_sep = package.config:sub(1, 1)
  result = result:gsub("/", path_sep)
  return result
end

local join_path = require("lvim.utils").join_paths

local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end
-- if vim.fn.executable "lldb-vscode" == 1 then
dap.adapters.lldbrust = {
  type = "executable",
  attach = { pidProperty = "pid", pidSelect = "ask" },
  command = "lldb-vscode",
  env = { LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES" },
}
dap.adapters.rust = dap.adapters.lldbrust
dap.configurations.rust = {
  {
    type = "rust",
    request = "launch",
    name = "lldbrust",
    program = function()
      local metadata_json = vim.fn.system "cargo metadata --format-version 1 --no-deps"
      local metadata = vim.fn.json_decode(metadata_json)
      local target_name = metadata.packages[1].targets[1].name
      local target_dir = metadata.target_directory
      return target_dir .. "/debug/" .. target_name
    end,
  },
}
-- end
