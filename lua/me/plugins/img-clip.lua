return {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
        default = {
            dir_path = "assets",
            file_name = "%Y-%m-%d-%H-%M-%S",
            extension = "png",
            prompt_for_file_name = false,
            relative_to_current_file = true,
            use_absolute_path = false,
            drag_and_drop = {
                enabled = true,
                insert_mode = false,
            },
        },
        filetypes = {
            markdown = {
                url_encode_path = true,
                template = "![$CURSOR]($FILE_PATH)",
                download_images = false,
            },
        },
    },
    keys = {
        { "<leader>p", "<cmd>PasteImage<CR>", desc = "Paste image from clipboard" },
    },
}
