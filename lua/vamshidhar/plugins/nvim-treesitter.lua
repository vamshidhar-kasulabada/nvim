require("nvim-treesitter.configs").setup{

    ensure_installed = {"c","javascript", "lua"},

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    --[[ Modules  ]]
    -- Highlight module 
    highlight = {
        enable = true,
        disable = {"text","markdown"},
    }
}

