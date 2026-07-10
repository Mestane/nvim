return {

	{
		"catppuccin/nvim",
		enabled = true,
		name = "catppuccin",
		lazy = false,
		priority = 1000,

		opts = {
			flavour = "auto", -- latte, frappe, macchiato, mocha
			auto_integrations = false,

			integrations = {
				cmp = true,
				-- gitsigns = true,
				gitsigns = {
					enabled = true,
					-- align with the transparent_background option by default
					transparent = false,
				},
				nvimtree = true,
				treesitter = true,
				octo = true,
				notify = true,
				mason = true,
				-- lualine = true,
				lsp_trouble = false,
				dap = true,
				snacks = {
					enabled = true,
					indent_scope_color = "lavender",
				},
				dap_ui = true,
				dadbod_ui = true,
				-- grug_far = true,
				diffview = true,
				blink_cmp = {
					style = "bordered",
				},
				render_markdown = true,
				fzf = false,
				harpoon = true,
				noice = true,
				telescope = true,
				dropbar = {
					enabled = true,
					color_mode = true, -- enable color for kind's texts, not just kind's icons
				},
				which_key = true,
				-- illuminate = {
				-- 	enabled = true,
				-- 	lsp = false,
				-- },
				treesitter_context = true,
				hop = true,
				indent_blankline = {
					enabled = true,
					scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
					colored_indent_levels = false,
				},
				flash = true,
				dashboard = true,
				bufferline = true,
				mini = { enabled = true, indentscope_color = "" },
			},

			color_overrides = {
				mocha = {
					base = "#131316",
					mantle = "#101013",
					crust = "#0C0C0C",
				},
			},

			styles = {
				comments = { "italic" },
			},

			highlight_overrides = {
				mocha = function(colors)
					return {
						EndOfBuffer = { fg = "#131316" },
						WinSeparator = { fg = "#131316", bg = "NONE" },

						WinbarPath = {
							fg = colors.overlay1,
							italic = true,
						},
					}
				end,
			},
		},

		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd([[colorscheme catppuccin-nvim]])
		end,
	},

	{
		"folke/tokyonight.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			style = "night", -- The theme comes in three styles, `storm`, `moon`, and `night`.
		},

	},
}
