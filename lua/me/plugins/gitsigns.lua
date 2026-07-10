return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	opts = {
		current_line_blame = true,
		preview_config = {
			border = "rounded",
		},
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")
			local map = function(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
			end

			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next", { preview = false })
				end
			end, "Next hunk")

			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev", { preview = false })
				end
			end, "Prev hunk")

			map("n", "<leader>gh", gitsigns.preview_hunk_inline, "Preview hunk inline")
			map("n", "<leader>gr", gitsigns.preview_hunk, "Preview hunk")
			map("n", "<leader>gR", gitsigns.blame, "Preview blame")
			map("n", "<leader>gH", gitsigns.blame_line, "Preview blame line")
		end,
	},
}
