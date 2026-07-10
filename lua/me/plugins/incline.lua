return {
	"b0o/incline.nvim",
	dependencies = {
		-- "SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	config = function()
		-- local helpers = require("incline.helpers")
		-- local navic = require("nvim-navic")
		local devicons = require("nvim-web-devicons")

		require("incline").setup({
			hide = {
				only_win = false,
			},
			highlight = {
				groups = {
					InclineNormal = { guibg = "#131317", guifg = "none" },
					InclineNormalNC = { guibg = "#131317", guifg = "none" },
				},
			},

			render = function(props)
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
				if filename == "" then
					filename = "[No Name]"
				end
				local ft_icon, ft_color = devicons.get_icon_color(filename)

				-- İnaktif için soluk renk
				local inactive_fg = "#585b70" -- Catppuccin surface2, istediğinle değiştir

				local function get_git_diff()
					local icons = { removed = "", changed = "", added = "" }
					local signs = vim.b[props.buf].gitsigns_status_dict
					local labels = {}
					if signs == nil then
						return labels
					end
					for name, icon in pairs(icons) do
						if tonumber(signs[name]) and signs[name] > 0 then
							table.insert(labels, {
								icon .. signs[name] .. " ",
								group = props.focused and ("Diff" .. name) or nil,
								guifg = props.focused and nil or inactive_fg,
							})
						end
					end
					if #labels > 0 then
						table.insert(labels, { "┊ ", guifg = props.focused and nil or inactive_fg })
					end
					return labels
				end

				local function maximize_status(focused)
					if not vim.t.maximized then
						return {}
					end
					return { " 󰃻 ┊ ", gui = "bold", guifg = focused and "#F5E0DC" or inactive_fg }
				end

				local function get_diagnostic_label()
					local icons = { error = "", warn = "", info = "", hint = "" }
					local label = {}
					for severity, icon in pairs(icons) do
						local n = #vim.diagnostic.get(
							props.buf,
							{ severity = vim.diagnostic.severity[string.upper(severity)] }
						)
						if n > 0 then
							table.insert(label, {
								icon .. n .. " ",
								group = props.focused and ("DiagnosticSign" .. severity) or nil,
								guifg = props.focused and nil or inactive_fg,
							})
						end
					end
					if #label > 0 then
						table.insert(label, { "┊ ", guifg = props.focused and nil or inactive_fg })
					end
					return label
				end

				-- İnaktif icon rengi: soluklaştır
				local icon_color = props.focused and ft_color or inactive_fg

				return {
					-- { maximize_status() },
					{ maximize_status(props.focused) },
					{ get_diagnostic_label() },
					{ get_git_diff() },
					{ (ft_icon or "") .. " ", guifg = icon_color, guibg = "none" },
					{
						filename .. " ",
						gui = (props.focused and vim.bo[props.buf].modified) and "bold,italic"
							or props.focused and "bold"
							or nil,
						guifg = not props.focused and inactive_fg or vim.bo[props.buf].modified and "#f9e2af" or nil,
					},
					{
						{
							"┊  " .. vim.api.nvim_win_get_number(props.win),
							group = props.focused and "DevIconWindows" or nil,
							guifg = not props.focused and inactive_fg or nil,
						},
						-- guifg = props.focused and nil or inactive_fg,
					},
				}
			end,
		})
	end,
}
