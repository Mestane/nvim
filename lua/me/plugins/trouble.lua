return {
    "folke/trouble.nvim",
    opts = {

        focus = true, -- Focus the window when opened

        modes = {
            test = {
                mode = "diagnostics",
                preview = {
                    type = "split",
                    relative = "win",
                    position = "right",
                    size = 0.4,
                },
            },

            symbols_custom = {
                mode = "symbols",
                win = {
                    -- position = "right",
                    position = "bottom",
                    size = 0.2,
                },
                -- preview = {
                    -- 	type = "split",
                    -- 	position = "right",
                    -- 	size = 0.5,
                    -- },
                },
            },


        },
        cmd = "Trouble",
    }
