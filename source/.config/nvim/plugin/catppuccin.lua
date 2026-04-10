vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})
require("catppuccin").setup({
    flavour = "frappe",
    transparent_background = true,
})
pcall(vim.cmd.colorscheme, "catppuccin")
