local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local apikeymap = vim.api.nvim_set_keymap

-- Define Leader
vim.g.mapleader = " "

-- Native Functions Remappings
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<leader>x", ":bd<CR>", opts)
keymap("n", "<leader>l", ":bprevious<CR>", opts)
keymap("n", "<leader>h", ":bnext<CR>", opts)
keymap("n", "<Leader>cs", "<cmd>nohlsearch<CR>", { desc = "Clear search" })
keymap("n", "Y", '"+yy', opts, { desc = "Yank line to system clipboard" })
keymap("x", "Y", '"+y', opts, { desc = "Yank selection to system clipboard" })
keymap("x", "H", "<gv", vim.tbl_extend("force", opts, { desc = "Decrease indent" }))
keymap("x", "L", ">gv", vim.tbl_extend("force", opts, { desc = "Increase indent" }))
keymap("x", "J", ":m '>+1<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "Move selection down" }))
keymap("x", "K", ":m '<-2<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "Move selection up" }))
keymap("n", "<C-a>", vim.lsp.buf.code_action, opts)
apikeymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
apikeymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Plugin Mappings
keymap("x", "<C-s>", ":CodeSnap<CR>", opts)
keymap("n", "<leader>ff", function()
	require("snacks").picker.files()
end, { desc = "Find Files" })

keymap("n", "<leader>fg", function()
	require("snacks").picker.grep()
end, { desc = "Find Text" })
keymap("n", "<leader>b", function()
	require("snacks").explorer({
		hidden = true,
		ignored = true,
		exclude = {
			".git",
			".DS_Store",
		},
		layout = {
			layout = {
				position = "right",
			},
		},
	})
end, { desc = "File Explorer" })
