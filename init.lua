-- if vim.g.neovide then
-- 	vim.g.neovide_cursor_vfx_mode = "railgun"
-- 	vim.o.guifont = "Source Code Pro:h14" -- text below applies for VimScript
-- 	vim.g.neovide_padding = 3
-- end
require("zero.plugins-setup")
require("zero.core.options")
require("zero.core.keymaps")
require("zero.core.colorscheme")
require("zero.plugins.comment")
require("zero.plugins.nvim-tree")
require("zero.plugins.lualine")
require("zero.plugins.nvim-web-devicons")
require("zero.plugins.telescope")
require("zero.plugins.nvim-cmp")
require("zero.plugins.lsp.mason")
require("zero.plugins.lsp.lspconfig")
require("zero.plugins.lsp.null-ls")
require("zero.plugins.autopairs")
require("zero.plugins.treesitter")
require("zero.plugins.gitsigns")
require("zero.plugins.tabline")
--require("zero.plugins.alpha-nvim")
require("zero.plugins.vim-easymotion")
require("zero.plugins.colortils")
require("zero.plugins.colorizer")

require("zero.plugins.visual-multi")
require("zero.plugins.fugitive")
-- require("zero.plugins.sg")

-- require("zero.plugins.neoscroll")
-- require("zero.plugins.cosco")
-- require("zero.plugins.nui-nvim")
-- require("zero.plugins.noice")

----------------------------------------------------
-- require("zero.plugins.indent-blankline")
-- require("zero.plugins.notify")

--require("zero.plugins.bufferline")
-- init.lua dosyanıza ekleyin
-- vim.cmd("autocmd VimEnter * set scroll=9")
------------------------------------------------------------------------
--
-- vim.g.neovide_cursor_vfx_mode = "torpedo"
-- vim.g.neovide_cursor_vfx_mode = "sonicboom"
-- vim.g.neovide_cursor_vfx_mode = "ripple"
