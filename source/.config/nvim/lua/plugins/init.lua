local plug_path = vim.fn.stdpath("config") .. "/autoload/plug.vim"
if vim.fn.filereadable(plug_path) == 1 then
	vim.cmd.source(plug_path)
else
	vim.api.nvim_err_writeln("vim-plug not found! Expected at: " .. plug_path)
end

local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug("nvim-treesitter/nvim-treesitter")
Plug("catppuccin/nvim", { ["as"] = "catppuccin" })
Plug("nvim-lualine/lualine.nvim", { ["as"] = "lualine" })
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim", { ["tag"] = "0.1.8" })
Plug("nvim-tree/nvim-web-devicons")
Plug("mason-org/mason.nvim", { ["as"] = "mason" })
Plug("mason-org/mason-lspconfig.nvim", { ["as"] = "mason-lspconfig" })
Plug("neovim/nvim-lspconfig")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/nvim-cmp", { ["as"] = "nvim-cmp" })
Plug("willothy/nvim-cokeline", { ["as"] = "cokeline" })
Plug("stevearc/conform.nvim")
Plug("f-person/git-blame.nvim", { ["as"] = "gitblame" })
Plug("nvim-tree/nvim-tree.lua", { ["as"] = "nvim-tree" })
Plug("ludovicchabant/vim-gutentags")
Plug("lewis6991/gitsigns.nvim")
Plug("hrsh7th/cmp-vsnip")
Plug("hrsh7th/vim-vsnip")

vim.call("plug#end")

require("plugins/loader")
require("plugins/mason")
require("plugins/lsp")
require("plugins/nvim-cmp")
require("plugins/cokeline")
require("plugins/conform")
require("plugins/lualine")
require("plugins/git-blame")
require("plugins/nvim-tree")
