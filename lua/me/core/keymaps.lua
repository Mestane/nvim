local keymap = vim.keymap

keymap.set("i", "jj", "<ESC>")
keymap.set("n", "x", '"_x')
keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })

keymap.set("n", "q", ":q<CR>", { noremap = true, silent = true })
-- keymap.set("n", "q", ":bdelete<CR>", { noremap = true, silent = true }) -- Close the saved file

keymap.set("n", "<C-q>", ":qall<CR>", { noremap = true, silent = true })
keymap.set("v", "<Space>", "<ESC>")
keymap.set("n", "<M-.>", "za", { noremap = true, silent = true })

keymap.set("n", "<M-k>", ":tabn<CR>", { noremap = true, silent = true })
keymap.set("n", "<M-j>", ":tabp<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-w><A-l>", "<CMD>wincmd r<CR>", { silent = true })
vim.keymap.set("n", "<C-w><A-h>", "<CMD>wincmd R<CR>", { silent = true })

keymap.set("n", ">", "<C-w>>")
keymap.set("n", "<", "<C-w><")
keymap.set("n", "+", "<C-w>+")
keymap.set("n", "-", "<C-w>-")

keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-l>", "<Right>")
-- keymap.set("i", "<C-j>", "<Down>")
-- keymap.set("i", "<C-k>", "<Up>")
--
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- keymap.set("n", "<Enter>", "o<Esc>", { noremap = true, silent = true })
keymap.set("n", "<C-M-o>", "O<Esc>", { noremap = true, silent = true })

keymap.set("n", "<CR>", "o<Esc>", { noremap = true, silent = true })

vim.keymap.set("n", "<M-CR>", "i<CR><Esc>", {
	desc = "Split line like Insert Enter",
})

keymap.set("i", "<M-CR>", "<Esc>o", { noremap = true, silent = true })
keymap.set("n", "<C-u>", "9<C-u>", { noremap = true, silent = true })
keymap.set("n", "<C-d>", "9<C-d>", { noremap = true, silent = true })
keymap.set("v", "<C-y>", '"+y', { noremap = true, silent = true })

keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { noremap = true, silent = true })
-- keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { noremap = true, silent = true })


vim.keymap.set("n", "<leader>p", "<cmd>PasteImage<cr>", { desc = "Paste image from clipboard" })
