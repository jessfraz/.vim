-- lua/config/format.lua
-- 𝗔𝘂𝘁𝗼-𝗳𝗼𝗿𝗺𝗮𝘁 𝗼𝗻 𝗦𝗮𝘃𝗲  –  Conform.nvim wraps every tool behind one API
-- https://github.com/stevearc/conform.nvim
require("conform").setup({
  format_on_save = function(buf)
    return true
  end,
  formatters_by_ft = {
    go         = { "goimports", "gofumpt" }, -- fallback chain
    json       = { "jq" },
    lua        = { "stylua" },             -- needs stylua in $PATH
	python     = { "ruff_format", "ruff_fix" },              -- needs ruff in $PATH
    nix        = { "alejandra" },
    markdown   = { "mdformat" },
    rust       = { "rustfmt" },
  },
  -- extra-exe overrides (binary names differ on Nix sometimes):
  formatters = {
    alejandra = { command = "alejandra", args = { "--quiet", "-" } },
  },
})

