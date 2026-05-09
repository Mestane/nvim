-- local opt = vim.opt -- for conciseness

-- line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- tabs & indentation
vim.opt.expandtab = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
-- vim.opt.softtabstop = 1

vim.g.suda_smart_edit = 1

vim.opt.autoindent = true

vim.opt.smartindent = false

-- vim.opt.clipboard = "unnamedplus"
-- line wrapping
vim.opt.wrap = false
vim.opt.laststatus = 3

-- vim.bo.formatexpr = ""
-- vim.bo.formatprg = "jq"

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- cursor line
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
--
-- opt.syntax = true
vim.opt.splitkeep = "screen"

vim.o.foldmethod = "expr"

-- vim.o.foldmethod = "indent"

-- vim.o.foldmethod = "manual"
vim.o.foldenable = true -- Fold özelliği açık kalsın
vim.o.foldlevel = 99 -- Açılışta tüm fold'lar açık olsun
vim.o.foldlevelstart = 99 -- Fold seviyesini açık başlat

-- appearance
vim.opt.termguicolors = true

vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

-- backspace
vim.opt.backspace = "indent,eol,start"

-- opt.startofline = false
-- clipborad
--opt.clipboard:append("unnamedplus")
--

-- scrollstep according
vim.opt.scrolloff = 10 -- degisti
--
-- opt.scroll = 5

-- split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

--opt.iskeyword:append("-")
vim.opt.iskeyword:remove("_")
--
-- turn off swapfile
vim.opt.swapfile = false

vim.opt.viewoptions = "folds,cursor,slash,unix" -- yeni eklendi.

-- opt.guicursor = { "a:blinkon100", "n:block", "i:ver25", "c:ver25" } -- change nvim modes cursor gui
vim.opt.guicursor = {
	"n-v-c:block-blinkon500",
	"i-ci:ver25-blinkon500",
	"r-cr:hor20",
	"o:hor50",
	"a:blinkwait700-blinkon400-blinkoff250",
}

-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos"
-- -----------------------------------------------------------------------------------------------------------
-- opt.guicursor={n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait10-blinkon400-blikoff300}

-- vim.o.hlsearch = false
-- opt.hlsearch = true
-- opt.incsearch = true
--

vim.o.conceallevel = 1

vim.opt.mousemoveevent = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "java", "lua", "yaml", "json" },
	callback = function()
		-- vim.opt_local.number = false
		-- vim.opt_local.relativenumber = false
		-- vim.opt_local.cursorline = false
		-- vim.opt_local.softtabstop = 1
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})

local kitty_socket = string.format("unix:@kitty-%s", vim.fn.getenv("KITTY_PID"))
local last_color = nil

local function set_tab_color(color)
	if color == last_color then
		return
	end
	last_color = color

	vim.loop.spawn("kitty", {
		args = { "@", "--to", kitty_socket, "set-colors", "active_tab_background=" .. color },
		detached = true,
	}, function() end)
end

-- local timer = vim.loop.new_timer()
local timer = assert(vim.loop.new_timer(), "Failed to create timer")

--
vim.api.nvim_create_autocmd("ModeChanged", {
	callback = function()
		-- Snacks picker input'unda çalışma
		local ft = vim.bo.filetype
		if ft == "snacks_picker_input" or ft == "snacks_input" then
			return
		end

		local mode = vim.fn.mode()
		local color
		if mode == "i" then
			color = "#a6e3a1"
		elseif mode == "v" or mode == "V" or mode == "\22" then
			color = "#cba6f7"
		else
			color = "#89b4fa"
		end
		timer:stop()
		timer:start(
			20,
			0,
			vim.schedule_wrap(function()
				set_tab_color(color)
			end)
		)
	end,
})
