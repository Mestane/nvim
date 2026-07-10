return {
	"akinsho/toggleterm.nvim",
	enabled = true,
	version = "*",
	event = "VeryLazy",
	opts = {
		size = 15,
		open_mapping = [[<c-\>]],
		hide_numbers = true,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		close_on_exit = false,
		shell = vim.o.shell,
		direction = "horizontal",
		highlights = {
			Normal = { link = "NormalFloat" },
			NormalNC = { link = "NormalFloat" },
			FloatBorder = { link = "FloatBorder" },
		},
		winbar = {
			enabled = true,
			name_formatter = function(term) --  term: Terminal
				return term.name
			end,
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*toggleterm#*",
			callback = function()
				if not vim.bo.filetype:match("toggleterm") then
					return
				end
				local o = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], o)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], o)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], o)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], o)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], o)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], o)
			end,
		})

		local Terminal = require("toggleterm.terminal").Terminal

		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
		function _LAZYGIT_TOGGLE()
			lazygit:toggle()
		end

		local node = Terminal:new({ cmd = "node", hidden = true })
		function _NODE_TOGGLE()
			node:toggle()
		end

		local python = Terminal:new({ cmd = "python3", hidden = true })
		function _PYTHON_TOGGLE()
			python:toggle()
		end

		local map = vim.keymap.set

		map("n", "<leader>th", function()
			Terminal:new({ direction = "horizontal" }):toggle()
		end, { desc = "Terminal: Horizontal split" })

		--
		-- -- Dikey split
		-- map("n", "<leader>tv", function()
		--     Terminal:new({ direction = "vertical", size = vim.o.columns * 0.4 }):toggle()
		-- end, { desc = "Terminal: Vertical split" })
		--
		-- -- Tab'da aç
		-- map("n", "<leader>tt", function()
		--     Terminal:new({ direction = "tab" }):toggle()
		-- end, { desc = "Terminal: Tab" })
		--
		-- -- Float
		-- map("n", "<leader>tf", function()
		--     Terminal:new({ direction = "float" }):toggle()
		-- end, { desc = "Terminal: Float" })
		--
		-- -- Açık terminaller arasında seç
		map("n", "<leader>ti", "<cmd>TermSelect<cr>", { desc = "Terminal: Select" })
		--
		-- map("n", "<leader>tg", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", { desc = "Terminal: Lazygit" })
		-- map("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>", { desc = "Terminal: Node" })
		-- map("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", { desc = "Terminal: Python" })
	end,
}
