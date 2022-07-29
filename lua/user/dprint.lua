local h = require("null-ls.helpers")
local cmd_resolver = require("null-ls.helpers.command_resolver")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

return h.make_builtin({
  name = "dprint",
  meta = {
    url = "https://dprint.dev",
    description = "dprint is a command line application that automatically formats code.",
  },
  method = FORMATTING,
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact"
  },
  generator_opts = {
    command = "dprint",
    args = { "fmt", "--stdin", "$FILENAME" },
    dynamic_command = cmd_resolver.from_node_modules,
    to_stdin = true,
  },
  factory = h.formatter_factory,
})
