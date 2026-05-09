return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("bufferline").setup({
			options = {
				diagnostics = "nvim_lsp",
				mode = "tabs",
				-- separator_style = "slant" | "slope" | "thick" | "thin" | { "any", "any" },
				-- separator_style = "slant",
				indicator = { style = "underline" },
				-- indicator = { style = "none" },
				-- indicator = { style = "icon", icon = "|" },
				-- indicator = { style = "slope" },
				-- left_trunc_marker = " ",
				-- right_trunc_marker = " ",
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						padding = 1,
					},
				},
				tab_size = 18,
				separator_style = { "", "" },
				show_buffer_close_icons = false,
				show_close_icon = false,
				always_show_bufferline = true,
			},
			highlights = {
				fill = { bg = "#131317" },
				background = { bg = "#131317" },
				-- buffer_selected = { bg = "#2a2a35" }, -- seçili tab rengi
				-- fill = { bg = "#101014" },
				-- background = { bg = "#101014" },
				-- separator = { fg = "#131317", bg = "#131317" },
				-- separator_selected = { fg = "#131317" },
				-- separator_visible = { fg = "#131317" },
				--
				error = { fg = "#B6687E", sp = "#B6687E" },
				error_diagnostic = { fg = "#B6687E", sp = "#B6687E" },
				warning = { fg = "#BAA984", sp = "#BAA984" },
				warning_diagnostic = { fg = "#BAA984", sp = "#BAA984" },
				info = { fg = "#61afef", sp = "#61afef" },
				info_diagnostic = { fg = "#61afef", sp = "#61afef" },
				hint = { fg = "#6FA9A0", sp = "#6FA9A0" },
				hint_diagnostic = { fg = "#6FA9A0", sp = "#6FA9A0" },
			},
		})
	end,
	-- keys = {
	-- },
}
