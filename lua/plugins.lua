-- lua/plugins.lua
return {
  -- Plugin Manager (lazy.nvim manages itself)
  { "folke/lazy.nvim", version = "*", lazy = false },

  -- Colorschemes
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function()
      vim.cmd([[colorscheme tokyonight]])    -- Set Tokyonight as the default colorscheme
    end,
  },

  -- File Explorer
  { "kyazdani42/nvim-tree.lua",            -- File tree sidebar (replaces netrw)
    cmd = { "NvimTreeToggle", "NvimTreeRefresh" },
    keys = {
      { "<C-a>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
      { "<C-r>", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file tree" },
    },
    config = function()
      require("nvim-tree").setup({
        hijack_netrw = true,
        view = { width = 30 },
        renderer = { icons = { show = { git = true, folder = true, file = true, folder_arrow = true } } }
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" }  -- Icons for file tree
  },

  -- Which-Key (leader cheat-sheet)
  { "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup({ plugins = { spelling = { enabled = true } } })
  end
},

-- Formatting & lint helpers
{ "stevearc/conform.nvim", event = "BufWritePre", config = false }, -- real config lives in lua/config/format.lua

  -- Fuzzy Finder (files, grep, etc.)
  { "nvim-telescope/telescope.nvim",       -- Telescope finder (fuzzy search for files, text, git, etc.)
    cmd = "Telescope",
    keys = {  -- Lazy-load on these keymaps
      { "<C-p>", function() require("telescope.builtin").find_files() end, desc = "Find Files" },       -- Ctrl-P: open file finder:contentReference[oaicite:13]{index=13}
      { "<C-g>", function() require("telescope.builtin").live_grep() end, desc = "Live Grep" },         -- Ctrl-G: live grep in project:contentReference[oaicite:14]{index=14}
      { "<C-b>", function() require("telescope.builtin").git_branches() end, desc = "Git Branches" },   -- Ctrl-B: list git branches:contentReference[oaicite:15]{index=15}
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = "🔍 ",
          mappings = { i = { ["<Esc>"] = require("telescope.actions").close } }
        }
      })
    end
  },

  -- Dashboard (start screen)
  { "glepnir/dashboard-nvim", event = "VimEnter",
    config = function()
      -- Configure a simple dashboard with custom header and shortcuts
      vim.g.dashboard_default_executive = "telescope"
      vim.g.dashboard_custom_header = {
        "Neovim Configuration (Lua + lazy.nvim)",
        "==================================="
      }
      vim.g.dashboard_custom_section = {
        a = { description = { "  Find File          <C-P>" }, command = "Telescope find_files" },
        b = { description = { "  Live Grep          <C-G>" }, command = "Telescope live_grep" },
        c = { description = { "  Git Branches       <C-B>" }, command = "Telescope git_branches" },
        d = { description = { "  File Explorer      <C-A>" }, command = "NvimTreeToggle" },
        e = { description = { "  Quit Neovim        ,q"   }, command = "qa" },
      }
    end
  },

  -- Statusline and Bufferline
  { "nvim-lualine/lualine.nvim", event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = { theme = "tokyonight", section_separators = "", component_separators = "" },
        extensions = { "nvim-tree", "quickfix" }
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" }  -- for file icons in statusline
  },
  { "akinsho/bufferline.nvim", event = "VeryLazy",
    config = function()
      require("bufferline").setup({
        options = {
          numbers = "none",
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = false,
          show_close_icon = false
        }
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },

  -- Git integration
  { "lewis6991/gitsigns.nvim", event = {"BufReadPre", "BufNewFile"},
    config = function()
      require("gitsigns").setup {
        current_line_blame = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          -- Navigate hunks with ]c/[c
          vim.keymap.set('n', ']c', function() gs.next_hunk() end, { buffer = bufnr, desc="Next hunk" })
          vim.keymap.set('n', '[c', function() gs.prev_hunk() end, { buffer = bufnr, desc="Prev hunk" })
          -- Stage/undo stage hunk
          vim.keymap.set('n', '<Leader>hs', gs.stage_hunk, { buffer = bufnr, desc="Stage hunk" })
          vim.keymap.set('n', '<Leader>hu', gs.undo_stage_hunk, { buffer = bufnr, desc="Undo stage hunk" })
          -- Preview hunk
          vim.keymap.set('n', '<Leader>hp', gs.preview_hunk, { buffer = bufnr, desc="Preview hunk" })
        end
      }
    end
  },

  -- LSP (Language Server Protocol) and related plugins
  { "neovim/nvim-lspconfig",                                      -- Collection of configurations for built-in LSP client
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {
      -- LSP UI enhancements
      { "nvimdev/lspsaga.nvim", config = true },                  -- LSP UIs (hover docs, code actions, rename, diagnostics, and floating terminal)
      -- Automatically install LSP servers (optional, e.g., mason.nvim could be used here)
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Customize diagnostic display (virtual text, signs, etc.)
      vim.diagnostic.config({ virtual_text = false, signs = true, float = { border = "rounded" } })
      -- Show diagnostic popup on hover
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function() vim.diagnostic.open_float(nil, { focusable = false }) end
      })

      -- Common on_attach function for LSP (maps for LSP features)
      local on_attach = function(client, bufnr)
        local bufmap = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end
        bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition")
        bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration")
        bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", "Go to references")
        bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation")
        bufmap("n", "K", "<cmd>Lspsaga hover_doc<CR>", "Hover documentation")     -- Use Lspsaga for hover doc
        bufmap("n", "<Leader>ca", "<cmd>Lspsaga code_action<CR>", "Code Action")  -- Show code actions
        bufmap("n", "<Leader>rn", "<cmd>Lspsaga rename<CR>", "Rename symbol")     -- Rename via Lspsaga
        -- Format on command
        bufmap("n", "<Leader>f", "<cmd>lua vim.lsp.buf.format({ async=true })<CR>", "Format file")
      end

      -- Additional completion capabilities for nvim-cmp:contentReference[oaicite:16]{index=16}
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Enable language servers with the above on_attach and capabilities
      -- Go (gopls)
      if vim.fn.executable("gopls") == 1 then
        lspconfig.gopls.setup({ on_attach = on_attach, capabilities = capabilities })
      end
      -- Python (pyright)
      if vim.fn.executable("pyright") == 1 then
        lspconfig.pyright.setup({ on_attach = on_attach, capabilities = capabilities })
      end
      -- Rust (rust-analyzer)
      if vim.fn.executable("rust-analyzer") == 1 then
        lspconfig.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })
      end
      -- JavaScript/TypeScript (tsserver via typescript-language-server)
      if vim.fn.executable("typescript-language-server") == 1 then
        lspconfig.tsserver.setup({ on_attach = on_attach, capabilities = capabilities })
      end
	  -- C/C++ (clangd)
	  if vim.fn.executable("clangd") == 1 then
		lspconfig.clangd.setup({ on_attach = on_attach, capabilities = capabilities })
	  end
	  -- Nix (nixd)
	  if vim.fn.executable("nixd") == 1 then
		lspconfig.nixd.setup({ on_attach = on_attach, capabilities = capabilities })
	  end

      -- KittyCAD KCL language server (custom, if available):contentReference[oaicite:17]{index=17}:contentReference[oaicite:18]{index=18}
      if vim.fn.executable("kcl-language-server") == 1 then
        -- If not already defined in lspconfig, define it
        local configs = require("lspconfig.configs")
        if not configs.kcl_ls then
          configs.kcl_ls = {
            default_config = {
              cmd = {"kcl-language-server", "server", "--stdio"},
              filetypes = {"kcl"},
              root_dir = lspconfig.util.root_pattern(".git"),
              single_file_support = true
            }
          }
        end
        lspconfig.kcl_ls.setup({ on_attach = on_attach, capabilities = capabilities })
      end
    end
  },

  -- Autocompletion framework and snippet engine
  {
    "petertriho/cmp-git",
    dependencies = { 'hrsh7th/nvim-cmp' },
    opts = {
    filetypes = { "gitcommit" },
    remotes = { "upstream", "origin" }, -- in order of most to least prioritized
    },
},
  { "hrsh7th/nvim-cmp", event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",      -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer",        -- Buffer words completion
      "hrsh7th/cmp-path",          -- File path completion
      "f3fora/cmp-spell",          -- Spell suggestions source
	  "saadparwaiz1/cmp_luasnip",  -- Snippet completions
      "L3MON4D3/LuaSnip",          -- Snippet engine (LuaSnip, replacing vim-vsnip)
      "rafamadriz/friendly-snippets"  -- Collection of snippets for many languages
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
	  require("luasnip.loaders.from_vscode").lazy_load()  -- Load VSCode-style snippets from friendly-snippets

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)    -- Use LuaSnip to expand snippet
          end
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
			['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
			['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" }
        }, {
          { name = "buffer" },
          { name = "spell" }
			{ name = 'git' },
        })
      })
    end
  },

  -- AI Assistant (GitHub Copilot) - using Lua plugin for better integration
  { "zbirenbaum/copilot.lua", cmd = "Copilot", event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { auto_trigger = true, keymap = { accept = "<C-l>" } }
      })
    end
  },

  -- Editing enhancements
  { "kylechui/nvim-surround", event = "VeryLazy", config = true },   -- Surround text objects easily (replaces tpope/vim-surround)
  { "tpope/vim-endwise", ft = { "ruby", "vim", "lua", "bash" } },    -- Automatically add "end" in certain filetypes (Ruby, etc.)
  { "mg979/vim-visual-multi", branch = "master", keys = { "<C-n>", "<C-down>", "<C-up>" } },  -- Multi-cursor editing (Ctrl-N to add cursors)
  { "stevearc/dressing.nvim", event = "VeryLazy", config = true },   -- Better UI for vim.ui (input/select) dialogs
  { "lukas-reineke/indent-blankline.nvim", event = "BufReadPost",
    config = function()
      require("indent_blankline").setup {
        show_trailing_blankline_indent = false,  -- Don't show indent guide on empty lines
        use_treesitter = true,
      }
    end
  },
  { "ntpeters/vim-better-whitespace", event = "BufReadPost",
    config = function()
      vim.g.better_whitespace_enabled = 1   -- Highlight trailing whitespace
      vim.g.strip_whitespace_on_save = 1    -- Strip trailing whitespace on save:contentReference[oaicite:19]{index=19}
	  vim.g.strip_whitespace_confirm=0
      vim.g.better_whitespace_filetypes_blacklist = { "diff", "git", "gitcommit", "markdown", "rust", "qf", "help", "unite" }  -- Don't strip in diff, git commits, markdown (where trailing space is meaningful)
    end
  },

  -- Syntax and Language Support (Tree-sitter and filetype plugins)
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "javascript", "typescript", "tsx", "json", "bash", "yaml", "markdown", "markdown_inline" },
        highlight = { enable = true },
        indent = { enable = true }
      }
    end
  },
}

