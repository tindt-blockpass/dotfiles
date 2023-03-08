local M = {}

M.config = function()
  local skipped_servers = {
    "angularls",
    "ansiblels",
    "antlersls",
    "ccls",
    "csharp_ls",
    "cssmodules_ls",
    "denols",
    "docker_compose_language_service",
    "ember",
    "emmet_ls",
    "eslint",
    "eslintls",
    "glint",
    "golangci_lint_ls",
    "gradle_ls",
    "graphql",
    "jedi_language_server",
    "ltex",
    "neocmake",
    "ocamlls",
    "phpactor",
    "psalm",
    "pylsp",
    "pyre",
    "quick_lint_js",
    "reason_ls",
    "rnix",
    "rome",
    "ruby_ls",
    "ruff_lsp",
    "scry",
    "solang",
    "solc",
    "solidity_ls",
    "sorbet",
    "sourcekit",
    "sourcery",
    "spectral",
    "sqlls",
    "sqls",
    "stylelint_lsp",
    "svlangserver",
    "tflint",
    "unocss",
    "verible",
    "vuels"
  }

  local skipped_filetypes = { "markdown", "rst", "plaintext", "toml", "proto" }

  lvim.lsp.automatic_configuration.skipped_servers = skipped_servers
  lvim.lsp.automatic_configuration.skipped_filetypes = skipped_filetypes
  lvim.lsp.installer.setup.automatic_installation.exclude = { "tsserver", "glint", "tailwindcss", "jsonls" }
  lvim.lsp.diagnostics.virtual_text = false
end

return M
