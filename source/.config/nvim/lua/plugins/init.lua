vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim", name = "lualine" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/mason-org/mason.nvim", name = "mason" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim", name = "mason-lspconfig" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/hrsh7th/cmp-cmdline" },
	{ src = "https://github.com/hrsh7th/nvim-cmp", name = "nvim-cmp" },
	{ src = "https://github.com/willothy/nvim-cokeline", name = "cokeline" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/f-person/git-blame.nvim", name = "gitblame" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/mistricky/codesnap.nvim" },
	{ src = "https://github.com/norcalli/nvim-colorizer.lua" },
})

require("plugins/mason")
require("plugins/nvim-cmp")
require("plugins/snacks")
require("plugins/cokeline")
require("plugins/conform")
require("plugins/lualine")
require("plugins/git-blame")
require("plugins/codesnap")
require("colorizer").setup()
