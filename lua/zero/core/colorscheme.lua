-- Custom catpuccin Theme setup
require("catppuccin").setup({

	-- color_overrides = {
	-- 	mocha = {
	-- 		base = "#1c1c1c",
	-- 		mantle = "#1c1c1c",
	-- 		crust = "#1c1c1c",
	-- 		--mantle = "#242424",
	-- 		--crust = "#474747",
	-- 	},
	-- },
	-- custom_highlights = function(colors)
	--  return {
	--  	Comment = { fg = colors.flamingo },
	--  	TabLineSel = { bg = colors.none },
	--  	CmpBorder = { fg = colors.surface2 },
	--  	Pmenu = { bg = colors.none },
	--  }
	-- end,
	--
	--
	-- -----------------------------------------------------
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	transparent_background = true,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
})

-- local status, _ = pcall(vim.cmd, "colorscheme catppuccin-mocha")
-- if not status then
-- 	print("Colorscheme not found!")
-- 	return
-- end
