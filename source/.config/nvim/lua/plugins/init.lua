local gh = "https://github.com/"
vim.pack.add({
    { src = gh .. "romus204/tree-sitter-manager.nvim" },
    { src = gh .. "nvim-lua/plenary.nvim" },
    { src = gh .. "catppuccin/nvim",                  name = "catppuccin" },
    { src = gh .. "folke/snacks.nvim" },
    { src = gh .. "nvim-lualine/lualine.nvim",        name = "lualine" },
    { src = gh .. "nvim-tree/nvim-web-devicons" },
    { src = gh .. "mason-org/mason.nvim",             name = "mason" },
    { src = gh .. "mason-org/mason-lspconfig.nvim",   name = "mason-lspconfig" },
    { src = gh .. "neovim/nvim-lspconfig" },
    { src = gh .. "hrsh7th/cmp-nvim-lsp" },
    { src = gh .. "hrsh7th/cmp-buffer" },
    { src = gh .. "hrsh7th/cmp-path" },
    { src = gh .. "hrsh7th/cmp-cmdline" },
    { src = gh .. "hrsh7th/nvim-cmp",                 name = "nvim-cmp" },
    { src = gh .. "willothy/nvim-cokeline",           name = "cokeline" },
    { src = gh .. "stevearc/conform.nvim" },
    { src = gh .. "f-person/git-blame.nvim",          name = "gitblame" },
    { src = gh .. "lewis6991/gitsigns.nvim" },
    { src = gh .. "mistricky/codesnap.nvim" },
})

require("plugins/mason")
require("plugins/nvim-cmp")
require("plugins/snacks")
require("plugins/cokeline")
require("plugins/conform")
require("plugins/lualine")
require("plugins/git-blame")
require("plugins/codesnap")
require("tree-sitter-manager").setup({
    ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "json",
        "bash",
    },
})
