local home = vim.env.HOME
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

local on_attach = function(client, bufnr)
	opts.buffer = bufnr

	opts.desc = "Go to declaration"
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

	opts.desc = "Show LSP definitions"
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

	opts.desc = "Show LSP implementations"
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

	opts.desc = "See available code actions"
	keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

	opts.desc = "Smart rename"

	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	opts.desc = "Show line diagnostics"
	keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float({
			border = "rounded",
			source = true,
			scope = "cursor",
		})
	end, opts)

	keymap.set("n", "[d", function()
		vim.diagnostic.jump({
			count = -1,
			float = { border = "rounded", source = true },
		})
	end, { desc = "Go to previous diagnostic" })

	keymap.set("n", "]d", function()
		vim.diagnostic.jump({
			count = 1,
			float = { border = "rounded", source = true },
		})
	end, { desc = "Go to next diagnostic" })

	opts.desc = "Show documentation for what is under cursor"
	keymap.set("n", "K", vim.lsp.buf.hover, opts)
end

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
	capabilities = blink.get_lsp_capabilities(capabilities)
end

-- Diagnostic signs
local signs = {
	[vim.diagnostic.severity.ERROR] = "",
	[vim.diagnostic.severity.WARN] = "",
	[vim.diagnostic.severity.HINT] = "",
	[vim.diagnostic.severity.INFO] = "",
}

local icons = {
	[vim.diagnostic.severity.ERROR] = " ",
	[vim.diagnostic.severity.WARN] = " ",
	[vim.diagnostic.severity.INFO] = " ",
	[vim.diagnostic.severity.HINT] = " ",
}

local colors = {
	[vim.diagnostic.severity.ERROR] = "DiagnosticError",
	[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
	[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
	[vim.diagnostic.severity.HINT] = "DiagnosticHint",
}

vim.diagnostic.config({
	signs = {
		text = signs,
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
		},
	},
	update_in_insert = false,
	severity_sort = true,
	virtual_text = false,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = function(diag)
			return icons[diag.severity], colors[diag.severity]
		end,
		format = function(diag)
			return string.format("%s %s", diag.code and "[" .. diag.code .. "]" or "", diag.message)
		end,
	},
})

vim.opt.updatetime = 300

-- LSP configs
vim.lsp.config("jsonls", {
	capabilities = capabilities,
	on_attach = on_attach,
	-- settings = {
	-- 	json = {
	-- 		schemas = require("schemastore").json.schemas(),
	-- 		validate = { enable = true },
	-- 	},
	-- },
})
vim.lsp.config("dockerls", { capabilities = capabilities, on_attach = on_attach })

vim.lsp.config("hyprls", {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "hyprls" },
	filetypes = { "hyprlang" },
	root_dir = vim.fn.expand("~/.config/hypr"),
	-- root_dir = vim.fn.getcwd(),
	settings = {
		hyprls = {
			preferIgnoreFile = true,
			ignore = { "hyprlock.conf", "hypridle.conf" },
		},
	},
})
--

vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	root_markers = { "Cargo.toml" },
	settings = {
		["rust-analyzer"] = {
			rustfmt = { overrideCommand = { "rustfmt" } },
			diagnostics = { enable = true, experimental = { enable = true } },
			check = { command = "clippy", enable = false },
			cargo = { allFeatures = true },
			procMacro = { enable = true },
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("cssls", { capabilities = capabilities, on_attach = on_attach })

vim.lsp.config("bashls", {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash", "zsh" },
	root_markers = { ".git", ".bashrc", ".bash_profile" },
})

vim.lsp.config("gopls", { capabilities = capabilities, on_attach = on_attach })

vim.lsp.config("pyright", {
	root_markers = { ".git", "setup.py", "setup.cfg", "pyproject.toml" },
	settings = {
		python = {
			venvPath = home .. "/.pyenv/versions",
			venv = "fabric-widget",
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
				autoImportCompletions = true,
				indexing = true,
				typeCheckingMode = "basic",
				reportUndefinedVariable = "warning",
				reportMissingImports = "error",
				reportUnusedImport = "error",
			},
		},
	},
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.config("emmet_ls", {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		-- "html",
		-- "typescriptreact",
		-- "javascriptreact",
		"css",
		"sass",
		"scss",
		"less",
		"svelte",
	},
})

vim.lsp.config("lemminx", { capabilities = capabilities, on_attach = on_attach })
vim.lsp.config("jqls", { capabilities = capabilities, on_attach = on_attach })
vim.lsp.config("marksman", { capabilities = capabilities, on_attach = on_attach, filetypes = { "markdown" } })

-- vim.lsp.config("kotlin_language_server", {
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- })
--
vim.lsp.config("kotlin_language_server", {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "kotlin-language-server" },
	filetypes = { "kotlin", "kt", "kts" },
	root_markers = {
		"settings.gradle",
		"settings.gradle.kts",
		"build.gradle",
		"build.gradle.kts",
		"pom.xml",
	},
	-- settings = {
	-- 	kotlin = {
	-- 		compiler = { jvm = { target = "21" } },
	-- 		completion = { snippets = { enabled = true } },
	-- 	},
	-- },
})

vim.lsp.config("yamlls", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		yaml = {
			schemaStore = {
				enable = false, -- schemastore catalog'u otomatik indirir
				url = "",
				-- url = "https://www.schemastore.org/api/json/catalog.json",
			},
			schemas = require("schemastore").yaml.schemas(),
			validate = true,
			completion = true,
			hover = true,
		},
	},
})

vim.lsp.config("clangd", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.config("ts_ls", {
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "non-relative",
			includeInlayParameterNameHints = "literals",
		},
	},
})

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim", "Snacks" } },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

-- Enable LSP servers
-- vim.lsp.enable("vscode-spring-boot-tools")
vim.lsp.enable("dockerls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("cssls")
vim.lsp.enable("bashls")
vim.lsp.enable("hyprls")
vim.lsp.enable("clangd")
vim.lsp.enable("gopls")
-- vim.lsp.enable("qmlls")
vim.lsp.enable("jsonls")
vim.lsp.enable("pyright")
vim.lsp.enable("emmet_ls")
vim.lsp.enable("lemminx")
vim.lsp.enable("jqls")
vim.lsp.enable("marksman")
vim.lsp.enable("kotlin_language_server")
vim.lsp.enable("yamlls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("ts_ls")

vim.api.nvim_set_hl(0, "@lsp.mod.static", { italic = true })
