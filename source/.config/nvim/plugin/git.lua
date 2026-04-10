vim.pack.add({
    { src = "https://github.com/f-person/git-blame.nvim", name = "gitblame" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
})
require("gitblame").setup({
    message_template = "  <author> • <summary> (<date>)",
    date_format = "%r",
})
