-- local telescope_setup, telescope = pcall(require, "telescope")
-- if not telescope_setup then
-- 	return
-- end
--
-- local actions_setup, actions = pcall(require, "telescope.actions")
-- if not actions_setup then
-- 	return
-- end
--
-- telescope.setup({
--
-- 	defaults = {
-- 		file_ignore_patterns = {
-- 			".git/",
-- 			".cache",
-- 			"%.class",
-- 			"%.zip",
-- 			"%.mp4",
-- 			"%.mkv",
-- 			"%.pdf",
-- 			"%.jpeg",
-- 			"%.jpg",
-- 			"%.JPG",
-- 			"%.ttf",
-- 			"%.flat",
-- 			"%.svg",
-- 			"%.png",
-- 		},
-- 		vimgrep_arguments = {
-- 			"rg",
-- 			"-L",
-- 			"--color=never",
-- 			"--no-heading",
-- 			"--with-filename",
-- 			"--line-number",
-- 			"--column",
-- 			"--smart-case",
-- 		},
-- 		prompt_prefix = "   ",
-- 		selection_caret = "  ",
-- 		entry_prefix = "  ",
-- 		initial_mode = "insert",
-- 		selection_strategy = "reset",
-- 		sorting_strategy = "ascending",
-- 		layout_strategy = "vertical",
-- 		mappings = {
-- 			i = {
-- 				["<C-k>"] = actions.move_selection_previous,
-- 				["<C-j>"] = actions.move_selection_next,
-- 				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
-- 			},
-- 		},
-- 		layout_config = {
-- 			horizontal = {
-- 				prompt_position = "top",
-- 				preview_width = 0.55,
-- 				results_width = 0.8,
-- 			},
-- 			vertical = {
-- 				prompt_position = "bottom",
-- 				preview_width = 0.55,
-- 				results_width = 0.8,
-- 				--	mirror = false,
-- 			},
-- 			width = 0.87,
-- 			height = 0.50,
-- 			preview_cutoff = 120,
-- 		},
-- 	},
--
-- 	pickers = {
-- 		find_files = {
-- 			theme = "dropdown",
-- 			layout_config = {
-- 				-- preview_width = 0.55,
-- 				width = 0.60,
-- 				height = 0.30,
-- 			},
-- 		},
-- 	},
-- })
--
-- telescope.load_extension("fzf")
-- ---------------------------------------------------------
--
--
-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

-- configure telescope
telescope.setup({
	-- configure custom mappings

	defaults = {
		file_ignore_patterns = {
			".git/",
			".cache",
			"%.class",
			"%.zip",
			"%.mp4",
			"%.mkv",
			"%.pdf",
			"%.jpeg",
			"%.jpg",
			"%.JPG",
			"%.ttf",
			"%.flat",
			"%.svg",
			"%.png",
		},

		-- sorting_strategy = "ascending",

		-- vimgrep_arguments = {
		-- 	"rg",
		-- 	"-L",
		-- 	"--color=never",
		-- 	"--no-heading",
		-- 	"--with-filename",
		-- 	"--line-number",
		-- 	"--column",
		-- 	"--smart-case",
		-- },

		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "vertical",
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous, -- move to prev result
				["<C-j>"] = actions.move_selection_next, -- move to next result
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
			},
		},
	},
})

telescope.load_extension("fzf")
