local setup, easymotion = pcall(require, "vim-easymotion")
if not setup then
	return
end

easymotion.setup({

	-- 	-- Easymotion'un arama sonrasında vurgulamayı kapatma
	-- 	vim.api.nvim_exec(
	-- 		[[
	--     augroup DisableSearchHighlight
	--         autocmd!
	--         autocmd VimEnter,WinEnter * set nohlsearch
	--     augroup END
	-- ]],
	-- 		false
	-- 	),
})
