local colors = require("plugins.colors")

sbar.bar({
	position = "top",
	height = 32,
	color = colors.bar_color,
	border_color = colors.border,
	border_width = 3,
	corner_radius = 9,
	margin = 10,
	y_offset = 3,
	topmost = "window",
})
