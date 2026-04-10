local servers = require("servers")

vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim",           name = "mason" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim", name = "mason-lspconfig" },
})

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

require("mason-lspconfig").setup({
    ensure_installed = servers,
})
