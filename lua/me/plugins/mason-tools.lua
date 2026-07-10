return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
	},
	opts = {
		ensure_installed = {
			-- Java
			"google-java-format",
			-- Kotlin
			"ktlint",
			-- Web
			"prettier",
			"ruff", -- "ruff-format",
			-- "shfmt", -- "bash,mksh,shell",
			"beautysh",
			-- Lua
			"stylua",
			-- Docs / misc
			"marksman",
			"lemminx",
			-- HTTP
			"kulala-fmt",
			"bash-language-server",
			"css-lsp",
			"dockerfile-language-server",
			"emmet-ls",
			"gopls",
			"hyprls",
			"java-debug-adapter",
			"java-test",
			"clangd",
			"jdtls",
			"jq-lsp",
			"json-lsp",
			"kotlin-debug-adapter",
			"kotlin-language-server",
			"ktlint",
			"lua-language-server",
			"pyright",
			"qmlls",
			"rust-analyzer",
			"svelte-language-server",
			"tailwindcss-language-server",
			"tombi",
			"typescript-language-server",
			"vscode-spring-boot-tools",
			"yaml-language-server",
		},
		run_on_start = true,
		auto_update = true,
	},
}
