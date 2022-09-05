local p = {
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

return {
  normal = {
    a = { bg = p.overlay, fg = p.rose, gui = 'bold' },
    b = { bg = p.overlay, fg = p.text },
    c = { bg = p.overlay, fg = p.subtle, gui = 'italic' },
  },
  insert = {
    a = { bg = p.overlay, fg = p.foam, gui = 'bold' },
  },
  visual = {
    a = { bg = p.overlay, fg = p.iris, gui = 'bold' },
  },
  replace = {
    a = { bg = p.overlay, fg = p.pine, gui = 'bold' },
  },
  command = {
    a = { bg = p.overlay, fg = p.love, gui = 'bold' },
  },
  inactive = {
    a = { bg = p.base, fg = p.subtle, gui = 'bold' },
    b = { bg = p.base, fg = p.subtle },
    c = { bg = p.base, fg = p.subtle, gui = 'italic' },
  },
}
