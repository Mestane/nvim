# nvim config file

neovim customized for general IDE.
![Screenshot from 2024-04-14 18-28-53](https://github.com/Mestane/nvim/assets/67807483/f4128b35-6931-4931-bab6-091a871260fe)

## installation

If you have nvim config folder, make a backup

```bash
mv -r ~/.config/nvim ~/.config/nvim.bak
```

then download this nvim config folder and move **_~/.config_** directory

```bash
cd
git clone https://github.com/Mestane/nvim.git
mv -r ~/nvim ~/.config/
```

> [!NOTE]
> After install delete **_.git and .github_** folder in nvim and
> Check your terminal font
> install some nerd fonts **Recommended[Meslo nerd font](https://github.com/ryanoasis/nerd-fonts)**

```bash
cd nvim
rm -rf .git .github
```

## Some Shortcuts

- `<prefix>` is the default neovim ( **(\ backslash)** )
- `jj` Escape insert mode
- `Ctrl + s` Save file
- `q` Close save file or quit neovim **(_if you use macros delete or change this shortcut_)**
- `Space` Escape visual mode
- `Alt + 1` Toggle nvim tree
- `Ctrl + h` Go to right split
- `Ctrl + l` Go to left split
- `Ctrl + j` Go to down split
- `Ctrl + k` Go to up split
- `Alt + k` Go to next tab
- `Alt + j` Go to previous tab
- `<leader> ff` Telescope find files
- `<leader> fs` Telescope live grep
- `<leader> fb` Telescope buffers
- `<leader> fc` Telescope grep string
- `<leader> ca` Open code action
- `Alt + m` Toggle maximize split window

**_All these shortcuts are in /lua/zero/core/keymap.lua file._**

## Installed plugins

[packer](https://github.com/wbthomason/packer.nvim), [sg nvim](https://github.com/sourcegraph/sg.nvim), [plenary](https://github.com/nvim-lua/plenary.nvim), [catppuccin](https://github.com/catppuccin/nvim),
[vim-maximizer](https://github.com/szw/vim-maximizer), [vim-surround](https://github.com/tpope/vim-surround), [comment](https://github.com/numToStr/Comment.nvim), [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua),
[lualine](https://github.com/nvim-lualine/lualine.nvim), [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons),[telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim),
[telescope](https://github.com/nvim-telescope/telescope.nvim),[nvim-tabline](https://github.com/crispgm/nvim-tabline), [vim-easymotion](https://github.com/easymotion/vim-easymotion),
[nui nvim](https://github.com/MunifTanjim/nui.nvim), [nvim-cmp](https://github.com/hrsh7th/nvim-cmp), [cmp-buffer](https://github.com/hrsh7th/cmp-buffer), [cmp-path](https://github.com/hrsh7th/cmp-path),
[LuaSnip](https://github.com/L3MON4D3/LuaSnip), [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip), [friendly-snippets](https://github.com/rafamadriz/friendly-snippets),
[mason](https://github.com/williamboman/mason.nvim), [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim), [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig),
[lspkind](https://github.com/onsails/lspkind.nvim), [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim), [mason-null-ls](https://github.com/jay-babu/mason-null-ls.nvim),
[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter), [vim-cool](https://github.com/romainl/vim-cool), [nvim-autopairs](https://github.com/windwp/nvim-autopairs),
[nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag), [gitsings](https://github.com/lewis6991/gitsigns.nvim), [vim-fugitive](https://github.com/tpope/vim-fugitive),
[indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim), [jdtls](https://github.com/mfussenegger/nvim-jdtls), [alpha-nvim](https://github.com/goolord/alpha-nvim), [bufferline](https://github.com/akinsho/bufferline.nvim),
[dressing](https://github.com/stevearc/dressing.nvim), [telescope-ui-select](https://github.com/nvim-telescope/telescope-ui-select.nvim), [which-key](https://github.com/folke/which-key.nvim), [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects),
[colortils](https://github.com/nvim-colortils/colortils.nvim), [nvim-colorizer](https://neovimcraft.com/plugin/NvChad/nvim-colorizer.lua), [vim-visual-multi](https://github.com/mg979/vim-visual-multi),
[cosco](https://github.com/lfilho/cosco.vim), [neoscroll](https://github.com/karb94/neoscroll.nvim)
