local colors = require("plugins.colors")

sbar.add("event", "aerospace_workspace_change")

local function highlight(env, item)
	if env.SENDER == "mouse.entered" then
		item:set({
			background = {
				color = colors.highlight,
				height = 24,
				corner_radius = 9,
			},
			label = {
				color = colors.highlight_text,
			},
		})
	elseif env.SENDER == "mouse.exited" then
		item:set({
			background = { color = colors.bar_color },
			label = { color = colors.highlight },
		})
	end
end

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

	local back_slot = sbar.add("item", "popup.slot.back", {
		position = "popup." .. space.name,
		label = {
			string = "Back",
			color = colors.highlight,
		},
		drawing = false,
	})

	back_slot:subscribe({ "mouse.entered", "mouse.exited" }, function(env)
		highlight(env, back_slot)
	end)

	back_slot:subscribe("mouse.clicked", function()
		-- TODO: add call to daemon to --navigate-back
	end)

	-- pool of standard popups to be populated by daemon
	for i = 1, 10 do
		local slot = sbar.add("item", "popup.slot." .. i, {
			position = "popup." .. space.name,
			label = { color = colors.highlight },
			drawing = false,
		})

		slot:subscribe({ "mouse.entered", "mouse.exited" }, function(env)
			highlight(env, slot)
		end)

		slot:subscribe("mouse.clicked", function()
			-- TODO: add call to daemon to --call-slot or select slot, let daemon check for children or so
		end)
	end
end
