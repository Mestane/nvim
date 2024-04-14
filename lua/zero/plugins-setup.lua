local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever your save this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	use({ "wbthomason/packer.nvim" }) -- Plugin manager with Packer

	-- Packer.nvim, also make sure to install nvim-lua/plenary.nvim
	use({ "sourcegraph/sg.nvim", run = "nvim -l build/init.lua" })
	use({ "nvim-lua/plenary.nvim" }) -- Lua functions that many plugins use
	use({ "catppuccin/nvim", as = "catppuccin" }) -- Catppuccin theme
	use({ "szw/vim-maximizer" }) -- Maximizes and restore current window
	use({ "tpope/vim-surround" }) -- Handles tag
	use({ "numToStr/Comment.nvim" }) -- Commenting gc
	use({ "nvim-tree/nvim-tree.lua" }) -- File explorer
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	use({ "kyazdani42/nvim-web-devicons" }) -- Icons
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })
	use({
		"crispgm/nvim-tabline",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional
	})
	use({
		"easymotion/vim-easymotion",
	})
	use({ "MunifTanjim/nui.nvim" })

	-- use({
	-- 	"folke/noice.nvim",
	-- 	-- event = "VeryLazy",
	-- 	-- opts = {
	-- 	-- add any options here
	-- 	-- },
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	--
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- })

	use({ "hrsh7th/nvim-cmp" }) --
	use({ "hrsh7th/cmp-buffer" }) -- Autocompletion
	use({ "hrsh7th/cmp-path" }) --

	use({ "L3MON4D3/LuaSnip" }) --
	use({ "saadparwaiz1/cmp_luasnip" }) -- Snippets
	use({ "rafamadriz/friendly-snippets" }) --

	use({ "williamboman/mason.nvim" }) -- Install lsp servers
	use({ "williamboman/mason-lspconfig.nvim" }) -- Managing lsp servers

	use({ "neovim/nvim-lspconfig" }) -- Configuring lsp servers
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "onsails/lspkind.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- Linter
	use({ "jayp0521/mason-null-ls.nvim" }) -- Formatters

	use({
		"nvim-treesitter/nvim-treesitter", -- treesitter
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})

	use({
		"romainl/vim-cool",
	})
	use({ "windwp/nvim-autopairs" })
	use({ "windwp/nvim-ts-autotag" })
	use({ "lewis6991/gitsigns.nvim" })
	use({ "tpope/vim-fugitive" })
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "mfussenegger/nvim-jdtls" })
	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	})
	use({ "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" })

	use({ "stevearc/dressing.nvim" })
	use({ "nvim-telescope/telescope-ui-select.nvim" })

	-- Lua
	use({
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
		requires = "nvim-treesitter/nvim-treesitter",
	})

	use({
		"max397574/colortils.nvim",
		cmd = "Colortils",
		config = function()
			require("colortils").setup()
		end,
	})
	use("NvChad/nvim-colorizer.lua")
	use({ "mg979/vim-visual-multi" })
	use({ "lfilho/cosco.vim" })
	use("karb94/neoscroll.nvim")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
