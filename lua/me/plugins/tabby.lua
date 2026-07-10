return {
	"nanozuki/tabby.nvim",
	event = "VimEnter",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		vim.opt.showtabline = 2

		local function is_duplicated(tabid, wins)
			local bufs = {}
			for _, w in ipairs(wins) do
				bufs[#bufs + 1] = vim.api.nvim_win_get_buf(w)
			end
			-- diğer tüm tablara bak
			for _, other_tab in ipairs(vim.api.nvim_list_tabpages()) do
				if other_tab ~= tabid then
					for _, w in ipairs(vim.api.nvim_tabpage_list_wins(other_tab)) do
						local other_buf = vim.api.nvim_win_get_buf(w)
						for _, buf in ipairs(bufs) do
							if buf == other_buf then
								return true
							end
						end
					end
				end
			end
			return false
		end

		local colors = {
			bg = "#131317",
			bg_sel = "#1e1e2e",
			fg = "#cdd6f4",
			fg1 = "#a1a6b7",
			fg_dim = "#26262d",
			fg_dim2 = "#313244",
			mauve = "#cba6f7",
			red = "#f38ba8",
			yellow = "#f9e2af",
			blue = "#89b4fa",
			green = "#a6e3a1",
			last = "#C2C1FF",
			catp = "#F5B2E0",
			dup = "#ba5370",
			memory = "#b4befe",
			black = "#000000",
		}

		local theme = {
			fill = { bg = colors.bg, fg = colors.fg },
			head = { fg = colors.blue, bg = colors.bg },
			current_tab = { fg = colors.bg, bg = colors.blue, style = "bold" },
			tab = { fg = "#7f849c", bg = colors.fg_dim, style = "italic" },
			-- 🌟 YENİ: Göstergenin içindeki yazı ve okları mavi yapan tema kuralı
			indicator_text = { fg = colors.red, bg = colors.fg_dim, style = "bold" },
			win = { fg = colors.fg, bg = colors.bg },
			tail = { fg = colors.blue, bg = colors.bg },
			custom = { bg = colors.bg, fg = colors.red },
			custom3 = { bg = colors.last, fg = colors.bg },
			custom2 = { bg = colors.red, fg = colors.bg, style = "bold" },
			custom4 = { bg = colors.catp, fg = colors.bg, style = "bold" },
			custom5 = { fg = colors.fg, bg = colors.fg_dim2, style = "italic" },
			gitcolor = { fg = "#131317", bg = colors.green, style = "bold" },
			memcolor = { fg = colors.bg, bg = colors.memory, style = "italic" },
			pathcolor = { fg = colors.bg, bg = colors.mauve, style = "bold" },
		}

		local mem_cache = { value = "", last_time = 0 }

		local function get_memory()
			local now = os.time()
			if now - mem_cache.last_time < 7 then -- 7 seconds
				return mem_cache.value
			end
			local file = io.open("/proc/meminfo", "r")
			if not file then
				return ""
			end
			local total, available
			for line in file:lines() do
				local key, val = line:match("(%w+):%s+(%d+)")
				if key == "MemTotal" then
					total = tonumber(val)
				end
				if key == "MemAvailable" then
					available = tonumber(val)
				end
				if total and available then
					break
				end
			end
			file:close()
			if not total or not available then
				return ""
			end

			local used_gb = string.format("%.1f", (total - available) / 1024 / 1024)
			mem_cache.value = "󰍛 " .. used_gb .. "GB"
			mem_cache.last_time = now
			return mem_cache.value
		end

		require("tabby").setup({
			line = function(line)
				return {
					{
						{ "  ", hl = theme.custom4 },
						line.sep("", theme.custom4, theme.fill),
					},
					{
						line.sep("", theme.memcolor, theme.fill),
						{ " " .. get_memory() .. " ", hl = theme.memcolor },
						line.sep("", theme.memcolor, theme.fill),
					},

					{
						line.sep("", theme.pathcolor, theme.fill),
						{ " 󰣞 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " ", hl = theme.pathcolor },
						line.sep("", theme.pathcolor, theme.fill),
					},

					line.truncate_point(),

					line.spacer(),

					(function()
						local all_tabs = vim.api.nvim_list_tabpages()
						local total = #all_tabs
						local current_tabid = vim.api.nvim_get_current_tabpage()

						local current_idx = 1
						for i, tid in ipairs(all_tabs) do
							if tid == current_tabid then
								current_idx = i
								break
							end
						end

						-- bir tabın kapladığı görsel genişliği (kolon) ölçer
						local function tab_width(tabid, idx)
							local wins = vim.api.nvim_tabpage_list_wins(tabid)
							local name = require("tabby.feature.tab_name").get(tabid)
							local w = vim.fn.strdisplaywidth(name)
							w = w + 2 -- iki separator
							w = w + 2 -- margin (her iki yanda birer boşluk)
							w = w + 1 -- jump_key
							w = w + 3 -- file_icon + arasındaki boşluklar

							local ok, modified = pcall(function()
								for _, wn in ipairs(wins) do
									if vim.bo[vim.api.nvim_win_get_buf(wn)].modified then
										return true
									end
								end
								return false
							end)
							if ok and modified then
								w = w + 2
							end
							return w
						end

						-- tablara kalan gerçek bütçe hesabı
						local total_cols = vim.o.columns
						local left_fixed = vim.fn.strdisplaywidth(
							"   " .. get_memory() .. "  󰣞 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. "  "
						) + 12

						-- DİNAMİK SAĞ BOŞLUK HESAPLAMASI (SPLIT PENCERELER İÇİN)
						local dynamic_right_reserve = 0
						local current_wins = vim.api.nvim_tabpage_list_wins(current_tabid)
						local hidden_filetypes_buf = {
							Avante = true,
							AvanteInput = true,
							AvanteSelectedFiles = true,
							snacks_layout_box = true,
						}

						for _, wid in ipairs(current_wins) do
							local buf = vim.api.nvim_win_get_buf(wid)
							local ft = vim.bo[buf].filetype
							if not hidden_filetypes_buf[ft] then
								local buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
								if buf_name == "" then
									buf_name = "[No Name]"
								end
								dynamic_right_reserve = dynamic_right_reserve + vim.fn.strdisplaywidth(buf_name) + 10
							end
						end
						dynamic_right_reserve = dynamic_right_reserve + 10

						local budget = total_cols - left_fixed - dynamic_right_reserve
						if budget < 20 then
							budget = 20
						end

						-- aktif tabtan başlayıp iki yöne genişleyerek pencereyi kur
						local start_idx = current_idx
						local end_idx = current_idx
						local used = tab_width(all_tabs[current_idx], current_idx)

						local expand = true
						while expand do
							expand = false
							-- sağa genişlet
							if end_idx < total then
								local w = tab_width(all_tabs[end_idx + 1], end_idx + 1)
								if used + w <= budget then
									end_idx = end_idx + 1
									used = used + w
									expand = true
								end
							end
							-- sola genişlet
							if start_idx > 1 then
								local w = tab_width(all_tabs[start_idx - 1], start_idx - 1)
								if used + w <= budget then
									start_idx = start_idx - 1
									used = used + w
									expand = true
								end
							end
						end

						-- 🌟 GÖSTERGELER (İçerik rengi theme.indicator_text yani MAVİ yapıldı)
						local left_indicator = ""
						if start_idx > 1 then
							left_indicator = {
								line.sep("", theme.tab, theme.fill),
								{ "◀ " .. (start_idx - 1) .. "", hl = theme.indicator_text },
								line.sep("", theme.tab, theme.fill),
								hl = theme.tab,
								margin = " ",
							}
						end

						local right_indicator = ""
						if end_idx < total then
							right_indicator = {
								line.sep("", theme.tab, theme.fill),
								{ "" .. (total - end_idx) .. " ▶", hl = theme.indicator_text },
								line.sep("", theme.tab, theme.fill),
								hl = theme.tab,
								margin = " ",
							}
						end

						-- TABLARI LİSTELE
						local rendered_tabs = line.tabs().foreach(function(tab)
							local idx = 1
							for i, tid in ipairs(all_tabs) do
								if tid == tab.id then
									idx = i
									break
								end
							end

							if idx < start_idx or idx > end_idx then
								return ""
							end

							local hl = tab.is_current() and theme.current_tab or theme.tab
							local wins = vim.api.nvim_tabpage_list_wins(tab.id)

							local modified = false
							for _, w in ipairs(wins) do
								if vim.bo[vim.api.nvim_win_get_buf(w)].modified then
									modified = true
									break
								end
							end

							local duplicated = is_duplicated(tab.id, wins)

							local clean_tab_name = require("tabby.feature.tab_name").get(tab.id)

							return {
								line.sep("", hl, theme.fill),
								tab.jump_key(),
								tab.current_win().file_icon(),
								clean_tab_name,
								modified and {
									" ",
									hl = { fg = tab.is_current() and colors.bg or colors.blue, bg = hl.bg },
								} or "",
								duplicated and { " 󰆑", hl = { fg = colors.dup, bg = hl.bg } } or "",
								line.sep("", hl, theme.fill),
								hl = hl,
								margin = " ",
							}
						end)

						return {
							left_indicator,
							rendered_tabs,
							right_indicator,
						}
					end)(),

					line.spacer(),

					line.truncate_point(),
					line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
						local win_hl = win.is_current() and theme.custom2 or theme.custom5
						local buf = vim.api.nvim_win_get_buf(win.id)
						local ft = vim.bo[buf].filetype

						local hidden_filetypes_buf = {
							Avante = true,
							AvanteInput = true,
							AvanteSelectedFiles = true,
							snacks_layout_box = true,
						}
						if hidden_filetypes_buf[ft] then
							return ""
						end

						return {
							{
								line.sep("", win_hl, theme.fill),
								win.file_icon(),
								win.buf_name(),
								line.sep("", win_hl, theme.fill),
								hl = win_hl,
								margin = " ",
							},
						}
					end),

					{
						line.sep("", theme.custom3, theme.fill),
						{ "  ", hl = theme.custom3 },
					},
					hl = theme.fill,
				}
			end,

			option = {
				tab_name = {
					name_fallback = function(tabid)
						local win = vim.api.nvim_tabpage_get_win(tabid)
						local buf = vim.api.nvim_win_get_buf(win)
						return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
					end,
				},
				buf_name = {
					mode = "tail",
				},
			},
		})
		vim.keymap.set("n", "<leader>tj", "<Cmd>Tabby jump_to_tab<CR>", { desc = "Jump to tab" })

		vim.keymap.set("n", "<leader>tr", function()
			local name = vim.fn.input("Tab name (empty to reset): ")
			vim.cmd("Tabby rename_tab " .. name)
		end, { desc = "Rename tab" })
	end,
}
