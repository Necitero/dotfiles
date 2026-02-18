local opts = { noremap = true, silent = true }

-- Define Leader
vim.g.mapleader = " "

-- Native Functions Remappings
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "<leader>x", ":bd<CR>", opts)
vim.keymap.set("n", "<leader>l", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>h", ":bnext<CR>", opts)
vim.keymap.set("n", "Y", '"+yy', opts, { desc = "Yank line to system clipboard" })
vim.keymap.set("x", "Y", '"+y', opts, { desc = "Yank selection to system clipboard" })
vim.keymap.set("x", "H", "<gv", vim.tbl_extend("force", opts, { desc = "Decrease indent" }))
vim.keymap.set("x", "L", ">gv", vim.tbl_extend("force", opts, { desc = "Increase indent" }))
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "Move selection down" }))
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "Move selection up" }))
vim.keymap.set("n", "<C-a>", vim.lsp.buf.code_action, opts)
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Plugin Mappings
vim.keymap.set("n", "<leader>ff", function()
	require("snacks").picker.files()
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>fg", function()
	require("snacks").picker.grep()
end, { desc = "Find Text" })
vim.keymap.set("x", "<C-s>", ":CodeSnap<CR>", opts)
vim.keymap.set("n", "<leader>b", function()
	require("snacks").explorer({
		hidden = true,
		ignored = true,
		exclude = {
			".git",
			".DS_Store",
		},
	})
end, { desc = "File Explorer" })
