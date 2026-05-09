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
			-- java = { "google-java-format" },
			kotlin = { "ktlint" },
			javascript = { "prettier" },
			css = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			http = { "kulala" },
			toml = { "tombi" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			bash = { "shfmt" },
			rust = { "rustfmt" },
		},
		formatters = {
			-- ["google-java-format"] = {
			-- 	command = "google-java-format",
			-- 	args = { "--aosp", "-" },
			-- 	stdin = true,
			-- },
			ruff_fix = {
				prepend_args = { "--select", "I" },
			},
			kulala = {
				command = "kulala-fmt",
				args = { "format", "$FILENAME" },
				stdin = false,
			},
			-- excluded
			prettier = {
				prepend_args = function(self, ctx)
					local excluded = { "%.md$", "%.css$", "%.html$" }
					for _, pattern in ipairs(excluded) do
						if ctx.filename:match(pattern) then
							return {}
						end
					end
					return { "--tab-width", "4" }
				end,
			},

			-- included
			-- prettier = {
			-- 	prepend_args = function(self, ctx)
			-- 		local included = { "%.ya?ml$", "%.json$" }
			-- 		for _, pattern in ipairs(included) do
			-- 			if ctx.filename:match(pattern) then
			-- 				return { "--tab-width", "4" }
			-- 			end
			-- 		end
			-- 		return {}
			-- 	end,
			-- },

			-- prettier = {
			-- 	prepend_args = function(self, ctx)
			-- 		if ctx.filename:match("%.ya?ml$") then
			-- 			return { "--tab-width", "4" }
			-- 		end
			-- 		return {}
			-- 	end,
			-- },
		},
	},
}
