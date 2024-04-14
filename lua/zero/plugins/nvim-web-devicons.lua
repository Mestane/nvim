local setup, nvimDevIcons = pcall(require, "nvim-web-devicons")
if not setup then
    return
end


nvimDevIcons.setup()



--return {
--  "nvim-tree/nvim-web-devicons",
--  config = function()
--    require("nvim-web-devicons").set_icon({
--      gql = {
--       -- icon = "",
--        color = "#e535ab",
--        cterm_color = "199",
--        name = "GraphQL",
--      },
--    })
--  end,
--}
