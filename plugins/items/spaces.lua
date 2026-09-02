local colors = require("plugins.colors")

sbar.add("event", "aerospace_workspace_change")

-- TODO: add space popup logic with predefind popup items for daemon integration

local spaces = { "1", "2", "3", "4", "A", "S" }

for _, space_id in ipairs(spaces) do
	local space = sbar.add("item", "space." .. space_id, {
		position = "left",
		icon = {
			string = space_id,
			color = colors.highlight,
		},
		label = { drawing = false },
	})

	space:subscribe("aerospace_workspace_change", function(env)
		local is_selected = (env.FOCUSED_WORKSPACE == space_id)

		if is_selected then
			sbar.exec([[/opt/homebrew/bin/aerospace list-windows --focused --format "%{app-name}"]], function(result, _)
				local app_name = result:gsub("\n", "")

				if app_name == "" then
					app_name = "Desktop"
				end

				space:set({
					background = {
						color = colors.highlight,
						corner_radius = 9,
					},
					icon = {
						color = colors.highlight_text,
					},
					label = {
						drawing = true,
						string = app_name,
						color = colors.highlight_text,
					},
				})
			end)
		else
			space:set({
				background = { color = colors.bar_color },
				icon = { color = colors.highlight },
				label = { drawing = false },
			})
		end
	end)
end
