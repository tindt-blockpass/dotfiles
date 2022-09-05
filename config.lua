require("user.autocommands")
local lualine_sections = require('lualine.components').sections

-- general
lvim.log.level = "warn"
lvim.format_on_save = {
  timeout = 2000
}
lvim.colorscheme = "rose-pine"
vim.opt.background = 'light'
vim.opt.wrap = false
vim.opt.relativenumber = true

-- Add custom foldingRange
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
lvim.builtin.which_key.mappings.s.s = { "<cmd>Telescope grep_string<cr>", "Search string under cursor" }
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
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.view.width = 40
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
table.insert(lvim.builtin.cmp.sources, { name = "nvim_lsp_signature_help" })

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.highlight.disable = function(lang, bufnr)
  -- Disable in large file (> 1M chars, even single line), e.g: pdf.worker.min.js
  return lang == "javascript" and vim.fn.wordcount().chars > 500000
end
lvim.builtin.treesitter.rainbow.enable = true

-- Telescope configurations
lvim.builtin.telescope.defaults.layout_config.horizontal.preview_width = function(_, cols, _)
  if cols < 120 then
    return 0
  end
  return math.floor(cols * 0.4)
end


-- Bufferline settings
lvim.builtin.bufferline.options.diagnostics_indicator = function(count, level)
  local icon = level:match("error") and " " or " "
  return " " .. icon .. count
end


-- Lualine
lvim.builtin.lualine.options.theme = 'rose-pine-alt'
lvim.builtin.lualine.sections = lualine_sections
lvim.builtin.lualine.options.globalstatus = true
lvim.builtin.lualine.options.always_divide_middle = true


-- Disable virtual text
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.automatic_configuration.skipped_servers = {
  "angularls",
  "ansiblels",
  "ccls",
  "csharp_ls",
  "cssmodules_ls",
  "denols",
  "ember",
  "emmet_ls",
  "golangci_lint_ls",
  "graphql",
  "jedi_language_server",
  "ltex",
  "ocamlls",
  "phpactor",
  "psalm",
  "pylsp",
  "quick_lint_js",
  "rome",
  "reason_ls",
  "scry",
  "solang",
  "solidity_ls",
  "sorbet",
  "sourcekit",
  "sourcery",
  "spectral",
  "sqlls",
  "sqls",
  "stylelint_lsp",
  "tailwindcss",
  "tflint",
  "svlangserver",
  "verible",
  "vuels",
}
local function attach_navic(client, bufnr)
  vim.g.navic_silence = true
  local status_ok, navic = pcall(require, "nvim-navic")
  if not status_ok then
    return
  end
  navic.attach(client, bufnr)
end

lvim.lsp.on_attach_callback = attach_navic


-- Language linters and formatters
local dprintSource = require "user.dprint"
require("null-ls").register(dprintSource)
local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  {
    exe = "prettierd",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "css" }
  }
}

formatters.setup {
  {
    exe = "prettier",
    filetypes = { "yaml" },
    args = { "--parser", "yaml" }
  }
}

formatters.setup {
  {
    exe = "prettier",
    filetypes = { "html" },
    args = { "--parser", "html" }
  }
}

formatters.setup {
  {
    exe = "prettierd",
    filetypes = { "css" },
    args = { "--parser", "css" }
  }
}

-- linters.setup {
--   {
--     exe = "eslint_d",
--     filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
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

require('lspconfig').rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        allFeatures = true,
        overrideCommand = {
          'cargo', 'clippy', '--workspace', '--message-format=json',
          '--all-targets', '--all-features'
        }
      }
    }
  }
}

-- Plugins
lvim.plugins = {
  {
    "rose-pine/neovim",
    config = function()
      require 'user.rose-pine'.config()
    end,
  },
  {
    "p00f/nvim-ts-rainbow",
    disable = true,
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
  {
    "SmiteshP/nvim-navic",
    config = function()
      require("user.navic")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()

    end
  },
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
    "TimUntersberger/neogit"
  },
  {
    "hrsh7th/cmp-nvim-lsp-signature-help"
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
    'quick-lint/quick-lint-js',
    rtp = 'plugin/vim/quick-lint-js.vim',
    tag = '2.8.0',
    opt = true,
    config = function()
      local nvim_lsp = require('lspconfig')
      nvim_lsp.quick_lint_js.setup {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
      }
    end
  }
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
