return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		picker = {

			actions = {
				smart_jump = function(picker, item)
					if not item then
						return
					end

					-- Eğer seçilen öge bir klasörse, Explorer'ın varsayılan aç/kapat davranışını çalıştır
					if item.dir or (item.file and vim.fn.isdirectory(item.file) == 1) then
						picker:action("confirm")
						return
					end

					picker:close()
					if not item.file then
						return
					end

					local target_file = vim.fn.fnamemodify(item.file, ":p")
					local found_tab = nil
					local found_win = nil

					-- Açık olan tüm sekme ve pencereleri tara
					for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
						for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
							local buf = vim.api.nvim_win_get_buf(win)
							local buf_name = vim.api.nvim_buf_get_name(buf)
							if buf_name ~= "" and vim.fn.fnamemodify(buf_name, ":p") == target_file then
								found_tab = tabpage
								found_win = win
								break
							end
						end
						if found_tab then
							break
						end
					end

					if found_tab and found_win then
						vim.api.nvim_set_current_tabpage(found_tab)
						vim.api.nvim_set_current_win(found_win)
					else
						vim.cmd("edit " .. vim.fn.fnameescape(item.file))
					end
				end,
			},

			enabled = true,
			ui_select = true,
			icons = {
				git = {
					enabled = true,
					-- commit = "󰜘 ",
					commit = " ",
					staged = "●",
					added = "",
					deleted = "",
					ignored = " ",
					modified = " ",
					-- modified = "○",
					renamed = "",
					unmerged = " ",
					untracked = "?",
				},
			},
			sources = {
				files = {
					layout = "vscode",
					-- exclude = { "node_modules", ".git", "dist", "build", "target" },
					-- exclude = { "*.class" },
				},
				lsp_workspace_symbols = { layout = "vertical" },
				cliphist = {
					finder = "system_cliphist",
					format = "text",
					layout = "dropdown",
					preview = "preview",
					confirm = { "copy", "close" },
				},
				lsp_symbols = {
					layout = {
						preset = "sidebar",
						layout = { position = "right", width = 0.25 },
					},
				},
				projects = {
					layout = "vscode",
					dev = { "~/dev", "~/IdeaProjects" },
					patterns = {
						"pom.xml",
						"mvnw.cmd",
						".git",
						"_darcs",
						".hg",
						"package.json",
						"Makefile",
					},
				},
				diagnostics = { layout = "ivy" },
				keymaps = { layout = "bottom", confirm = false },
				git_branches = { layout = "vscode" },
				explorer = {
					hidden = false,
					follow_file = true,
                    -- ignored = true,
					-- ignore_patterns = { "node_modules", "target", "dist", "build", ".git" },
					-- exclude = { "**/*.class" },

					filter = function(item, picker)
						-- Eğer 'Toggle Ignore' kapalıysa (picker.opts.ignored == false)
						-- ve dosya .class uzantılıysa listeden süz
						if not picker.opts.ignored and item.file and item.file:match("%.class$") then
							return false
						end
						return true
					end,
					-- transform = function(item)
					-- 	-- Match against file paths or names you want to completely hide
					-- 	-- if item.file:match("%.class$") or item.file:match("package%-lock%.json") then
					-- 	if item.file:match("%.class$") then
					-- 		return false -- returns false to drop/exclude the item
					-- 	end
					-- 	return item
					-- end,

					layout = { preset = "sidebar", preview = false },
					win = {
						input = {
							keys = {
								["<C-t>"] = { "tab", mode = { "i", "n" } },
								["<CR>"] = { "smart_jump", mode = { "i", "n" } },
							},
						},
						list = {
							keys = {
								["<C-t>"] = "tab",
								["<CR>"] = "smart_jump",
							},
						},
					},
				},
			},
		},

		explorer = {
			enabled = true,
			trash = true,
			replace_netrw = false,
		},

		gh = {
			enabled = true,
			wo = {
				breakindent = true,
				wrap = true,
				showbreak = "",
				linebreak = true,
				number = false,
				relativenumber = false,
				foldexpr = "v:lua.vim.treesitter.foldexpr()",
				foldmethod = "expr",
				concealcursor = "n",
				conceallevel = 2,
				list = false,
			},
			bo = {},
			diff = { min = 4, wrap = 80 },
			scratch = { height = 15 },
			icons = {
				logo = " ",
				user = " ",
				checkmark = " ",
				crossmark = " ",
				block = "■",
				file = " ",
				checks = {
					pending = " ",
					success = " ",
					failure = "",
					skipped = " ",
				},
				issue = {
					open = " ",
					completed = " ",
					other = " ",
				},
				pr = {
					open = " ",
					closed = " ",
					merged = " ",
					draft = " ",
					other = " ",
				},
				review = {
					approved = " ",
					changes_requested = " ",
					commented = " ",
					dismissed = " ",
					pending = " ",
				},
				merge_status = {
					clean = " ",
					dirty = " ",
					blocked = " ",
					unstable = " ",
				},
				reactions = {
					thumbs_up = "👍",
					thumbs_down = "👎",
					eyes = "👀",
					confused = "😕",
					heart = "❤️",
					hooray = "🎉",
					laugh = "😄",
					rocket = "🚀",
				},
			},
		},

		blame_line = {
			width = 0.6,
			height = 0.6,
			border = true,
			title = " Git Blame ",
			title_pos = "center",
			ft = "git",
		},

		indent = {
			enabled = true,
			-- priority = 1,
			char = "│",
			only_scope = false,
			only_current = false,

			scope = {
				enabled = true,
				priority = 200,
				char = "│",
				underline = true,
				only_current = false,
				hl = "SnacksIndentScope",
			},
			animate = {
				enabled = vim.fn.has("nvim-0.10") == 1,
				style = "out",
				easing = "outQuad",
				duration = { step = 20, total = 400 },
			},
			chunk = {
				enabled = true,
				only_current = false,
				priority = 200,
				hl = "SnacksIndentChunk",
				char = {
					corner_top = "╭",
					corner_bottom = "╰",
					horizontal = "─",
					vertical = "│",
					arrow = ">",
				},
			},
			filter = function(buf)
				return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
			end,
		},

		image = { enabled = true },

		dim = {
			enabled = true,
			scope = { min_size = 5, max_size = 20, siblings = true },
			animate = {
				enabled = vim.fn.has("nvim-0.10") == 1,
				easing = "outQuad",
				duration = { step = 20, total = 300 },
			},
			filter = function(buf)
				return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
			end,
		},

		words = {
			enabled = true,
			modes = { "n" },
		},

		scope = {
			enabled = true,
			cursor = true,
			edge = true,
			filter = function(buf)
				return vim.bo[buf].buftype == "" and vim.b[buf].snacks_scope ~= false and vim.g.snacks_scope ~= false
			end,
			treesitter = {
				enabled = true,
				injections = true,
				blocks = {
					enabled = true,
					"function_declaration",
					"function_definition",
					"method_declaration",
					"method_definition",
					"class_declaration",
					"class_definition",
					"do_statement",
					"while_statement",
					"repeat_statement",
					"if_statement",
					"for_statement",
				},
				field_blocks = { "local_declaration" },
			},
		},

		scroll = { enabled = false },
		notifier = { enabled = true, timeout = 3000 },
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
		input = { enabled = false },
		quickfile = { enabled = false },
		statuscolumn = { enabled = false },
	},

	keys = {
		-- Picker
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},

		{
			"<leader>fT",
			function()
				Snacks.picker.files({
					layout = { preset = "vscode" },
					win = {
						input = {
							keys = {
								["<CR>"] = { "smart_jump", mode = { "i", "n" } },
							},
						},
						list = {
							keys = {
								["<CR>"] = "smart_jump",
							},
						},
					},
				})
			end,
			desc = "Smart Find Files",
		},

		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.files({ cwd = "~/.config" })
			end,
			desc = "Find ~/.config Files",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fp",
			function()
				Snacks.picker.projects()
			end,
			desc = "Projects",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>fi",
			function()
				Snacks.picker.icons()
			end,
			desc = "Icons",
		},
		{
			"<leader>ft",
			function()
				Snacks.picker.todo_comments({
					-- layout = { preset = "ivy" },
					layout = { preset = "vertical" },
				})
			end,
			desc = "Todo Comments",
		},
		-- {
		-- 	"<leader>ft",
		-- 	function()
		-- 		Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "HACK", "NOTE", "WARN" } })
		-- 	end,
		-- 	desc = "Todo Comments",
		-- },
		-- {
		-- 	"<leader>ft",
		-- 	function()
		-- 		Snacks.picker.cliphist()
		-- 	end,
		-- 	desc = "Clipboard History",
		-- },
		{
			"<leader>fl",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>fk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>fm",
			function()
				Snacks.picker.man()
			end,
			desc = "Man Pages",
		},
		{
			"<leader>fu",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		{
			"<leader>f:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>nu",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notifications History",
		},
		{
			"<leader>fw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Grep Word",
			mode = { "n", "x" },
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.grep({

					layout = { preset = "ivy" },
				})
			end,
			desc = "Grep",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		-- {
		-- 	"<leader>sS",
		-- 	function()
		-- 		Snacks.picker.lsp_workspace_symbols()
		-- 	end,
		-- 	desc = "LSP Workspace Symbols",
		-- },
		{
			"<leader>foi",
			function()
				Snacks.picker.lsp_incoming_calls()
			end,
			desc = "LSP Incoming Calls",
		},
		{
			"<leader>foo",
			function()
				Snacks.picker.lsp_outgoing_calls()
			end,
			desc = "LSP Outgoing Calls",
		},
		{
			"<leader>xx",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>xX",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Diagnostics Buffer",
		},

		-- Explorer
		{
			"<M-1>",
			function()
				Snacks.explorer()
			end,
			desc = "Toggle File Explorer",
		},

		-- Git
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log File",
		},
		{
			"<leader>ga",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame Line",
		},
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git Log Line",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gS",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "Git Stash",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>gi",
			function()
				Snacks.picker.gh_issue()
			end,
			desc = "GitHub Issues",
		},
		{
			"<leader>gI",
			function()
				Snacks.picker.gh_issue({ state = "all" })
			end,
			desc = "GitHub Issues (All)",
		},
		{
			"<leader>gp",
			function()
				Snacks.picker.gh_pr()
			end,
			desc = "GitHub Pull Requests",
		},
		{
			"<leader>gP",
			function()
				Snacks.picker.gh_pr({ state = "all" })
			end,
			desc = "GitHub Pull Requests (All)",
		},

		-- Lazygit
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>ll",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Lazygit Log",
		},
		{
			"<leader>lf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit Log File",
		},

		-- Bufdelete
		{
			"<leader>bda",
			function()
				Snacks.bufdelete.all()
			end,
			desc = "Delete All Buffers",
		},
		{
			"<leader>bdf",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<leader>di",
			function()
				if vim.g.snacks_dim then
					Snacks.dim.disable()
					vim.g.snacks_dim = false
					Snacks.notify("Dim disabled", { level = vim.log.levels.INFO })
				else
					Snacks.dim.enable()
					vim.g.snacks_dim = true
					Snacks.notify("Dim enabled", { level = vim.log.levels.INFO })
				end
			end,
			desc = "Toggle Snacks Dim",
		},

		-- Dim toggle
		-- {
		-- 	"<leader>di",
		-- 	function()
		-- 		if vim.g.snacks_dim then
		-- 			Snacks.dim.disable()
		-- 			vim.g.snacks_dim = false
		-- 		else
		-- 			Snacks.dim.enable()
		-- 			vim.g.snacks_dim = true
		-- 		end
		-- 	end,
		-- 	desc = "Toggle Snacks Dim",
		-- },

		-- Neovim News
		{
			"<leader>N",
			function()
				local file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1]

				if not file then
					vim.notify("news.txt not found", vim.log.levels.ERROR)
					return
				end

				local buf = vim.api.nvim_create_buf(false, true)

				vim.api.nvim_buf_call(buf, function()
					vim.cmd("silent read " .. file)
				end)

				Snacks.win({
					buf = buf,
					width = 0.46,
					height = 0.7,
					wo = {
						spell = false,
						wrap = false,
						signcolumn = "yes",
						statuscolumn = " ",
						conceallevel = 3,
					},
				})
			end,
			desc = "Neovim News",
		},
	},

	init = function()
		vim.g.snacks_dim = false
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.dim():map("<leader>uD")
			end,
		})
	end,
}
