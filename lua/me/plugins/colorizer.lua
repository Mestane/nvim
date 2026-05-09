return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
        filetypes = {
            "*",
            "!vim",
            css = { parsers = { rgb = { enable = true } } },
            html = { parsers = { names = { enable = false } } },
        },
        options = {
            parsers = {
                names = { enable = true },
                hex = { default = true },
                rgb = { enable = true },
            },
            display = {
                mode = "background",
            },
        },
    },
}
