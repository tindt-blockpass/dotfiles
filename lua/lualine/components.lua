local rosepine = {
  base = '#faf4ed',
  surface = '#fffaf3',
  overlay = '#f2e9e1',
  muted = '#9893a5',
  subtle = '#797593',
  text = '#575279',
  love = '#b4637a',
  gold = '#ea9d34',
  rose = '#d7827e',
  pine = '#286983',
  foam = '#56949f',
  iris = '#907aa9',
  highlight_low = '#f4ede8',
  highlight_med = '#dfdad9',
  highlight_high = '#cecacd',
  none = 'NONE',
}

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
  n = "#56949f",
  i = "#ea9d34",
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
    return { fg = "#f2e9e1" }
  end,
}

local right_pad = {
  function()
    return " "
  end,
  padding = 0,
  color = function()
    return { fg = rosepine.surface }
  end,
}

local left_pad_alt = {
  function()
    return " "
  end,
  padding = 0,
  color = function()
    return { fg = "#f2e9e1" }
  end,
}

local right_pad_alt = {
  function()
    return " "
  end,
  padding = 0,
  color = function()
    return { fg = "#f2e9e1" }
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

local branchRight



C.branch = {
  "b:gitsigns_head",
  -- function()
  --   return vim.b.gitsigns_head .. "%#LualineGitIcon#" .. " " .. "%*"
  -- end,
  icon = "%#LualineGitIcon#" .. " " .. "%*",
  color = { bg = rosepine.surface, gui = "bold" },
  separator = { left = "", right = "" },
  padding = 0,
  cond = conditions.hide_in_width and vim.b.gitsigns_head,
}

C.diff = {
  "diff",
  source = diff_source,
  symbols = { added = "+", modified = "~", removed = "-" },
  diff_color = {
    added = { fg = rosepine.foam },
    modified = { fg = rosepine.gold },
    removed = { fg = rosepine.love },
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
  color = { fg = rosepine.foam },
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
    return icons.ghost .. " TIN " .. icons.heart_outline .. " "
  end,
  padding = { left = 0, right = 1 },
  color = function()
    -- auto change color according to neovims mode
    return { fg = "#fffaf3", bg = "#d7827e" }
  end,
  separator = { left = icons.left_rounded, right = "" },
  cond = nil,
}

C.location = {
  "location",
  fmt = function(str)
    return str
  end,
  color = { fg = rosepine.muted },
  padding = { left = 1, right = 1 }
}

C.progress = {
  "progress",
  color = { fg = rosepine.rose },
  fmt = function(str)
    return "%P/%L"
  end,
  padding = { left = 1, right = 1 }
}

C.divider1 = {
  color = { fg = rosepine.rose },
  function()
    return " " .. icons.rhombus .. " "
  end,
  padding = { left = 1, right = 0 }
}

C.divider2 = {
  color = { fg = rosepine.muted },
  function()
    return " " .. icons.rhombus .. " "
  end,
  padding = { left = 1, right = 0 }
}

M.sections = {
  lualine_a = {
    C.mode,
    C.branch,
    -- right_pad
  },
  lualine_b = {
  },
  lualine_c = {
    C.diff,
    components.python_env,
    function()
      return '%='
    end,
    C.relative_path,
  },
  lualine_x = {
    C.diagnostics,
  },
  lualine_y = {
    C.divider2,
    C.location,
  },
  lualine_z = {
    C.divider1,
    C.progress,
  },
}

return M
