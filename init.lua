local util = require "lspconfig/util"

local config = {
  colorscheme = "gruvbox",
  options = {g = {go_metalinter_command = "golangci-lint"}},
  plugins = {
    init = {{"fatih/vim-go"}, {"ellisonleao/gruvbox.nvim"}},
    ["neo-tree"] = function(config)
      config.window.width = 30
      config.filesystem.filtered_items.hide_dotfiles = false

      return config
    end,
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"

      config.sources = {
        null_ls.builtins.formatting.lua_format.with({
          extra_args = {"--tab-width", "2", "--indent-width", "2"}
        }), null_ls.builtins.diagnostics.golangci_lint
      }

      return config
    end
  },
  lsp = {
    ["server-settings"] = {
      gopls = {
        cmd = {"gopls", "serve"},
        filetypes = {"go", "gomod"},
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {gofumpt = true, experimentalWorkspaceModule = true}
        }
      }
    }
  }
}

return config
