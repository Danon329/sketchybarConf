local colors = require("plugins.colors")
local icons = require("plugins.icons")

local function highlight(env, item)
	if env.SENDER == "mouse.entered" then
		item:set({
			background = {
				color = colors.highlight,
				height = 24,
				corner_radius = 9,
			},
			icon = {
				color = colors.highlight_text,
			},
			label = {
				color = colors.highlight_text,
			},
		})
	elseif env.SENDER == "mouse.exited" then
		item:set({
			background = { color = colors.bar_color },
			icon = { color = colors.highlight },
			label = { color = colors.highlight },
		})
	end
end

local volume = sbar.add("item", {
	position = "right",
	icon = {
		string = icons.util.volume.high,
		color = colors.highlight,
	},
	popup = {
		align = "center",
	},
})

volume:subscribe("volume_change", function(env)
	local vol = tonumber(env.INFO)
	local icon = icons.util.volume.off
	if vol > 60 then
		icon = icons.util.volume.high
	elseif vol > 25 then
		icon = icons.util.volume.medium
	elseif vol > 0 then
		icon = icons.util.volume.low
	end

	volume:set({ icon = { string = icon } })
end)

volume:subscribe("mouse.exited.global", function(_)
	volume:set({ popup = { drawing = false } })
end)

volume:subscribe("mouse.clicked", function(_)
	volume:set({ popup = { drawing = "toggle" } })
end)

local wifi = sbar.add("item", {
	position = "popup." .. volume.name,
	padding_left = 15,
	padding_right = 15,
	icon = {
		string = icons.util.wifi,
		color = colors.highlight,
	},
	label = {
		string = "WIFI",
		color = colors.highlight,
	},
})

wifi:subscribe({ "mouse.entered", "mouse.exited" }, function(env)
	highlight(env, wifi)
end)

wifi:subscribe("mouse.clicked", function(_)
	sbar.exec("open x-apple.systempreferences:com.apple.wifi-settings-extension")
end)

local bluetooth = sbar.add("item", {
	position = "popup." .. volume.name,
	padding_left = 15,
	padding_right = 15,
	icon = {
		string = icons.util.bluetooth,
		color = colors.highlight,
	},
	label = {
		string = "Bluetooth",
		color = colors.highlight,
	},
})

bluetooth:subscribe({ "mouse.entered", "mouse.exited" }, function(env)
	highlight(env, bluetooth)
end)

bluetooth:subscribe("mouse.clicked", function(_)
	sbar.exec("open x-apple.systempreferences:com.apple.BluetoothSettings")
end)

local screen_share = sbar.add("item", {
	position = "popup." .. volume.name,
	padding_left = 15,
	padding_right = 15,
	icon = {
		string = icons.util.screenshare,
		color = colors.highlight,
	},
	label = {
		string = "Share Screen",
		color = colors.highlight,
	},
})

screen_share:subscribe({ "mouse.entered", "mouse.exited" }, function(env)
	highlight(env, screen_share)
end)

screen_share:subscribe("mouse.clicked", function(_)
	sbar.exec("open x-apple.systempreferences:com.apple.Displays-Settings.extension")
end)
