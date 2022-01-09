local colors = require "lvim.core.lualine.colors"
local conditions = require "lvim.core.lualine.conditions"
local components = require "lvim.core.lualine.components"
local C = {}
local M = {}
local icons = require "lualine.icons"

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
  separator = { left = "", right = ""},
  cond = nil,
}

C.branch = {
  "b:gitsigns_head",
  icon = " ",
  -- color = { bg = '#d1d4d4',  gui = "bold" },
  separator = { left = icons.left_rounded, right = icons.right_rounded},
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
  'filename',
  file_status = true,  -- displays file status (readonly status, modified status)
  path = 1,            -- 0 = just filename, 1 = relative path, 2 = absolute path
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
    msg = msg or "LS Inactive"
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
      -- TODO: clean up this if statement
      if type(msg) == "boolean" or #msg == 0 then
        return "LS Inactive"
      end
      return msg
    end
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    -- add client
    for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" then
        table.insert(buf_client_names, client.name)
      end
    end

    -- add formatter
    local formatters = require "lvim.lsp.null-ls.formatters"
    local supported_formatters = formatters.list_registered_providers(buf_ft)
    vim.list_extend(buf_client_names, supported_formatters)

    -- add linter
    local linters = require "lvim.lsp.null-ls.linters"
    local supported_linters = linters.list_registered_providers(buf_ft)
    vim.list_extend(buf_client_names, supported_linters)

    return table.concat(buf_client_names, ", ")
  end,
  padding = { left = 1, right = 1},
  -- icons_enabled = false,
  -- separator = icons.slant_right_thin,
  -- separator = {left = icons.left_rounded, right = icons.right_rounded},
  -- color = { gui = "bold", fg = "#000" },
  -- cond = conditions.hide_in_width,
}

C.lsp_progress = {
  function()
    local Lsp = vim.lsp.util.get_progress_messages()[1]
    if Lsp then
      local msg = Lsp.message or ""
      local percentage = Lsp.percentage or 0
      local title = Lsp.title or ""
      local spinners = {
        "",
        "",
        "",
      }

      local success_icon = {
        "",
        "",
        "",
      }

      local ms = vim.loop.hrtime() / 1000000
      local frame = math.floor(ms / 120) % #spinners

      if percentage >= 70 then
        return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
      else
        return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
      end
    end
    return ""
  end,
  padding = { left = 1, right = 1 },
}

C.mode = {
  function()
    return " " .. icons.ghost .. " TIN " .. icons.heart_outline .. " "
  end,
  padding = { left = 0, right = 0 },
  color = {},
  separator = { left = icons.left_rounded, right = icons.right_rounded},
  cond = nil,
}

C.location = {
  "location",
  padding = { left = 1, right = 1 },
  -- colors = { fg = colors.fg, bg = '#292e42' },
  separator = {left = icons.left_rounded, right = ""},
}

C.progress = {
  "progress",
  -- colors = { fg = colors.fg, bg = '#292e42' },
  separator = {left = icons.left_rounded, right = icons.right_rounded},
}

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
    C.relative_path,
    components.diagnostics,
    -- C.lsp,
  },
  lualine_y = {
    C.location,
  },
  lualine_z = {
    C.progress,
  },
}

return M
