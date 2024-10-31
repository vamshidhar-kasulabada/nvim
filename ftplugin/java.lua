local function on_attach()
	local keymap = vim.api.nvim_set_keymap
	local opts = { noremap = true, silent = true }
	keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap("n", "gk", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap("n", "gr", "<Cmd> lua vim.lsp.buf.rename()<CR>", opts)
	keymap("n", "ga", "<Cmd> lua vim.lsp.buf.code_action()<CR>", opts)
	keymap("n", "gH", "<Cmd> lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", {
		desc = "Toggle Inlay Hints",
	})
	keymap("n", "<leader>co", "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = "Organize Imports" })
	keymap("n", "<leader>crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = "Extract Variable" })
	keymap(
		"v",
		"<leader>crv",
		"<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
		{ desc = "Extract Variable" }
	)
	keymap("n", "<leader>crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = "Extract Constant" })
	keymap(
		"v",
		"<leader>crc",
		"<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
		{ desc = "Extract Constant" }
	)
	keymap("v", "<leader>crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = "Extract Method" })
end

--[[
local lombok_path = "/Users/vamshidhar/.local/share/nvim/mason/packages/jdtls/lombok.jar"

local config = {
	cmd = {
		vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls"),
		"-javaagent:" .. lombok_path,
		"-Xbootclasspath/a:" .. lombok_path,
	},
    root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw", "root-dir-java" }, { upward = true })[1]),
    on_attach = on_attach,
}
]]

local home
local workspace_path

local os_type = require("lib.detectOs")

if os_type == "Windows" then
	home = os.getenv("HOMEPATH")
	workspace_path = home .. "\\AppData\\Local\\nvim-data"
else
	home = os.getenv("HOME")
	workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
		"-jar",
		vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_mac",
		"-data",
		workspace_dir,
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
	on_attach = on_attach,

	settings = {
		java = {
			signatureHelp = { enabled = true },
			extendedClientCapabilities = extendedClientCapabilities,
			maven = {
				downloadSources = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all", -- literals, all, none
				},
			},
			format = {
				enabled = true,
			},
		},
	},

	init_options = {
		bundles = {},
	},
}

--on_attach()
require("jdtls").start_or_attach(config)

--formatter
--[[
-- Function to format Java files using clang-format with a specific .clang-format file
local function format_java()
  vim.cmd("%!clang-format --style=file:" .. vim.fn.expand("~/Programming/code_formatting/.clang-format"))
end

-- Command to format Java files
vim.api.nvim_create_user_command('FormatJava', format_java, {buffer = 0})


]]

-- Function to format Java files using the binary
local function format_java()
	local filename = vim.fn.expand("%:p")
	local command = string.format("google-java-format -i -a %s", filename)
	vim.cmd(string.format("silent !%s", command))
	vim.cmd("e") -- Refresh the buffer to show changes
end

-- Create a command in Neovim to format Java files
vim.api.nvim_create_user_command("JavaFormat", format_java, { nargs = 0 })
