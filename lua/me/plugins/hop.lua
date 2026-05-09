return {
	'smoka7/hop.nvim',
	version = "*",
	opts = {
		keys = 'etovxqpdygfblzhckisuran'
	},
	keys = {
		{ ",f", "<cmd>HopWord<CR>", desc = "Hop Word" },
		{ ",a", "<cmd>HopCamelCase<CR>", desc = "Hop CamelCase" },
		{ ",w", "<cmd>HopCamelCaseAC<CR>", desc = "Hop CamelCase After Cursor" },
		{ ",b", "<cmd>HopCamelCaseBC<CR>", desc = "Hop CamelCase Before Cursor" },
		-- { ",cm", "<cmd>HopChar2<CR>", desc = "Hop Char2" },
	},
}
