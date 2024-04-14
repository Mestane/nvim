local status, cosco = pcall(require, "cosco")
if not status then
	return
end

cosco.setup({

	-- init.lua dosyası

	-- Otomatik grup oluştur
	vim.api.nvim_exec(
		[[
  augroup CustomMappings
    autocmd!
    autocmd FileType javascript,css,java nmap <silent> <Leader>; <Plug>(cosco-commaOrSemiColon)
    autocmd FileType javascript,css,java imap <silent> <Leader>; <S-CR><Plug>(cosco-commaOrSemiColon)
  augroup END
]],
		false
	),
})
