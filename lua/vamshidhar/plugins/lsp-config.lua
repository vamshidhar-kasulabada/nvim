require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "ts_ls" },
})

local function on_attach()
	local keymap = vim.api.nvim_set_keymap
	local opts = { noremap = true, silent = true }
	keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap("n", "gk", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap("n", "gr", "<Cmd> lua vim.lsp.buf.rename()<CR>", opts)
end

require("lspconfig").pyright.setup({
	on_attach = on_attach,
})

require("lspconfig").lua_ls.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT", -- Love2D uses LuaJIT by default
				path = vim.split(package.path, ";"), -- Set up your Lua path
			},
			diagnostics = {
				globals = { "vim", "love" }, -- Recognize 'vim' and 'love' as global variables
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true, -- Neovim runtime files
					--[vim.fn.expand('$HOME/.luarocks/share/lua/5.1')] = true, -- LuaRocks Lua files for 5.1
					--[vim.fn.expand('$HOME/.luarocks/share/lua/5.3')] = true, -- LuaRocks Lua files for 5.3
					--[vim.fn.expand("$HOME/.bin/love-api/")] = true, -- Path to Love2D API definitions
                    ["/Users/vamshidhar/.bin/love2d/library"] = true,
				},
			},
			telemetry = {
				enable = false, -- Disable telemetry data
			},
		},
	},
})

require("lspconfig").ts_ls.setup({
	on_attach = on_attach,
})

require("lspconfig").clangd.setup({
	on_attach = on_attach,
})

require("lspconfig").cssls.setup({
	on_attach = on_attach,
})

require("lspconfig").angularls.setup({
    on_attach = on_attach,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "eruby", "html", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "vue" },
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
})

