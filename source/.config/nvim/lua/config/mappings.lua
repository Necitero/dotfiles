local builtin = require("telescope.builtin")
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

-- Plugin Mappings
vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files({
		find_command = {
			"rg",
			"--hidden",
			"--files",
			"--glob",
			"!**/.git/**",
			"--glob",
			"!**/node_modules/**",
		},
		no_ignore = true,
	})
end, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", function()
	builtin.live_grep({
		additional_args = function(_)
			return {
				"--hidden",
				"--glob",
				"!**/.git/**",
				"--glob",
				"!**/node_modules/**",
			}
		end,
	})
end, { desc = "Telescope live grep (including hidden files)" })
vim.keymap.set("n", "<leader>b", function()
	local view = require("nvim-tree.view")
	if view.is_visible() then
		vim.cmd("NvimTreeClose")
	else
		vim.cmd("NvimTreeOpen")
		vim.cmd("wincmd o") -- Make current window only (fullscreen)
	end
end, opts)
vim.keymap.set("x", "<C-s>", ":CodeSnap<CR>", opts)
