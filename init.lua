local config = {
  plugins = {
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
        })
      }

      return config
    end
  }
}

return config
