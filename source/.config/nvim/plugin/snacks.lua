vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})
require("snacks").setup({
    picker = {
        enabled = true,
        sources = {
            files = {
                hidden = true,
                ignored = true,
                exclude = {
                    "node_modules",
                    ".next",
                    "vendor",
                },
            },
            grep = {
                hidden = true,
                ignored = true,
                args = {
                    "--hidden",
                    "--no-ignore",
                },
                exclude = {
                    "node_modules",
                    ".next",
                    "vendor",
                },
            },
        },
    },
    explorer = {
        enabled = true,
        files = {
            hidden = true,
            ignored = true,
        },
    },
})
