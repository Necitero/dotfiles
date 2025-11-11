local builtin = require("telescope.builtin")
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files({
		find_command = {
			"rg",
			"--hidden", -- Include hidden files
			"--files", -- List all files
			"--glob",
			"!**/.git/**", -- Exclude .git files (optional since it's in .ignore)
		},
		no_ignore = true,
	})
end, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>x", ":bd<CR>", opts)
vim.keymap.set("n", "<leader>l", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>h", ":bnext<CR>", opts)
vim.keymap.set("n", "Y", '"+yy', { noremap = true, silent = true, desc = "Yank line to system clipboard" })
vim.keymap.set("x", "Y", '"+y', { noremap = true, silent = true, desc = "Yank selection to system clipboard" })
vim.keymap.set("x", "H", "<gv", vim.tbl_extend("force", opts, { desc = "Decrease indent" }))
vim.keymap.set("x", "L", ">gv", vim.tbl_extend("force", opts, { desc = "Increase indent" }))
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "Move selection down" }))
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "Move selection up" }))
vim.keymap.set("n", "<leader>b", ":NvimTreeToggle<CR>", opts)
