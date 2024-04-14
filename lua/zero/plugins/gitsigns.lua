local setup, gitsigns = pcall(require, "gitsigns")
if not setup then
	return
end

gitsigns.setup()

vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>")
-- vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk_inline<CR>")
