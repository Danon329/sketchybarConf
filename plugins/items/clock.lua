local colors = require("plugins.colors")

local clock = sbar.add("item", {
	position = "right",
	icon = {
		padding_right = 15,
		color = colors.highlight,
		font = {
			size = 14,
		},
	},
	label = {
		width = 45,
		align = "right",
		color = colors.highlight,
	},
	update_freq = 10,
})

local function update()
	local date = os.date("%a. %d %b.")
	local time = os.date("%H:%M")
	clock:set({ icon = date, label = time })
end

clock:subscribe("routine", update)
clock:subscribe("forced", update)
