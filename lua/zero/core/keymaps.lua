-- 						GENERAL KEYMAPS
-- Default keymap is "\"
--
-- vim.g.mapleader = " "                                     -- Map default leader key

local keymap = vim.keymap -- for conciseness

--                                       KEYMAPS
--      FILE KEYMAPS
--
keymap.set("i", "jj", "<ESC>") -- Escape insert mode

-- keymap.set("n", "<leader>ch", ":nohl<CR>") -- Hidden search words

keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true }) -- Save the file

keymap.set("n", "x", '"_x') -- Delete letter cursor above cursor

keymap.set("n", "q", ":q<CR>", { noremap = true, silent = true }) -- Close the (saved file) file
keymap.set("n", "/", "<Plug>(easymotion-sn)", { noremap = true, silent = true })
keymap.set("v", "<Space>", "<ESC>") -- Exit visual mode (when you're on visual mode hit space button)
--keymap.set("n","<leader>+","<C-a>")                         -- Increase the number
--keymap.set("n","<leader>-","<C-x>")                         -- Decrease the number
--
--      SPLIT KEYMAPS ( Not Recommended below keymaps, Use Default Split setting hit Ctrl-w after (v,s,=) )
--      'v' = vertical, 's' = horizontal, '=' = restore split resize
--
--keymap.set("n","<leader>sv","<C-w>v")                       -- Split window vertically
--keymap.set("n","<leader>sh","<C-w>s")                       -- Split window horizontally
--keymap.set("n","<leader>se","<C-w>=")                       -- Make split windows equal width
--keymap.set("n","<leader>sx","<C-w>:close<CR>")              -- Close current split window
--
--      TAB KEYMAPS
--
--
--keymap.set("n", "<leader>to", ":tabnew<CR>") -- Open new tab
--
--keymap.set("n", "<leader>tx", ":tabclose<CR>") -- Close current tab
keymap.set("n", "<M-k>", ":tabn<CR>", { noremap = true, silent = true }) -- Go to next tab(default)

keymap.set("n", "<M-j>", ":tabp<CR>", { noremap = true, silent = true }) -- Go to previous tab(default)

--keymap.set("n","<leader>tn",":tabn<CR>")                    -- Go to next tab
--
--keymap.set("n","<leader>tp",":tabp<CR>")                    -- Go to previous tab
--
--      SPLIT NAVIGATION
--
keymap.set("n", "<C-l>", "<C-w>l") -- Go to right split
keymap.set("n", "<C-h>", "<C-w>h") -- Go to left split
keymap.set("n", "<C-j>", "<C-w>j") -- Go to down split
keymap.set("n", "<C-k>", "<C-w>k") -- Go to top split
keymap.set("n", "<M-m>", ":MaximizerToggle<CR>", { noremap = true, silent = true }) -- Maximizer Split normal mode
--keymap.set("i", "<M-m>", ":MaximizerToggle<CR>") -- Maximizer Split insert mode
--
--

keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-l>", "<Right>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("i", "<C-k>", "<Up>")
--
--
--
--
-- ["<C-h>"] = { "<Left>", "Move left" },
-- ["<C-l>"] = { "<Right>", "Move right" },
-- ["<C-j>"] = { "<Down>", "Move down" },
-- ["<C-k>"] = { "<Up>", "Move up" },
--
--
--
--
--
--      NVIM-TREE
--
--keymap.set("n", "<M-1>", ":NvimTreeToggle<CR>") -- Toogle nvim-tree
--
--      TELESCOPE
--
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<cr>")
keymap.set("n", "<leader>fg", "<cmd>Telescope current_buffer_fuzzy_find<cr>")

-- Moving line in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center cursor after moving down half-page" })
-- keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center cursor after moving up half-page" })

-- keymap.set("n", "<CR>", "m`o<Esc>``")
-- keymap.set("n", "<S-CR>", "m`O<Esc>``")

-- keymap.set("n", "<S-CR>", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")
-- keymap.set("n", "<S-CR>", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")

-- keymap.set("n", "<Space>", "i<Space><Esc>")
--
--
-- keymap.set("n", "<M-CR>", "O<Esc>", { noremap = true, silent = true })
-- keymap.set("n", "<CR>", "o<Esc>", { noremap = true, silent = true })

keymap.set("n", "<Enter>", "o<Esc>", { noremap = true, silent = true })

-- keymap.set("n", "<M-1>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
--
-- place this in one of your configuration file(s)
--

--
-- vim.api.nvim_set_keymap("n", "<leader>n", "<Plug>(easymotion-next)", {})
--
-- vim.api.nvim_set_keymap("n", "<leader>N", "<Plug>(easymotion-prev)", {})

keymap.set("n", "/", "<Plug>(easymotion-sn)", { noremap = true, silent = true })
keymap.set("o", "/", "<Plug>(easymotion-tn)", { noremap = true, silent = true })
-- Easymotion'un n ve N tuşları için keymap'leri
keymap.set("n", ",", "<Plug>(easymotion-prefix)", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<Leader>;", "<Plug>(cosco-commaOrSemiColon)", { silent = true })
-- vim.api.nvim_set_keymap("i", "<Leader>;", "<c-o><Plug>(cosco-commaOrSemiColon)", { silent = true })
keymap.set("n", "<M-Enter>", "<Plug>(cosco-commaOrSemiColon)", { silent = true })
keymap.set("i", "<M-Enter>", "<c-o><Plug>(cosco-commaOrSemiColon)", { silent = true })
