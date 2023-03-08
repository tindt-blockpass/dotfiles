local M = {}
-- local dawn = {
--   base = '#faf4ed',
--   surface = '#fffaf3',
--   overlay = '#f2e9e1',
--   muted = '#9893a5',
--   subtle = '#797593',
--   text = '#575279',
--   love = '#b4637a',
--   gold = '#ea9d34',
--   rose = '#d7827e',
--   pine = '#286983',
--   foam = '#56949f',
--   iris = '#907aa9',
--   highlight_low = '#f4ede8',
--   highlight_med = '#dfdad9',
--   highlight_high = '#cecacd',
--   none = 'NONE',
-- }

M.config = function()
  if lvim.colorscheme == "rose-pine" then
    vim.o.background = 'light'
    local p = require('rose-pine.palette')
    local h = require('rose-pine.util').highlight

    require('rose-pine').setup({
      -- dark_variant = 'main',
      disable_italics = true,
      -- Change specific vim highlight groups
      highlight_groups = {
        h('Variable', { fg = p.text, italic = false }),
        h('Type', { fg = p.foam, italic = false }),
        h('@parameter', { fg = p.iris, italic = false }),
        h('@property', { fg = p.iris, italic = false }),
        h('@variable', { fg = p.text, italic = false }),
        h('@type', { link = 'Type' }),
        h('Comment', { fg = p.muted, italic = true }),
        h('@comment', { link = 'Comment' }),

        Property = { fg = p.iris, italic = false },
        Type = { fg = p.foam, italic = false },
        Variable = { fg = p.text, italic = false },
        Parameter = { fg = p.iris, italic = false },
        Comment = { fg = p.muted, italic = true },

        IndentBlanklineChar = { fg = '#e4dfde' },
        NavicIconsFile = { fg = p.iris, bg = "NONE" },
        NavicIconsModule = { fg = p.iris, bg = "NONE" },
        NavicIconsNamespace = { fg = p.iris, bg = "NONE" },
        NavicIconsPackage = { fg = p.iris, bg = "NONE" },
        NavicIconsClass = { fg = p.gold, bg = "NONE" },
        NavicIconsMethod = { fg = p.iris, bg = "NONE" },
        NavicIconsProperty = { fg = p.foam, bg = "NONE" },
        NavicIconsField = { fg = p.foam, bg = "NONE" },
        NavicIconsConstructor = { fg = p.iris, bg = "NONE" },
        NavicIconsEnum = { fg = p.foam, bg = "NONE" },
        NavicIconsInterface = { fg = p.gold, bg = "NONE" },
        NavicIconsFunction = { fg = p.iris, bg = "NONE" },
        NavicIconsVariable = { fg = p.rose, bg = "NONE" },
        NavicIconsConstant = { fg = p.love, bg = "NONE" },
        NavicIconsString = { fg = p.foam, italic = true, bg = "NONE" },
        NavicIconsNumber = { fg = p.rose, bg = "NONE" },
        NavicIconsBoolean = { fg = p.love, bg = "NONE" },
        NavicIconsArray = { fg = p.rose, bg = "NONE" },
        NavicIconsObject = { fg = p.rose, bg = "NONE" },
        NavicIconsKey = { fg = p.rose, italic = true, bg = "NONE" },
        NavicIconsNull = { fg = p.love, bg = "NONE" },
        NavicIconsEnumMember = { fg = p.rose, bg = "NONE" },
        NavicIconsStruct = { fg = p.iris, bg = "NONE" },
        NavicIconsEvent = { fg = p.iris, bg = "NONE" },
        NavicIconsOperator = { fg = p.subtle, bg = "NONE" },
        NavicIconsTypeParameter = { fg = p.iris, bg = "NONE" },
        NavicText = { fg = p.muted, bg = "NONE" },
        NavicSeparator = { fg = p.text, bg = "NONE" },
        LualineGitIcon = { fg = "#E8AB53", bg = "#fffaf3" }
      }
    })

    vim.cmd('colorscheme rose-pine')
    vim.cmd('set background=light')
    lvim.colorscheme = 'rose-pine'
  end
end

return M
