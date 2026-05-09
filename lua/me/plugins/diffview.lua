return {
	"sindrets/diffview.nvim",
	-- enabled = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewFileHistory",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
	},
	keys = {
		{ "<leader>vv", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
		{ "<leader>vc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
		{ "<leader>vh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview File History" },
		{ "<leader>vf", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview Current File History" },
		{ "<leader>vk", "<cmd>DiffviewOpen HEAD -- %<cr>", desc = "Diff file vs HEAD" },

		-----------------------------------------------------------------------------------------------------------------------------------------------------------
		-- Temel
		-- { "<leader>vv", "<cmd>DiffviewOpen<cr>", desc = "Diffview: Working tree" },
		-- { "<leader>vc", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" },
		--
		-- -- Geçmiş
		-- { "<leader>vh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: Repo history" },
		-- { "<leader>vf", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: File history" },
		--
		-- -- HEAD karşılaştırma
		-- { "<leader>vk", "<cmd>DiffviewOpen HEAD -- %<cr>", desc = "Diffview: File vs HEAD" },
		--
		-- -- PR öncesi: branch'teki tüm değişiklikler
		-- { "<leader>vb", "<cmd>DiffviewOpen origin/main...HEAD<cr>", desc = "Diffview: Branch vs origin/main" },
		--
		-- -- Merge conflict
		-- { "<leader>vm", "<cmd>DiffviewOpen<cr>", desc = "Diffview: Merge conflicts" },
		--
		-- -- Panel toggle
		-- { "<leader>vt", "<cmd>DiffviewToggleFiles<cr>", desc = "Diffview: Toggle file panel" },
		--
		-- -- Commit range (son N commit) — komut satırından: :DiffviewOpen HEAD~3
		-- { "<leader>v3", "<cmd>DiffviewOpen HEAD~3<cr>", desc = "Diffview: Last 3 commits" },
	},
	config = function()
		-- local actions = require("diffview.actions")
		require("diffview").setup({
			diff_binaries = false,
			enhanced_diff_hl = true,
			git_cmd = { "git" },
			hg_cmd = { "hg" },
			use_icons = true,
			show_help_hints = true,
			watch_index = true,
			icons = {
				folder_closed = "",
				folder_open = "",
			},
			signs = {
				fold_closed = "",
				fold_open = "",
				done = "✓",
			},
			view = {
				default = {
					layout = "diff2_horizontal",
					disable_diagnostics = false,
					winbar_info = true,
				},
				merge_tool = {
					layout = "diff3_horizontal",
					disable_diagnostics = true,
					winbar_info = true,
				},
				file_history = {
					layout = "diff2_horizontal",
					disable_diagnostics = false,
					winbar_info = true,
				},
			},
			file_panel = {
				listing_style = "tree",
				tree_options = {
					flatten_dirs = true,
					folder_statuses = "only_folded",
				},
				win_config = {
					position = "left",
					width = 35,
					win_opts = {},
				},
			},
			file_history_panel = {
				log_options = {
					git = {
						single_file = { diff_merges = "combined" },
						multi_file = { diff_merges = "first-parent" },
					},
					hg = {
						single_file = {},
						multi_file = {},
					},
				},
				win_config = {
					position = "bottom",
					height = 16,
					win_opts = {},
				},
			},
			commit_log_panel = { win_config = {} },
			default_args = {
				DiffviewOpen = {},
				DiffviewFileHistory = {},
			},

			hooks = {
				view_opened = function()
					for _, client in ipairs(vim.lsp.get_clients({ name = "hyprls" })) do
						client:stop()
					end
				end,
				view_closed = function()
					vim.defer_fn(function()
						local clients = vim.lsp.get_clients({ name = "hyprls" })
						if #clients > 0 then
							return
						end
						local buf = vim.api.nvim_get_current_buf()
						if vim.bo[buf].filetype == "hyprlang" then
							vim.lsp.start({
								name = "hyprls",
								cmd = { "hyprls" },
								root_dir = vim.fn.expand("~/.config/hypr"),
							})
						end
					end, 100)
				end,
			},

			keymaps = {},
		})
	end,
}
