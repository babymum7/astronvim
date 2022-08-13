local ls_util = require("lspconfig/util")

local config = {
  colorscheme = "tokyonight",
  options = {
    opt = { spell = false, spelllang = "en" },
    g = { go_metalinter_command = "golangci-lint" },
  },
  mappings = {
    i = {
      ["<c-c>"] = { "<esc>" },
    },
  },
  plugins = {
    init = {
      { "fatih/vim-go" },
      { "folke/tokyonight.nvim" },
      { "folke/trouble.nvim", require = "kyazdani42/nvim-web-devicons" },
      { "ellisonleao/gruvbox.nvim" },
    },
    ["neo-tree"] = function(config)
      config.window.width = 30
      config.filesystem.filtered_items.hide_dotfiles = false

      return config
    end,
    ["null-ls"] = function(config)
      local null_ls = require("null-ls")

      config.sources = {
        null_ls.builtins.diagnostics.cspell,
        null_ls.builtins.formatting.stylua.with({
          extra_args = { "--indent-width", "2", "--indent-type", "Spaces" },
        }),
        null_ls.builtins.diagnostics.golangci_lint.with({
          args = {
            "run",
            "--fix=false",
            "--fast",
            "--out-format=json",
            "$DIRNAME",
            "--path-prefix",
            "$ROOT",
          },
        }),
      }

      return config
    end,
    treesitter = {
      ensure_installed = { "lua", "go" },
    },
    ["mason-lspconfig"] = {
      ensure_installed = { "sumneko_lua", "gopls" },
    },
    ["mason-tool-installer"] = {
      ensure_installed = { "cspell", "stylua", "golangci-lint" },
    },
  },
  ["which-key"] = {
    register_mappings = {
      n = {
        ["<leader>"] = {
          ["la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "LSP code action" },
          ["lf"] = { "<cmd>lua vim.lsp.buf.formatting_sync()<cr>", "Format code" },
          ["lh"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help" },
          ["lr"] = { "<cmd>lua vin.lsp.buf.rename()<cr>", "Rename current symbol" },
          ["lt"] = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" },
        },
      },
    },
  },
  lsp = {
    mappings = {
      n = {},
    },
    ["server-settings"] = {
      gopls = {
        cmd = { "gopls", "serve" },
        filetypes = { "go", "gomod" },
        root_dir = ls_util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = { gofumpt = true, experimentalWorkspaceModule = true },
        },
      },
    },
  },
}

return config
