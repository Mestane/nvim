return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")

		local parsers = {
			"vim",
			"vimdoc",
			"bash",
			"lua",
			"rasi",
			"json",
			"java",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"python",
			"html",
			"qmljs",
			"css",
			"markdown",
			"markdown_inline",
			"svelte",
			"graphql",
			"dockerfile",
			"http",
			"gitignore",
			"xml",
			"kotlin",
			"sql",
			"desktop",
			"hyprlang",
		}

		ts.setup({ ensure_installed = parsers })

		local installed = ts.get_installed()
		local to_install = vim.tbl_filter(function(p)
			return not vim.tbl_contains(installed, p)
		end, parsers)
		if #to_install > 0 then
			ts.install(to_install)
		end

		-- Highlighting + Fold
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function()
				pcall(vim.treesitter.start)
				vim.wo.foldmethod = "expr"
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			end,
		})

		-- Incremental selection
		vim.keymap.set("n", "<C-space>", function()
			vim.cmd("normal! v")
			require("vim.treesitter._select").select_parent(1)
		end, { desc = "TS: init selection" })
		vim.keymap.set("x", "<C-space>", function()
			require("vim.treesitter._select").select_parent(1)
		end, { desc = "TS: node incremental" })
		vim.keymap.set("x", "<bs>", function()
			require("vim.treesitter._select").select_child(1)
		end, { desc = "TS: node decremental" })

		-- Dil kayıtları
		vim.treesitter.language.register("bash", "zsh")
		vim.filetype.add({
			pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
		})

		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = "*.rasi",
			callback = function()
				vim.bo.filetype = "rasi"
			end,
		})
	end,
}
