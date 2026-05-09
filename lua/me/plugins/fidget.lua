return {
    "j-hui/fidget.nvim",

    opts = {
        progress = {
            suppress_on_insert = true,
            ignore_done_already = true,
            ignore_empty_message = true,
            display = {
                render_limit = 0,
                -- done_ttl = 1,
                -- progress_ttl = 3,
                -----------------------------------
                done_ttl = 0,
                progress_ttl = 0,
            },
        },
        notification = {
            override_vim_notify = false,
            window = {
                winblend = 0,
            },
        },
    },

}
