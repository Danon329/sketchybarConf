local colors = require("plugins.colors")
local icons = require("plugins.icons")

local battery = sbar.add("item", {
	position = "right",
	icon = {
		string = icons.util.battery.empty,
		color = colors.highlight,
	},
	label = {
		color = colors.highlight,
	},
	update_freq = 120,
})

local function battery_update()
	sbar.exec("pmset -g batt", function(batt_info)
		local icon = "!"
		local is_dangerous = false

		local found, _, charge = batt_info:find("(%d+)%%")
		if found then
			charge = tonumber(charge)
		end

		if found and charge > 90 then
			icon = icons.util.battery.full
		elseif found and charge > 60 then
			icon = icons.util.battery.threequarters
		elseif found and charge > 30 then
			icon = icons.util.battery.half
		elseif found and charge > 10 then
			icon = icons.util.battery.quarter
		else
			icon = icons.util.battery.empty
			is_dangerous = true
		end

		if string.find(batt_info, "AC Power") then
			icon = icon .. " " .. icons.util.battery.charging
		end

		battery:set({
			icon = {
				string = icon,
				color = is_dangerous and colors.alert or colors.highlight,
			},
			label = {
				string = charge .. "%",
				color = is_dangerous and colors.alert or colors.highlight,
			},
		})
	end)
end

battery:subscribe({ "routine", "power_source_change", "system_woke" }, battery_update)
