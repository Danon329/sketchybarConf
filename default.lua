local colors = require("plugins.colors")

sbar.default({
	padding_left = 5,
	padding_right = 5,
	icon = {
		font = {
			family = "JetBrainsMono Nerd Font",
			style = "Bold",
			size = 16.0,
		},
		color = colors.inactive_text,
		padding_left = 4,
		padding_right = 4,
	},
	label = {
		font = {
			family = "JetBrainsMono Nerd Font",
			style = "Bold",
			size = 14.0,
		},
		color = colors.inactive_text,
		padding_left = 4,
		padding_right = 4,
	},
	popup = {
		background = {
			border_width = 3,
			corner_radius = 9,
			border_color = colors.border,
			color = colors.bar_color,
		},
	},
})
