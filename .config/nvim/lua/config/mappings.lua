local builtin = require('telescope.builtin')
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>x', ':bd<CR>', opts)
vim.keymap.set('n', '<leader>l', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>h', ':bnext<CR>', opts)
