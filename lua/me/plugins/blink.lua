return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"moyiz/blink-emoji.nvim",
			"Kaiser-Yang/blink-cmp-git",
			"Kaiser-Yang/blink-cmp-avante",
			"onsails/lspkind.nvim",
			{ "nvim-mini/mini.icons", version = "*" },
		},
		opts = {
			keymap = {
				preset = "default",
				["<C-j>"] = { "select_next" },
				["<C-k>"] = { "select_prev" },
				["<C-b>"] = { "scroll_documentation_up" },
				["<C-f>"] = { "scroll_documentation_down" },
				["<C-e>"] = { "cancel" },
				["<C-Space>"] = { "show" },
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
				["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
			},
			cmdline = {
				enabled = true,
				keymap = {
					["<Tab>"] = { "accept" },
					-- ["<CR>"] = { "fallback" },
					["<C-j>"] = { "select_next" },
					["<C-k>"] = { "select_prev" },
					-- ["<C-j>"] = { "select_next", "fallback" },
					-- ["<C-k>"] = { "select_prev", "fallback" },
				},
				completion = { menu = { auto_show = true } },
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = { border = "rounded" },
				},
				menu = {
					border = "rounded",
					winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpBorder",
					auto_show = function()
						local bt = vim.bo.buftype
						if bt == "prompt" or bt == "nofile" then
							return false
						end
						return not vim.tbl_contains({ "dropbar_menu" }, vim.bo.filetype)
					end,
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									return require("lspkind").symbol_map[ctx.kind] or ""
								end,
							},
						},
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "kind", gap = 1 },
						},
					},
				},
			},
			signature = { enabled = true },
			snippets = { preset = "default" },
			sources = {
				default = {
					"lsp",
					"path",
					"buffer",
					"snippets",
					"emoji",
					"git",
					"blinkcmpavante",
				},
				per_filetype = {
					TelescopePrompt = {},
					oil = {},
					DressingInput = {},
				},
				providers = {
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15,
						opts = {
							insert = true,
							trigger = function()
								return { ":" }
							end,
						},
						should_show_items = function()
							return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
						end,
					},
					blinkcmpavante = {
						module = "blink-cmp-avante",
						name = "Avante",
						opts = {},
					},
					git = {
						module = "blink-cmp-git",
						name = "Git",
						enabled = function()
							return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype)
						end,
						opts = {},
					},
				},
			},
		},
	},
}
