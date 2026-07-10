return {
	{

		"saghen/blink.cmp",
		dependencies = {
			"saghen/blink.lib",
			-- { "saghen/blink.lib", commit = "220979f3fcd388a08990189bc3b4e82aa1637ce9" },
			"rafamadriz/friendly-snippets",
			"Kaiser-Yang/blink-cmp-git",
			"Kaiser-Yang/blink-cmp-avante",

			"onsails/lspkind.nvim",
			{ "nvim-mini/mini.icons", version = "*" },
			"ribru17/blink-cmp-spell",
		},
		-- version = "1.*",
		-- commit = "0593548ee0b0978abf303d30f449234e07f951d1",
		build = function()
			require("blink.cmp").build():wait(60000)
			-- require('blink.cmp').build():pwait()
		end,
		opts = {

			------------------------------------------------------------------------------------------------------------------------
			keymap = {
				-- preset = "default",
				-- ["<C-j>"] = { "select_next", "fallback_to_mappings" },
				-- ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
				------------------------------------------------------------------------------
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
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
				completion = {
					menu = { auto_show = true },
					-- keyword = { range = "full" },
					-- menu = {
					-- 	auto_show = function(ctx)
					-- 		return vim.fn.getcmdtype() == ":"
					-- 		-- enable for inputs as well, with:
					-- 		-- or vim.fn.getcmdtype() == '@'
					-- 	end,
					-- },
				},
				keymap = {
					-- preset = "inherit",
					-- preset = "cmdline", -- inherit yerine cmdline preset kullan
					-- keymap = { preset = "inherit" },
					["<Tab>"] = { "accept" },
					-- ["<Tab>"] = { "show", "accept" },
					-- ["<CR>"] = { "fallback" },
					["<C-j>"] = { "select_next" },
					["<C-k>"] = { "select_prev" },
					-- ["<C-j>"] = { "select_next", "fallback" },
					-- ["<C-k>"] = { "select_prev", "fallback" },
				},
			},

			------------------------------------------------------------------------------------------------------------------------
			completion = {
				-- accept = {
				-- 	create_undo_point = false,
				-- },
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
						local ft = vim.bo.filetype
						-- local bufname = vim.api.nvim_buf_get_name(0)
						if bt == "prompt" or bt == "nofile" then
							return false
						end

						-- if bufname:match("suda://") then
						-- 	return false
						-- end

						-- return not vim.tbl_contains({ "dropbar_menu", "snacks_picker_input" }, vim.bo.filetype)
						return not vim.tbl_contains({ "dropbar_menu", "snacks_picker_input" }, ft)
					end,

					draw = {
						-- treesitter = {"lsp",},
						components = {

							label = {
								width = { fill = true, max = 60 },
								text = function(ctx)
									local highlights_info = require("colorful-menu").blink_highlights(ctx)
									if highlights_info ~= nil then
										-- Or you want to add more item to label
										return highlights_info.label
									else
										return ctx.label
									end
								end,
								highlight = function(ctx)
									local highlights = {}
									local highlights_info = require("colorful-menu").blink_highlights(ctx)
									if highlights_info ~= nil then
										highlights = highlights_info.highlights
									end
									for _, idx in ipairs(ctx.label_matched_indices) do
										table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatchCustom" })
									end
									-- for _, idx in ipairs(ctx.label_matched_indices) do
									-- 	table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
									-- end
									-- Do something else
									return highlights
								end,
							},

							-- label = {
							-- 	width = { fill = true, max = 60 },
							-- 	text = function(ctx)
							-- 		local highlights_info = require("colorful-menu").blink_highlights(ctx)
							-- 		if highlights_info ~= nil then
							-- 			-- Or you want to add more item to label
							-- 			return highlights_info.label
							-- 		else
							-- 			return ctx.label
							-- 		end
							-- 	end,
							-- 	highlight = function(ctx)
							-- 		local highlights = {}
							-- 		local highlights_info = require("colorful-menu").blink_highlights(ctx)
							-- 		if highlights_info ~= nil then
							-- 			highlights = highlights_info.highlights
							-- 		end
							-- 		for _, idx in ipairs(ctx.label_matched_indices) do
							-- 			table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
							-- 		end
							-- 		-- Do something else
							-- 		return highlights
							-- 	end,
							-- },

							kind_icon = {
								text = function(ctx)
									local git_icons = {
										Commit = "",
										Mention = "",
										PR = "",
										MR = "",
										Issue = "",
									}
									if git_icons[ctx.kind] then
										return git_icons[ctx.kind] .. ctx.icon_gap
									end
									if ctx.source_id == "spell" then
										return "󰓆"
									end
									return require("lspkind").symbol_map[ctx.kind] or ""
								end,
							},
						},
						-- columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind", gap = 1 } },
						columns = { { "kind_icon" }, { "label", gap = 2 }, { "kind", gap = 1 } },
					},
				},
			},
			signature = { enabled = true, window = { border = "rounded" } },
			snippets = {
				preset = "default",
				-- preset = "luasnip",
			},

			sources = {
				default = {
					"lsp",
					"path",
					"buffer",
					"snippets",
					"git",
					"blinkcmpavante",
					"spell",
				},
				per_filetype = {
					TelescopePrompt = {},
					oil = {},
					DressingInput = {},
					-- snacks_picker_input = {}, -- bunu ekle
					-- ["suda://"] = {},
				},
				providers = {
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
					spell = {
						name = "Spell",
						module = "blink-cmp-spell",
						score_offset = -50,
						enabled = function()
							return vim.tbl_contains({ "markdown", "text", "gitcommit", "md" }, vim.bo.filetype)
						end,
						opts = {
							-- Optional: enable suggestions only in comments/strings with Tree-sitter
							enable_in_context = function()
								return true
							end,
						},
					},
				},
			},
			fuzzy = {
				implementation = "rust", -- bunu ekle
				sorts = {
					-- Recommended: prioritize exact label matching for spelling
					function(a, b)
						local sort = require("blink.cmp.fuzzy.sort")
						if a.source_id == "spell" and b.source_id == "spell" then
							return sort.label(a, b)
						end
						return require("blink.cmp.fuzzy.sort").score(a, b)
					end,
				},
			},
		},
	},
}
