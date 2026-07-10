return {
	"nvim-treesitter/nvim-treesitter-context",
	event = "VeryLazy",
	opts = {
		enable = true,
		multiwindow = false,
		max_lines = 0,
		min_window_height = 0,
		line_numbers = true,
		multiline_threshold = 20,
		trim_scope = "outer",
		mode = "cursor",
		separator = nil,
		zindex = 20,
		on_attach = nil,
	},
	config = function(_, opts)
		require("treesitter-context").setup(opts)
		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#131317" })
		-- vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#89b4fa", bg = "#131317" })
		-- vim.api.nvim_set_hl(0, "TreesitterContextSeparator", { fg = "#313244" })
		-- vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "#89b4fa" })
	end,
}
