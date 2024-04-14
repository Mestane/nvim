local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local lualine_moonfly = require("lualine.themes.moonfly")

local new_colors = {
	blue = "#65D1FF",
	green = "#3EFFDC",
	violet = "#FF61EF",
	yellow = "#FFDA7B",
	black = "#000000",
	dark = "#1A1A1A",
	purple = "#928EEC",
}

lualine_moonfly.normal.c.bg = new_colors.dark
lualine_moonfly.normal.a.bg = new_colors.blue
lualine_moonfly.insert.a.bg = new_colors.purple
lualine_moonfly.visual.a.bg = new_colors.violet
lualine_moonfly.command = {
	a = {
		gui = "bold",
		bg = new_colors.yellow,
		fg = new_colors.black,
	},
}

lualine.setup({

	options = {
		theme = lualine_moonfly,
		--theme = bubbles_theme,
		component_separators = "|",
		section_separators = { left = "", right = "" },
	},
})
