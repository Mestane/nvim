return {
	"MagicDuck/grug-far.nvim",
	-- enabled = false,
	cmd = { "GrugFar", "GrugFarWithin" },
	opts = {
		-- headerMaxWidth = 80,
		-- windowCreationCommand = "90 vsplit",
		-- Minimum karakter sayısı (search tetiklenmesi için)
		minSearchChars = 2,
		-- Wrap uzun satırları
		resultsSeparatorLineChar = "─",
	},
	keys = {
		-- Genel arama/replace
		{
			"<leader>Sr",
			function()
				require("grug-far").open({ transient = true })
			end,
			mode = { "n", "x" },
			desc = "Search & Replace",
		},
		-- Sadece mevcut dosya uzantısını filtrele
		{
			"<leader>SR",
			function()
				local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
				require("grug-far").open({
					transient = true,
					prefills = {
						filesFilter = ext and ext ~= "" and "*." .. ext or nil,
					},
				})
			end,
			mode = { "n", "x" },
			desc = "Search & Replace (current filetype)",
		},
		-- Cursor altındaki kelimeyle aç
		{
			"<leader>Sw",
			function()
				require("grug-far").open({
					transient = true,
					prefills = { search = vim.fn.expand("<cword>") },
				})
			end,
			desc = "Search & Replace (word under cursor)",
		},
		-- Sadece mevcut dosyada ara
		{
			"<leader>Sf",
			function()
				require("grug-far").open({
					transient = true,
					prefills = { paths = vim.fn.expand("%") },
				})
			end,
			desc = "Search & Replace (current file)",
		},
	},
}
