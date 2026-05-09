return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
				key = function()
					return vim.fn.getcwd()
				end,
			},
		})

		vim.keymap.set("n", "<leader>h", function()
			harpoon:list():add()
		end, { desc = "Harpoon: Add current file" })

		vim.keymap.set("n", "<C-e>", function()
			local harpoon_files = harpoon:list()
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end
			Snacks.picker.pick({
				title = "Harpoon",
				items = vim.tbl_map(function(path)
					return { text = path, file = path }
				end, file_paths),
				format = "file",
				confirm = function(picker, item)
					picker:close()
					if item then
						vim.cmd("edit " .. item.file)
					end
				end,
			})
		end, { desc = "Harpoon: Open picker" })

		vim.keymap.set("n", "<C-p>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon: Toggle quick menu" })
	end,
}
