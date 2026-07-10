return {

	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true, opts = {} },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- optional but recommended
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
	{
		"b0o/schemastore.nvim",
		lazy = true,
	},
	{ "romainl/vim-cool" },
	{ "MunifTanjim/nui.nvim" },
	{ "stevearc/dressing.nvim" },
	{
		"lambdalisue/vim-suda",
		lazy = false,
		init = function()
			vim.g.suda_smart_edit = 1
		end,
	},
	{ "mfussenegger/nvim-jdtls" },
	{ "rafamadriz/friendly-snippets" },
	{ "windwp/nvim-ts-autotag", opts = {} },
	{
		"wintermute-cell/gitignore.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Gitignore",
		keys = {
			{ "<leader>Gi", "<cmd>lua require('gitignore').generate()<cr>", desc = "Generate .gitignore" },
		},
		config = function()
			require("gitignore")
		end,
	},
	-- { "lukas-reineke/virt-column.nvim", opts = {} },
	-- {
	-- 	"Bekaboo/deadcolumn.nvim",
	-- 	enabled = false,
	-- 	config = function()
	-- 		require("deadcolumn").setup()
	-- 	end,
	-- },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
}
