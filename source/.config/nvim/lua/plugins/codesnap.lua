require("codesnap").setup({
	show_line_number = true,
	highlight_color = "#ffffff20",
	show_workspace = true,
	snapshot_config = {
		theme = "candy",
		window = {
			mac_window_bar = false,
			shadow = {
				radius = 20,
				color = "#00000040",
			},
			margin = {
				x = 32,
				y = 32,
			},
			border = {
				width = 1,
				color = "#ffffff30",
			},
			title_config = {
				color = "#ffffff",
				font_family = "Pacifico",
			},
		},
		themes_folders = {},
		fonts_folders = {},
		line_number_color = "#495162",
		command_output_config = {
			prompt = "❯",
			font_family = "NotoSansM Nerd Font Mono",
			prompt_color = "#F78FB3",
			command_color = "#98C379",
			string_arg_color = "#ff0000",
		},
		code_config = {
			font_family = "NotoSansM Nerd Font Mono",
			breadcrumbs = {
				enable = true,
				separator = "/",
				color = "#80848b",
				font_family = "NotoSansM Nerd Font Mono",
			},
		},
		watermark = {
			content = "",
			font_family = "Pacifico",
			color = "#ffffff",
		},
		background = {
			start = {
				x = 0,
				y = 0,
			},
			["end"] = {
				x = "max",
				y = 0,
			},
			stops = {
				{
					position = 0,
					color = "#6bcba5",
				},
				{
					position = 1,
					color = "#caf4c2",
				},
			},
		},
	},
})
