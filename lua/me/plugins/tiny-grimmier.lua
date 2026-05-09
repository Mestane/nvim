return {
	"rachartier/tiny-glimmer.nvim",
	event = "VeryLazy",
	priority = 10, -- Low priority to catch other plugins' keybindings
	config = function()
		local ok, tiny = pcall(require, "tiny-glimmer")
		if not ok then
			return
		end

		local colors = {
			green = "#a6e3a1",
			mauve = "#cba6f7",
			red = "#f38ba8",
			maroon = "#eba0ac",
			teal = "#94e2d5",
			base = "#1e1e2e",
		}

		tiny.setup({
			enabled = true,
			disable_warnings = true,
			refresh_interval_ms = 8,
			overwrite = {
				auto_map = true,
				yank = {
					enabled = true,
					default_animation = {
						name = "fade",
						settings = {
							max_duration = 350,
							min_duration = 280,
							from_color = colors.green,
							to_color = colors.base,
							easing = "outQuad",
						},
					},
				},
				paste = {
					enabled = true,
					default_animation = {
						name = "reverse_fade",
						settings = {
							max_duration = 350,
							min_duration = 280,
							from_color = colors.mauve,
							to_color = colors.base,
							easing = "outBack",
						},
					},
				},
				undo = {
					enabled = true,
					default_animation = {
						name = "fade",
						settings = {
							max_duration = 400,
							min_duration = 350,
							from_color = colors.red,
							to_color = colors.base,
							easing = "outQuad",
						},
					},
				},
				redo = {
					enabled = true,
					default_animation = {
						name = "fade",
						settings = {
							max_duration = 400,
							min_duration = 350,
							from_color = colors.teal,
							to_color = colors.base,
							easing = "outQuad",
						},
					},
				},
			},
			hijack_ft_disabled = {
				"alpha",
				"snacks_dashboard",
				"lazy",
				"mason",
				"TelescopePrompt",
				"neo-tree",
				"nvim-tree",
			},
			virt_text = { priority = 2048 },
		})

		vim.defer_fn(function()
			local ok2, lib = pcall(require, "tiny-glimmer.lib")
			if not ok2 then
				return
			end

			local function animate_delete(range, duration)
				lib.create_animation({
					range = range,
					duration = duration or 200,
					from_color = colors.maroon,
					to_color = colors.base,
					effect = "fade",
				})
			end

			local function get_visual_range()
				local s = vim.fn.getpos("'<")
				local e = vim.fn.getpos("'>")
				return {
					start_line = s[2] - 1,
					start_col = s[3] - 1,
					end_line = e[2] - 1,
					end_col = e[3],
				}
			end

			local mappings = {
				{
					"n",
					"dd",
					function()
						animate_delete(lib.get_line_range(vim.fn.line(".")), 220)
						vim.defer_fn(function()
							vim.cmd("normal! dd")
						end, 70)
					end,
				},
				{
					"n",
					"D",
					function()
						local l, col = vim.fn.line("."), vim.fn.col(".")
						animate_delete({
							start_line = l - 1,
							start_col = col - 1,
							end_line = l - 1,
							end_col = vim.fn.col("$") - 1,
						}, 180)
						vim.defer_fn(function()
							vim.cmd("normal! D")
						end, 60)
					end,
				},
				{
					"n",
					"x",
					function()
						local l, col = vim.fn.line("."), vim.fn.col(".")
						animate_delete({
							start_line = l - 1,
							start_col = col - 1,
							end_line = l - 1,
							end_col = col,
						}, 150)
						vim.defer_fn(function()
							vim.cmd("normal! x")
						end, 50)
					end,
				},
				{
					"x",
					"d",
					function()
						vim.cmd("normal! \27")
						vim.schedule(function()
							animate_delete(get_visual_range(), 200)
							vim.defer_fn(function()
								vim.cmd("normal! gvd")
							end, 70)
						end)
					end,
				},
				{
					"x",
					"c",
					function()
						local range = get_visual_range()
						vim.cmd("normal! \27")
						animate_delete(range, 180)
						vim.defer_fn(function()
							vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("gvc", true, false, true), "n", false)
						end, 60)
					end,
				},
			}

			for _, map in ipairs(mappings) do
				vim.keymap.set(map[1], map[2], map[3])
			end
		end, 150)
	end,
}
