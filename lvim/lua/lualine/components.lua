local colors = require "lvim.core.lualine.colors"
local conditions = require "lvim.core.lualine.conditions"
local components = require "lvim.core.lualine.components"
local C = {}
local M = {}
local icons = require "lualine.icons"
local THEME = 'github'

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

C.blank = {
  function()
    return " "
  end,
  color = { fg = colors.fb, bg = colors.bg },
  cond = nil,
}

C.branch = {
  "b:gitsigns_head",
  icon = " ",
  color = { fg = colors.fg, gui = "bold" },
  separator = { left = "", right = icons.right_rounded},
  cond = conditions.hide_in_width,
}

C.diff = {
  "diff",
  source = diff_source,
  symbols = { added = " +", modified = "~", removed = "-" },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.yellow },
    removed = { fg = colors.red },
  },
  color = {},
  separator = { left = "", right = icons.slant_right_2},
  cond = nil,
}


C.filename = {
  function()
    local filename = vim.fn.expand "%:t"
    local extension = vim.fn.expand "%:e"
    local icon = require("nvim-web-devicons").get_icon(filename, extension)
    if icon == nil then
      icon = ""
      return icon
    end

    return icon .. " " .. filename .. " "
  end,
  -- color = { fg = colors.green, bg = '#292e42' },
  separator = { left = "", right = icons.slant_right_2},
  cond = nil,
}

C.filetype = {
  "filetype",
  color = {},
  separator = {"   ", ""},
  cond = conditions.hide_in_width,
  format = function(text)
    return text:upper()
    -- return ' '
  end
}

C.lsp = {
  function(msg)
    msg = msg or "LSP Inactive"
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
      return msg
    end
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    -- add client
    local utils = require "lsp.utils"
    local active_client = utils.get_active_client_by_ft(buf_ft)
    for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" then
        table.insert(buf_client_names, client.name)
      end
    end
    vim.list_extend(buf_client_names, active_client or {})

    -- add formatter
    local formatters = require "lsp.null-ls.formatters"
    local supported_formatters = formatters.list_supported_names(buf_ft)
    vim.list_extend(buf_client_names, supported_formatters)

    -- add linter
    local linters = require "lsp.null-ls.linters"
    local supported_linters = linters.list_supported_names(buf_ft)
    vim.list_extend(buf_client_names, supported_linters)

    return table.concat(buf_client_names, ", ")
  end,
  icon = " ",
  color = {},
  cond = conditions.hide_in_width,
}

C.mode = {
  function()
    return " " .. icons.ghost .. " TIN " .. icons.heart_outline .. " "
  end,
  padding = { left = 0, right = 0 },
  color = {},
  separator = { left = "", right = icons.right_rounded},
  cond = nil,
}

C.location = {
  "location",
  -- colors = { fg = colors.fg, bg = '#292e42' },
  separator = {left = icons.slant_left_2, right = ""},
}

C.progress = {
  "progress",
  -- colors = { fg = colors.fg, bg = '#292e42' },
  separator = {left = icons.left_rounded, right = ""},
}

M.theme = THEME

M.sections = {
  lualine_a = {
    C.mode,
  },
  lualine_b = {
    C.branch,
  },
  lualine_c = {
    C.diff,
    components.python_env,
  },
  lualine_x = {
    C.filename,
    components.diagnostics,
    components.treesitter,
    C.lsp,
    C.location,
  },
  lualine_z = {
    C.progress,
  },
}

return M
