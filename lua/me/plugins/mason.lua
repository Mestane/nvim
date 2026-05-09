return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "cssls",
            "tailwindcss",
            "svelte",
            "lua_ls",
            "jdtls",
            "jqls",
            "graphql",
            "emmet_ls",
            "pyright",
            "bashls",
            "hyprls",
            -- "qmlls",
            "rust_analyzer",
            "jsonls",
            "yamlls",
            "gopls",
            "lemminx",
            "kotlin_language_server",
            "dockerls",
            "marksman",
        },
        automatic_installation = true,
        automatic_enable = false,

    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
