local builtin = require("telescope.builtin")
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files({
		find_command = { "rg", "--ignore", "--hidden", "--files", "--glob", "!**/.git/**" },
	})
end, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>x", ":bd<CR>", opts)
vim.keymap.set("n", "<leader>l", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>h", ":bnext<CR>", opts)
