require("snacks").setup({
	picker = {
		enabled = true,
		sources = {
			files = {
				hidden = true,
				ignored = true,
			},
			grep = {
				hidden = true,
				ignored = true,
				args = {
					"--hidden",
					"--no-ignore",
				},
			},
		},
	},
	explorer = {
		enabled = true,
		files = {
			hidden = true,
			ignored = true,
		},
	},
})
