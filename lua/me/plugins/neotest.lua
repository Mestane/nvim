return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-plenary",
			"nvim-neotest/neotest-vim-test",
			{
				"rcasia/neotest-java",
				dependencies = {
					"mfussenegger/nvim-dap",
					"rcarriga/nvim-dap-ui",
				},
			},
		},
		config = function()
			local neotest = require("neotest")
			local adapters = {}

			local ok_java, neotest_java = pcall(require, "neotest-java")
			if ok_java then
				table.insert(adapters, neotest_java({ dap = { justMyCode = false } }))
			end

			table.insert(adapters, require("neotest-plenary"))
			table.insert(adapters, require("neotest-vim-test")({
				ignore_file_types = { "python", "vim", "lua" },
			}))

			neotest.setup({
				adapters = adapters,
				quickfix = { enabled = true, open = false },
				output = { enabled = true, open_on_run = true, open_on_error = false },
			})
		end,
		keys = {
			{ "<leader>tt", function()
				local neotest = require("neotest")
				neotest.run.run()
				neotest.summary.open()
			end, desc = "Run nearest test + open summary" },
			{ "<leader>tf", function()
				local neotest = require("neotest")
				neotest.run.run(vim.fn.expand("%"))
				neotest.summary.open()
			end, desc = "Run file tests + open summary" },
			{ "<leader>td", function()
				require("neotest").run.run({ strategy = "dap" })
			end, desc = "Debug nearest test" },
			{ "<leader>ts", function()
				require("neotest").summary.toggle()
			end, desc = "Toggle test summary" },
			{ "<leader>to", function()
				require("neotest").output.open({ enter = true })
			end, desc = "Open test output" },
			{ "<leader>tO", function()
				require("neotest").output_panel.toggle()
			end, desc = "Toggle test output panel" },
			{ "<leader>tS", function()
				require("neotest").run.stop()
			end, desc = "Stop test run" },
		},
	},

}
