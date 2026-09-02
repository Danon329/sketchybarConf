local icons = require("plugins.icons")
local colors = require("plugins.colors")

local function handle_hover(env, item)
	if env.SENDER == "mouse.entered" then
		item:set({
			icon = {
				color = colors.highlight_text,
			},
			label = {
				color = colors.highlight_text,
				padding_right = 8,
			},
			background = {
				color = colors.highlight,
				corner_radius = 9,
				height = 24,
			},
		})
	elseif env.SENDER == "mouse.exited" then
		item:set({
			icon = { color = colors.highlight },
			label = { color = colors.highlight },
			background = { color = colors.bar_color },
		})
	end
end

local apple_logo = sbar.add("item", {
	padding_right = 15,
	icon = {
		string = icons.apple.apple_icon,
		color = colors.highlight,
	},
	label = {
		drawing = false,
	},
	popup = {},
})

apple_logo:subscribe("mouse.exited.global", function(_)
	apple_logo:set({ popup = { drawing = false } })
end)

apple_logo:subscribe("mouse.clicked", function(_)
	apple_logo:set({
		popup = {
			drawing = "toggle",
		},
	})
end)

local sleep_opt = sbar.add("item", {
	position = "popup." .. apple_logo.name,
	icon = {
		string = icons.apple.sleep_icon,
		color = colors.highlight,
	},
	label = {
		string = "Sleep",
		color = colors.highlight,
	},
	padding_left = 15,
	padding_right = 15,
	y_offset = 1,
})

sleep_opt:subscribe({ "mouse.entered", "mouse.exited" }, function(env)
	handle_hover(env, sleep_opt)
end)

sleep_opt:subscribe("mouse.clicked", function(_)
	sbar.exec("pmset sleepnow")
end)

local restart_opt = sbar.add("item", {
	position = "popup." .. apple_logo.name,
	icon = {
		string = icons.apple.restart_icon,
		color = colors.highlight,
	},
	label = {
		string = "Restart",
		color = colors.highlight,
	},
	padding_left = 15,
	padding_right = 15,
	y_offset = 1,
})

restart_opt:subscribe({ "mouse.entered", "mouse.exited" }, function(env)
	handle_hover(env, restart_opt)
end)

restart_opt:subscribe("mouse.clicked", function(_)
	sbar.exec([[osascript -r 'tell app "System Events" to restart']])
end)

local shutdown_opt = sbar.add("item", {
	position = "popup." .. apple_logo.name,
	icon = {
		string = icons.apple.shutdown_icon,
		color = colors.highlight,
		font = {
			size = 15,
		},
	},
	label = {
		string = "Shutdown",
		color = colors.highlight,
	},
	padding_left = 15,
	padding_right = 15,
	y_offset = 1,
})

shutdown_opt:subscribe({ "mouse.entered", "mouse.exited" }, function(env)
	handle_hover(env, shutdown_opt)
end)

shutdown_opt:subscribe("mouse.clicked", function(_)
	sbar.exec([[osascript -e 'tell app "System Events" to shut down']])
end)
