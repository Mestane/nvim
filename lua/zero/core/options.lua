local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
-- opt.tabstop = 4
-- opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
-- opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipborad
--opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

--opt.iskeyword:append("-")
--
-- turn off swapfile
opt.swapfile = false

opt.guicursor = { "a:blinkon100", "n:block", "i:ver25", "c:ver25" } -- change nvim modes cursor gui
-- opt.guicursor={n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait10-blinkon400-blikoff300}

-- scrollstep according
opt.scrolloff = 9
opt.scroll = 9

-- vim.o.hlsearch = false
-- opt.hlsearch = true
-- opt.incsearch = true
