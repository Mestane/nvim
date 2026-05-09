return {
	"supermaven-inc/supermaven-nvim",
	event = "VeryLazy",
	opts = {
		keymaps = {
			accept_suggestion = "<C-o>",
			clear_suggestion = "<C-]>",
			accept_word = "<C-[>",
		},
		ignore_filetypes = { ["leetcode.nvim"] = true },
		color = {},
		log_level = "info",
		disable_inline_completion = false,
		disable_keymaps = false,
	},
}
