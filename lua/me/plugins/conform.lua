return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	keys = {
		{
			"<C-M-l>",
			function()
				require("conform").format({ lsp_fallback = true })
			end,
			desc = "Format (Conform)",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format", "ruff_fix" },
			-- python = { "ruff_format" },
			-- java = { "google-java-format" },
			kotlin = { "ktlint" },
			javascript = { "prettier" },
			css = { "prettier" },
			cpp = { "clang-format" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			http = { "kulala" },
			toml = { "tombi" },
			-- json = { "prettier" },
			yaml = { "prettier" },
			html = { "prettier" },
			markdown = { "prettier" },
			bash = { "shfmt" },
			rust = { "rustfmt" },
		},
		formatters = {
			ruff_fix = {
				args = { "check", "--fix", "--select", "I", "--force-exclude", "--stdin-filename", "$FILENAME", "-" },
				stdin = true,
			},
			kulala = {
				command = "kulala-fmt",
				args = { "format", "$FILENAME" },
				stdin = false,
			},
			-- excluded
			prettier = {
				prepend_args = function(self, ctx)
					-- local excluded = { "%.md$", "%.css$", "%.html$", "%.jsx$" }
					-- local excluded = { "%.md$", "%.css$", "%.html$" }
					local excluded = { "%.md$" }
					for _, pattern in ipairs(excluded) do
						if ctx.filename:match(pattern) then
							return {}
						end
					end
					return { "--tab-width", "4" }
				end,
			},

		},
	},
}
