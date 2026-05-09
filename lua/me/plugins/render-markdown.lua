return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	-- enabled = false,
	opts = {
		file_types = { "markdown", "Avante" }, -- bunu ekle
		latex = { enabled = false },
		completions = {
			coq = { enabled = false },
			lsp = { enabled = true },
		},
		checkbox = {
			enabled = true,
			render_modes = false,
			bullet = false,
			left_pad = 0,
			right_pad = 1,
			unchecked = {
				icon = "󰄱 ",
				highlight = "RenderMarkdownUnchecked",
				scope_highlight = nil,
			},
			checked = {
				icon = "󰱒 ",
				highlight = "RenderMarkdownChecked",
				scope_highlight = nil,
			},

			custom = {
				todo = {
					raw = "[-]",
					rendered = "󰥔 ",
					highlight = "RenderMarkdownTodo",
					scope_highlight = nil,
				},

				cancaled = {
					raw = "[^]",
					rendered = "󰜺 ",
					highlight = "RenderMarkdownHtmlComment",
					scope_highlight = "@markup.strikethrough",
				},

				in_progress = {
					raw = "[>]",
					rendered = "󰄭 ",
					highlight = "RenderMarkdownInProgress",
					scope_highlight = "@markup.italic",
				},
				important = {
					raw = "[~]",
					rendered = "󰈸 ",
					highlight = "DiagnosticWarn",
					scope_highlight = "@markup.bold",
				},
				critical = {
					raw = "[!]",
					rendered = "󰀨 ",
					highlight = "DiagnosticError",
					scope_highlight = "@markup.bold",
				},
			},
			scope_priority = nil,
		},
	},
}
