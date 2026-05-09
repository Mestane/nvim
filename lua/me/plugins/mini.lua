return {
	"nvim-mini/mini.ai",
	version = false,
	event = "VeryLazy",
	opts = function()
		return {
			n_lines = 500,
			search_method = "cover_or_next",
			custom_textobjects = {
				f = require("mini.ai").gen_spec.treesitter({
					a = "@function.outer",
					i = "@function.inner",
				}),
				c = require("mini.ai").gen_spec.treesitter({
					a = "@class.outer",
					i = "@class.inner",
				}),
			},
			-- mappings = {
			-- 	around_next = "",
			-- 	inside_next = "",
			-- 	around_last = "",
			-- 	inside_last = "",
			-- },
		}
	end,
}
