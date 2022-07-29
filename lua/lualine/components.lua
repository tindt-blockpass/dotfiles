vim.api.nvim_set_hl(0, "SLSep", { fg = "#bbc2cf", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLProgress", { fg = "#b668cd", bg = "#32363e" })
vim.api.nvim_set_hl(0, "SLLocation", { fg = "#519fdf", bg = "#32363e" })

local hl_str = function(str, hl)
  return "%#" .. hl .. "#" .. str .. "%*"
end

local colors = require "lvim.core.lualine.colors"
local conditions = require "lvim.core.lualine.conditions"
local components = require "lvim.core.lualine.components"
local C = {}
local M = {}
local icons = require "lualine.icons"
local mode_color = {
  n = "#519fdf",
  i = "#c18a56",
  v = "#b668cd",
  [""] = "#b668cd",
  V = "#b668cd",
  -- c = '#B5CEA8',
  -- c = '#D7BA7D',
  c = "#46a6b2",
  no = "#D16D9E",
  s = "#88b369",
  S = "#c18a56",
  [""] = "#c18a56",
  ic = "#d05c65",
  R = "#D16D9E",
  Rv = "#d05c65",
  cv = "#519fdf",
  ce = "#519fdf",
  r = "#d05c65",
  rm = "#46a6b2",
  ["r?"] = "#46a6b2",
  ["!"] = "#46a6b2",
  t = "#d05c65",
}

local left_pad = {
  function()
    return " "
  end,
  padding = 0,
  color = function()
    return { fg = "#32363e" }
  end,
}

local right_pad = {
  function()
    return " "
  end,
  padding = 0,
  color = function()
    return { fg = "#282C34" }
  end,
}

local left_pad_alt = {
  function()
    return " "
  end,
  padding = 0,
  color = function()
    return { fg = "#32363e" }
  end,
}

local right_pad_alt = {
  function()
    return " "
  end,
  padding = 0,
  color = function()
    return { fg = "#32363e" }
  end,
}

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
    return icons.vertical_bar_thin
  end,
  -- color = { fg = colors.fb, bg = colors.bg },
  separator = { left = "", right = "" },
  cond = nil,
}

C.branch = {
  "b:gitsigns_head",
  icon = " ",
  -- color = { bg = '#d1d4d4',  gui = "bold" },
  separator = { left = icons.left_rounded, right = icons.right_rounded },
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
  separator = { left = "", right = "" },
  cond = nil,
}


C.filename = {
  'filename',
  file_status = true, -- displays file status (readonly status, modified status)
  path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
  shorting_target = 40, -- Shortens path to leave 40 space in the window
  -- function()
  --   local filename = vim.fn.expand "%:t"
  --   local extension = vim.fn.expand "%:e"
  --   local icon = require("nvim-web-devicons").get_icon(filename, extension)
  --   if icon == nil then
  --     icon = ""
  --     return icon
  --   end

  --   return icon .. " " .. filename .. " "
  -- end,
  -- padding = { left = 0, right = 0 },
  -- color = { fg = colors.green, bg = '#292e42' },
  -- separator = { left = "", right = icons.slant_right_2},
  -- separator = icons.slant_right_thin,
  cond = nil,
}

C.relative_path = {
  function()
    local filename = vim.fn.expand "%:t"
    local extension = vim.fn.expand "%:e"
    local relative_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
    local icon = require("nvim-web-devicons").get_icon(filename, extension)
    if icon == nil then
      icon = ""
      return icon
    end

    return icon .. " " .. relative_path .. " "
  end,
  color = { fg = colors.green, bg = 'NONE' },
  separator = { left = "", right = "" },
  cond = nil,
}

C.diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  cond = conditions.hide_in_width,
}

C.filetype = {
  "filetype",
  color = {},
  separator = { "   ", "" },
  cond = conditions.hide_in_width,
  format = function(text)
    return text:upper()
    -- return ' '
  end
}

C.mode = {
  function()
    return " " .. icons.ghost .. " TIN " .. icons.heart_outline .. " "
  end,
  padding = { left = 0, right = 0 },
  color = function()
    -- auto change color according to neovims mode
    return { fg = mode_color[vim.fn.mode()], bg = "#32363e" }
  end,
  -- separator = { left = icons.left_rounded, right = icons.right_rounded },
  cond = nil,
}

C.location = {
  "location",
  fmt = function(str)
    return hl_str(" ", "SLSep") .. hl_str(str, "SLLocation") .. hl_str(" ", "SLSep")
  end,
  padding = 0,
}

C.progress = {
  "progress",
  colors = { fg = colors.fg, bg = '#292e42' },
  fmt = function(str)
    return hl_str("", "SLSep") .. hl_str("%P/%L", "SLProgress") .. hl_str(" ", "SLSep")
  end,
  padding = 0,
}

M.sections = {
  lualine_a = {
    left_pad,
    C.mode,
    right_pad
  },
  lualine_b = {
    C.branch,
  },
  lualine_c = {
    C.diff,
    components.python_env,
  },
  lualine_x = {
    C.relative_path,
    C.diagnostics,
  },
  lualine_y = {
    C.location,
  },
  lualine_z = {
    C.progress,
  },
}

return M
