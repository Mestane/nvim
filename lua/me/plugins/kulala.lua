return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
	opts = {
		default_env = "dev",
		environment_scope = "b",
		halt_on_error = true,
		infer_content_type = true,

		contenttypes = {
			["application/json"] = {
				ft = "json",
				formatter = vim.fn.executable("jq") == 1 and { "jq", "." },
				pathresolver = function(...)
					return require("kulala.parser.jsonpath").parse(...)
				end,
			},
			["application/graphql"] = {
				ft = "graphql",
				formatter = vim.fn.executable("prettier") == 1
				and { "prettier", "--stdin-filepath", "graphql", "--parser", "graphql" },
				pathresolver = nil,
			},
			["application/xml"] = {
				ft = "xml",
				formatter = vim.fn.executable("xmllint") == 1 and { "xmllint", "--format", "-" },
				pathresolver = vim.fn.executable("xmllint") == 1 and { "xmllint", "--xpath", "{{path}}", "-" },
			},
			["text/html"] = {
				ft = "html",
				formatter = vim.fn.executable("xmllint") == 1 and { "xmllint", "--format", "--html", "-" },
				pathresolver = nil,
			},
		},

		debug = 3,
		generate_bug_report = false,
		ui = {
			display_mode = "split",
			split_direction = "vertical",
			default_view = "body",
			winbar = true,
			default_winbar_panes = { "body", "headers", "headers_body", "verbose", "script_output", "report", "help" },
			show_variable_info_text = false,
			show_icons = "on_request",
			icons = {
				inlay = { loading = "⏳", done = "✅", error = "❌" },
				lualine = "🐼",
				textHighlight = "WarningMsg",
			},
			syntax_hl = {
				["@punctuation.bracket.kulala_http"] = "Number",
				["@character.special.kulala_http"] = "Special",
				["@operator.kulala_http"] = "Special",
				["@variable.kulala_http"] = "String",
			},
			show_request_summary = true,
			disable_script_print_output = false,
			report = {
				show_script_output = true,
				show_asserts_output = true,
				show_summary = true,
				headersHighlight = "Special",
				successHighlight = "String",
				errorHighlight = "Error",
			},

			scratchpad_default_contents = {
				"@MY_TOKEN_NAME=my_token_value",
				"",
				"# @name scratchpad",
				"POST https://httpbin.org/post HTTP/1.1",
				"accept: application/json",
				"content-type: application/json",
				"",
				"{",
				'  "foo": "bar"',
				"}",
			},


			disable_news_popup = false,
			lua_syntax_hl = true,
		},
		lsp = {
			enable = true,
			keymaps = {
				["<leader>ls"] = { vim.lsp.buf.document_symbol, desc = "Search Symbols" },
				["<leader>lt"] = { "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols outline" },
				["<leader>lS"] = { function() require("aerial").toggle() end, desc = "Symbols outline" },
				["K"] = { vim.lsp.buf.hover, desc = "Hover" },
				["<leader>la"] = { vim.lsp.buf.code_action, desc = "Code Action" },
			},
			formatter = {
				sort = { metadata = true, variables = true, commands = false, json = true },
			},
		},
		global_keymaps = {
			["Send request"] = {
				"<leader>Rs",
				function() require("kulala").run() end,
				mode = { "n", "v" },
				desc = "Send request",
			},
			["Send all requests"] = {
				"<leader>Ra",
				function() require("kulala").run_all() end,
				mode = { "n", "v" },
				ft = "http",
			},
			["Replay the last request"] = {
				"<leader>Rr",
				function() require("kulala").replay() end,
				ft = { "http", "rest" },
			},
			["Find request"] = false,
		},
		global_keymaps_prefix = "<leader>R",
		kulala_keymaps = {
			["Show headers"] = { "H", function() require("kulala.ui").show_headers() end },
			["Show body"] = { "B", function() require("kulala.ui").show_body() end },
			["Show headers and body"] = { "A", function() require("kulala.ui").show_headers_body() end },
			["Show verbose"] = { "V", function() require("kulala.ui").show_verbose() end },
			["Show script output"] = { "O", function() require("kulala.ui").show_script_output() end },
			["Show stats"] = { "S", function() require("kulala.ui").show_stats() end },
			["Show report"] = { "R", function() require("kulala.ui").show_report() end },
			["Show filter"] = { "F", function() require("kulala.ui").toggle_filter() end },
			["Send WS message"] = { "<S-CR>", function() require("kulala.cmd.websocket").send() end, mode = { "n", "v" } },
			["Interrupt requests"] = { "<C-c>", function() require("kulala.cmd.websocket").close() end },
			["Next response"] = { "]", function() require("kulala.ui").show_next() end },
			["Previous response"] = { "[", function() require("kulala.ui").show_previous() end },
			["Jump to response"] = { "<CR>", function() require("kulala.ui").jump_to_response() end },
			["Clear responses history"] = { "X", function() require("kulala.ui").clear_responses_history() end },
			["Show help"] = { "?", function() require("kulala.ui").show_help() end },
			["Show news"] = { "g?", function() require("kulala.ui").show_news() end },
			["Toggle split/float"] = { "|", function() require("kulala.ui").toggle_display_mode() end, prefix = false },
			["Close"] = { "q", function() require("kulala.ui").close_kulala_buffer() end },
		},
		kulala_keymaps_prefix = "",
	},
}
