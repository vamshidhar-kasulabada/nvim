local function time()
	return os.date("%I:%M:%S %a")
end

require("lualine").setup({
	options = {
		icons_enabled = true, -- default
		-- theme = "rose-pine",
		theme = "auto",
		component_separators = "|",
		section_separators = " ",
	},
	sections = {
		lualine_a = { "buffers" },
		--lualine_c = { "hostname" },
		-- lualine_x = { time },
		lualine_y = { "location" },
		lualine_z = { "mode" },
	},
})


