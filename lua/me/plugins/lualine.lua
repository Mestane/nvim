local function maximize_status()
	return vim.t.maximized and "" or ""
end

local colors = {
	base = "#1e1e2e",
	mantle = "#181825",
	crust = "#11111b",
	surface0 = "#313244",
	surface1 = "#45475a",
	overlay1 = "#7f849c",
	text = "#cdd6f4",
	subtext = "#a6adc8",
	lavender = "#b4befe",
	blue = "#89b4fa",
	sapphire = "#74c7ec",
	sky = "#89dceb",
	teal = "#94e2d5",
	green = "#a6e3a1",
	yellow = "#f9e2af",
	peach = "#fab387",
	red = "#f38ba8",
	pink = "#f5c2e7",
	mauve = "#cba6f7",
}

local mode_map = {
	NORMAL = { icon = "󰋜 NORMAL" },
	INSERT = { icon = "󰏫 INSERT" },
	VISUAL = { icon = "󰒉 VISUAL" },
	["V-LINE"] = { icon = "󰒉 V-LINE" },
	["V-BLOCK"] = { icon = "󰒉 V-BLOCK" },
	REPLACE = { icon = "󰛔 REPLACE" },
	COMMAND = { icon = " COMMAND" },
	TERMINAL = { icon = " TERMINAL" },
}

return {

	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	opts = {
		options = {
			-- theme = "auto",
			component_separators = { left = "", right = "•" },
			section_separators = { left = "", right = "" },
			globalstatus = true,
		},

		sections = {
			----------------------------------------ABC----------------------------------------
			lualine_a = {
				{
					function()
						return ""
					end,
					color = { fg = "bg", gui = "bold" },
				},
				{
					"mode",
					fmt = function(str)
						local m = mode_map[str] or mode_map["NORMAL"]
						return m.icon
					end,
				},

				{
					"lsp_status",
					icon = "󰒍",
					color = { gui = "italic,bold" },

					symbols = {
						spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
						done = "✓",
						separator = " ",
					},
					ignore_lsp = { "null-ls" },
					show_name = true,
				},
			},

			lualine_b = {
				{
					"branch",
					icon = "",
				},

				{
					function()
						local blame = vim.b.gitsigns_blame_line
						return blame and blame.author or ""
					end,
					icon = "",
				},
				"diagnostics",
			},

			lualine_c = {
				{
					"diff",
					symbols = { added = " ", modified = " ", removed = " " },
					-- colored = true,
				},
				{
					"filename",
					path = 0,
					symbols = { modified = "●", readonly = "", unnamed = "󰡯" },
					color = function()
						return vim.bo.modified and { fg = colors.yellow, gui = "bold" }
					end,
				},

				-- {
				--     "windows",
				--     show_filename_only = true,
				--     show_modified_status = true,
				--     disabled_buftypes = { "quickfix", "prompt", "nofile" },
				--     use_mode_colors = false,
				-- },
				--
				{
					"searchcount",
					color = { fg = colors.peach, gui = "italic" },
					icon = { "󰍉", color = { fg = colors.peach } },
				},
			},

			----------------------------------------XZY----------------------------------------
			lualine_x = {
				{
					maximize_status,
					color = { fg = "#89b4fa" },
				},
				{
					"encoding",
					color = { fg = colors.overlay1 },
					fmt = string.upper,
				},
				{
					"fileformat",
					icons_enabled = true,
				},

				{
					"filetype",
					colored = true,
					icon_only = false,

					disabled_filetypes = { "NvimTree" },
				},
			},

			lualine_y = {

				{
					function()
						local curr = vim.fn.line(".")
						local total = vim.fn.line("$")
						return math.floor((curr / total) * 100) .. "%%"
					end,
					icon = "󰈚",
				},
			},

			lualine_z = {
				{
					"location",
					icon = "󰆤",
				},
			},
		},
	},
}
