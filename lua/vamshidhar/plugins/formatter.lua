local util = require("formatter.util")

local clang_format = function()
	return {
		exe = "clang-format",
		args = {
			util.escape_path(util.get_current_buffer_file_name()),
			"-style=file:/Users/vamshidhar/Programming/code_formatting/.clang-format",
		},
		stdin = true,
	}
end

local prettier_format = function()
	return {
		exe = "prettier",
		args = {
			"--stdin-filepath",
			util.escape_path(util.get_current_buffer_file_path()),
			"--tab-width 4",
		},
		stdin = true,
	}
end

require("formatter").setup({
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		java = {
            clang_format
		},
		javascript = {
			prettier_format,
		},
		html = {
			prettier_format,
		},
		css = {
			prettier_format,
		},
		python = {
			require("formatter.filetypes.python").black,
		},
		c = {
			require("formatter.filetypes.c").clangformat,
		},
		cpp = {
			clang_format,
		},
        sh = {
			require("formatter.filetypes.sh").shfmt,
        },
        xml = {
            require("formatter.filetypes.xml").xmlformat,
        },
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})
