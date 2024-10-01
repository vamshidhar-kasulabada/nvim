local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{
        "stevearc/oil.nvim",
        opts = {},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"nvim-lualine/lualine.nvim",
	},
	"nvim-treesitter/nvim-treesitter",
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	"windwp/nvim-autopairs",
	-- [[telescope]]
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		-- mason
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- neovim native lsp
		"neovim/nvim-lspconfig",
		-- nvim-jdtls for java lsp
		"mfussenegger/nvim-jdtls",
	},
	{
		"mfussenegger/nvim-lint",
	},
	-- [[Code Formating]]
	{
		"mhartington/formatter.nvim",
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	-- [[Code Completion]]
	{
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",

		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",

		"rafamadriz/friendly-snippets",
	}, -- using lazy.nvim
--[[	{
		"S1M0N38/love2d.nvim",
		cmd = "LoveRun",
		opts = {},
		keys = {
			{ "<leader>v", ft = "lua", desc = "LÖVE" },
			{ "<leader>vv", "<cmd>LoveRun<cr>", ft = "lua", desc = "Run LÖVE" },
			{ "<leader>vs", "<cmd>LoveStop<cr>", ft = "lua", desc = "Stop LÖVE" },
		},
	},]]
}

require("lazy").setup(plugins, opts)
