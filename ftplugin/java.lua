-- local jdtls_bin = vim.fn.stdpath("data") .. "/home/empilan/.local/share/nvim/mason/bin/jdtls"
local function nnoremap(rhs, lhs, bufopts, desc)
	bufopts.desc = desc
	vim.keymap.set("n", rhs, lhs, bufopts)
end

local config = {

	cmd = { "/home/empilan/.local/share/nvim/mason/bin/jdtls" },
	root_dir = vim.fs.dirname(
		vim.fs.find({ "gradlew", ".git", "mvnw", "pom.xml", "build.gradle" }, { upward = true })[1]
	),
}

local bufopts = { noremap = true, silent = true, buffer = bufnr }
local on_attach = function(client, bufnr) end

nnoremap("<leader>ca", vim.lsp.buf.code_action, bufopts, "Code actions")
nnoremap("<leader>rn", vim.lsp.buf.rename, bufopts, "Rename")
nnoremap("<leader>D", vim.lsp.buf.type_definition, bufopts, "Go to type definition")
nnoremap("gD", vim.lsp.buf.declaration, bufopts, "Go to declaration")
nnoremap("K", vim.lsp.buf.hover, bufopts, "Hover text")
nnoremap("gd", vim.lsp.buf.definition, bufopts, "Go to definition")
nnoremap("gi", vim.lsp.buf.implementation, bufopts, "Go to implementation")
-- nnoremap("<C-k>", vim.lsp.buf.signature_help, bufopts, "Show signature")
nnoremap("<leader>ev", require("jdtls").extract_variable, bufopts, "Extract variable")
nnoremap("<leader>ec", require("jdtls").extract_constant, bufopts, "Extract constant")

-- local jdtls = require("jdtls")
--
-- local opts = { noremap = true, silent = true }

--  <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
-- nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
-- vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
-- nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
-- vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
-- vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>
--
--
-- " If using nvim-dap
-- " This requires java-debug and vscode-java-test bundles, see install steps in this README further below.
-- nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
-- nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>

-- vim.api.nvim_set_keymap("n", "<leader>la", "<cmd>lua require('jdtls').extract_method<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev<CR>", opts)
--
--

-- local bufopts = { noremap = true, silent = true }

require("jdtls").start_or_attach(config)
-- jdtls.start_or_attach(config)
