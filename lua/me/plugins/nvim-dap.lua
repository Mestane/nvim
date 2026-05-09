return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {
					enabled = true,
					enabled_commands = true,
					highlight_changed_variables = true,
					highlight_new_as_changed = true,
					show_stop_reason = false,
					commented = true,
					only_first_definition = true,
					all_references = false,
					clear_on_continue = false,
					display_callback = function(variable, buf, stackframe, node, options)
						if options.virt_text_pos == "inline" then
							return " = " .. variable.value:gsub("%s+", " ")
						else
							return variable.name .. " = " .. variable.value:gsub("%s+", " ")
						end
					end,
					virt_text_pos = "eol",
					all_frames = true,
					virt_lines = false,
					virt_text_win_col = 80,
				},
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			local sign = vim.fn.sign_define
			sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

			dapui.setup({})

			dap.adapters.kotlin = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/kotlin-debug-adapter",
				options = { auto_continue_if_many_stopped = false },
			}

			dap.configurations.kotlin = {
				{
					type = "kotlin",
					request = "launch",
					name = "This file",
					mainClass = function()
						local root = vim.fs.find("src", { path = vim.fn.getcwd(), upward = true, stop = vim.env.HOME })[1]
							or ""
						local fname = vim.api.nvim_buf_get_name(0)
						return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
					end,
					projectRoot = "${workspaceFolder}",
					jsonLogFile = "",
					enableJsonLogging = false,
				},
				{
					type = "kotlin",
					request = "launch",
					name = "Debug Main.kt",
					projectRoot = vim.fn.getcwd(),
					mainClass = function()
						local root = vim.fs.find("src", { path = vim.fn.getcwd(), upward = true, stop = vim.env.HOME })[1]
							or ""
						local fname = vim.api.nvim_buf_get_name(0)
						return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
					end,
				},
				{
					type = "kotlin",
					request = "launch",
					name = "Launch kotlin program",
					projectRoot = "${workspaceFolder}/app",
					mainClass = "AppKt",
				},
				{
					type = "kotlin",
					request = "attach",
					name = "Attach to debugging session",
					port = 5005,
					args = {},
					projectRoot = vim.fn.getcwd,
					hostName = "localhost",
					timeout = 2000,
				},
			}

			dap.configurations.java = {
				{
					name = "Debug Launch (2GB)",
					type = "java",
					request = "launch",
					vmArgs = "-Xmx2g ",
				},
				{
					name = "Debug Attach (8000)",
					type = "java",
					request = "attach",
					hostName = "127.0.0.1",
					port = 8000,
				},
				{
					name = "Debug Attach (5005)",
					type = "java",
					request = "attach",
					hostName = "127.0.0.1",
					port = 5005,
				},
				{
					name = "My Custom Java Run Configuration",
					type = "java",
					request = "launch",
					mainClass = "replace.with.your.fully.qualified.MainClass",
					vmArgs = "-Xmx2g ",
				},
			}

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
		end,
		keys = {
			{
				"<Leader>do",
				function()
					require("dapui").open()
				end,
				desc = "DAP UI Open",
			},
			{
				"<Leader>dq",
				function()
					require("dapui").close()
				end,
				desc = "DAP UI Close",
			},
			{
				"<Leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "DAP Terminate",
			},
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "DAP Continue",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "DAP Step Over",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "DAP Step Into",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "DAP Step Out",
			},
			{
				"<Leader>b",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "DAP Toggle Breakpoint",
			},
			{
				"<Leader>B",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "DAP Set Conditional Breakpoint",
			},
			{
				"<Leader>lp",
				function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end,
				desc = "DAP Set Log Point",
			},
			{
				"<Leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "DAP REPL Open",
			},
			{
				"<Leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "DAP Run Last",
			},
			{
				"<Leader>dh",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "DAP Hover",
				mode = { "n", "v" },
			},
			{
				"<Leader>dp",
				function()
					require("dap.ui.widgets").preview()
				end,
				desc = "DAP Preview",
				mode = { "n", "v" },
			},
			{
				"<Leader>df",
				function()
					local w = require("dap.ui.widgets")
					w.centered_float(w.frames)
				end,
				desc = "DAP Frames",
			},
			{
				"<Leader>dsc",
				function()
					local w = require("dap.ui.widgets")
					w.centered_float(w.scopes)
				end,
				desc = "DAP Scopes",
			},
		},
	},
}
