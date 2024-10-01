-- Modules in basic folder have nothing to do with lazy.nvim of any other plugins
require("vamshidhar.basic.options")

require("vamshidhar.basic.keymaps")

--require("vamshidhar.basic.autocommands")

-- Lazy should be loaded before any other plugin
require("vamshidhar.lazy")

require("vamshidhar.theme-plugins.catppuccin")

require("vamshidhar.plugins.nvim-treesitter")

require("vamshidhar.plugins.oil")

require("vamshidhar.plugins.lualine")

require("vamshidhar.plugins.nvim-autopairs")


require("vamshidhar.plugins.lsp-config")

require("vamshidhar.plugins.formatter")

require("vamshidhar.plugins.cmp")


