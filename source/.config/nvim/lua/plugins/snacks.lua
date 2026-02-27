require("snacks").setup({
	picker = {
		enabled = true,
		sources = {
			files = {
				hidden = true,
				ignored = true,
				exclude = {
					"node_modules",
				},
			},
			grep = {
				hidden = true,
				ignored = true,
				args = {
					"--hidden",
					"--no-ignore",
				},
				exclude = {
					"node_modules",
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
