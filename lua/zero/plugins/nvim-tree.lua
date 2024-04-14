local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

local on_attach = function(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))

	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
end

--dependencies = { "nvim-tree/nvim-web-devicons" },
-- recommended settings from nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF  ]])
-- vim.cmd([[ highlight NvimTreeNormal guibg=#171717  ]])

nvimtree.setup({

	on_attach = on_attach,

	view = {
		width = 40,
		-- relativenumber = true,
	},
	-- change folder arrow icons
	renderer = {
		indent_markers = {
			enable = true,
		},

		icons = {
			glyphs = {
				folder = {
					--arrow_closed = "", -- arrow when folder is closed
					--arrow_open = "", -- arrow when folder is open
				},
			},
		},
	},
	-- disable window_picker for
	-- explorer to work well with
	-- window splits
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
	filters = {
		custom = { ".DS_Store" },
	},
	git = {
		ignore = false,
	},
})

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<M-1>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
