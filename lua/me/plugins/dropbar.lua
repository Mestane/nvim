return {
	"Bekaboo/dropbar.nvim",
	-- enabled = false,
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		local dropbar_api = require("dropbar.api")

		-- Keymaps
		vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Dropbar: pick symbol" })
		vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Dropbar: go to context start" })
		vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Dropbar: select next context" })

		require("dropbar").setup({
			bar = {

				hover = true,
				sources = function(buf, _)
					local sources = require("dropbar.sources")
					local utils = require("dropbar.utils")
					if vim.bo[buf].ft == "markdown" then
						return { sources.path, sources.markdown }
					end
					if vim.bo[buf].buftype == "terminal" then
						return { sources.terminal }
					end
					return {
						sources.path,
						utils.source.fallback({
							sources.lsp,
							sources.treesitter,
						}),
					}
				end,
			},
			menu = {

				quick_navigation = true,
				preview = true,
				keymaps = {
					["q"] = "<C-w>q",
					-- ["<Esc>"] = "<C-w>q",
					["<Esc>"] = function()
						local utils = require("dropbar.utils")
						utils.menu.exec("close")
					end,
					["h"] = "<C-w>q",
					["l"] = function()
						local menu = require("dropbar.utils").menu.get_current()
						if not menu then
							return
						end
						local cursor = vim.api.nvim_win_get_cursor(menu.win)
						local entry = menu.entries[cursor[1]]
						local component = entry:first_clickable(cursor[2])
						if component then
							menu:click_on(component, nil, 1, "l")
						end
					end,
				},
			},

			sources = {
				path = {
					modified = function(sym)
						return sym:merge({
							name = sym.name .. " [+]",
							icon = " ",
							name_hl = "DiffAdded",
							icon_hl = "DiffAdded",
						})
					end,
				},
			},
		})
	end,
}
