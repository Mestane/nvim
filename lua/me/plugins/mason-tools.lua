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
            -- "stylua",
            -- Docs / misc
            "marksman",
            "lemminx",
            -- HTTP
            "kulala-fmt",

        },
        run_on_start = true,
        auto_update = true,
    },
}
