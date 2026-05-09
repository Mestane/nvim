return {
	"mg979/vim-visual-multi",
	bracnh = "master",
	event = "BufReadPost",
	init = function()
		vim.g.VM_maps = {
			["find Under"] = "<C-n>",
			["Find Subword Under"] = "<C-n>",
			["Add Cursor Down"] = "<C-Down>",
			["Add Cursor Up"] = "<C-Up>",
			["Exit"] = "<Esc>",
			["Goto Next"] = "}",
			["Goto Prev"] = "{",
		}
		vim.g.VM_theme = "sand"
		vim.g.VM_add_cursor_at_pos_no_mapping = 1
	end,
}
