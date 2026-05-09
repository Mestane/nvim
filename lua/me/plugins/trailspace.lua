return {
	"echasnovski/mini.trailspace",
	version = "*",
	event = "BufReadPost",
	config = function()
		require("mini.trailspace").setup()
		-- vim.api.nvim_create_autocmd("BufWritePre", {
		-- 	callback = function()
		-- 		require("mini.trailspace").trim()
		-- 	end,
		-- })
	end,

	keys = {
		{
			"<leader>ct",
			function()
				require("mini.trailspace").trim()
			end,
			desc = "Trim trailing whitespace",
		},
	},
}
