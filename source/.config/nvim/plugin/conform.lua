vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" },
})
local ok, conform = pcall(require, "conform")
if not ok then
    return
end

conform.setup({
    format_on_save = {
        lsp_fallback = true,
        timeout_ms = 1000,
    },
    formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        yaml = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        scss = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
    },
    formatters = {
        stylua = {},
        prettierd = { prefer_local = "node_modules/.bin" },
        prettier = { prefer_local = "node_modules/.bin" },
    },
})
