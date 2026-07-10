local jdtls_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local plugins_dir = jdtls_dir .. "/plugins/"
local path_to_jar = vim.fn.glob(plugins_dir .. "org.eclipse.equinox.launcher_*.jar")
-- local path_to_jar = vim.fn.glob(plugins_dir .. "org.eclipse.equinox.launcher_*.jar", true, true)[1] or ""
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
local jdtls_bin = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
-- local jdtls_java = "/usr/lib/jvm/java-26-openjdk/bin/java"

if root_dir == "" then
	return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name

local bundles = {
	vim.fn.glob(vim.fn.stdpath("data") .. "/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar"),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(vim.fn.stdpath("data") .. "/mason/share/java-test/*.jar"), "\n"))

-- Spring Boot Tools
-- vim.list_extend(bundles, require("spring_boot").java_extensions())

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
	capabilities = blink.get_lsp_capabilities(capabilities)
end
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "documentation", "detail", "additionalTextEdits" },
	-- properties = { "documentation", },
}

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	opts.desc = "Go to declaration"
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

	vim.keymap.set("n", "gd", function()
		local word = vim.fn.expand("<cword>")

		local source_buf = vim.api.nvim_get_current_buf()
		local node = vim.treesitter.get_node()
		local arg_count = -1

		while node do
			if node:type() == "method_invocation" then
				for child in node:iter_children() do
					if child:type() == "argument_list" then
						local args = vim.treesitter.get_node_text(child, source_buf)
						args = args:gsub("^%(", ""):gsub("%)$", ""):gsub("%s+", "")
						if args == "" then
							arg_count = 0
						else
							local _, count = args:gsub(",", "")
							arg_count = count + 1
						end
					end
				end
				break
			end
			node = node:parent()
		end

		vim.lsp.buf.definition({
			on_list = function(options)
				if not options or not options.items or #options.items == 0 then
					return
				end
				---@diagnostic disable-next-line: param-type-mismatch
				vim.fn.setqflist({}, " ", options)
				vim.cmd("cfirst")
				vim.schedule(function()
					local pos = vim.api.nvim_win_get_cursor(0)
					if pos[1] <= 1 then
						local parser = vim.treesitter.get_parser(0, "java")
						if not parser then
							vim.fn.search("\\<" .. word .. "\\>", "w")
							return
						end
						local tree = parser:parse()[1]
						local root = tree:root()
						local query = vim.treesitter.query.parse(
							"java",
							[[
	                       (method_declaration
	                           name: (identifier) @method_name
	                           parameters: (formal_parameters) @params)
	                   ]]
						)
						for id, node2, _ in query:iter_captures(root, 0) do
							local capture_name = query.captures[id]
							if capture_name == "method_name" then
								local name = vim.treesitter.get_node_text(node2, 0)
								if name == word then
									local param_node = node2:next_named_sibling()
									if param_node and arg_count >= 0 then
										local params_text = vim.treesitter.get_node_text(param_node, 0)
										params_text = params_text:gsub("^%(", ""):gsub("%)$", ""):gsub("%s+", "")
										local param_count = 0
										if params_text ~= "" then
											local _, cnt = params_text:gsub(",", "")
											param_count = cnt + 1
										end
										if param_count == arg_count then
											local row, col = node2:start()
											vim.api.nvim_win_set_cursor(0, { row + 1, col })
											return
										end
									else
										local row, col = node2:start()
										vim.api.nvim_win_set_cursor(0, { row + 1, col })
										return
									end
								end
							end
						end
						vim.fn.search("\\<" .. word .. "\\>", "w")
					end
				end)
			end,
		})
	end, opts)

	opts.desc = "Show LSP definitions"
	vim.keymap.set("n", "gv", vim.lsp.buf.definition, opts)

	opts.desc = "Show LSP implementations"
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

	opts.desc = "Show LSP type definitions"
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

	opts.desc = "See available code actions"
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

	opts.desc = "Smart rename"
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	opts.desc = "Show line diagnostics"
	vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

	vim.keymap.set("n", "[d", function()
		vim.diagnostic.jump({ count = -1, float = true })
	end, opts)

	vim.keymap.set("n", "]d", function()
		vim.diagnostic.jump({ count = 1, float = true })
	end, opts)

	opts.desc = "Show documentation for what is under cursor"
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	vim.keymap.set(
		"v",
		"<leader>rv",
		"<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
		{ desc = "Java Extract Variable" }
	)
	vim.keymap.set(
		"v",
		"<leader>rc",
		"<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
		{ desc = "Java Extract Constant" }
	)
	vim.keymap.set(
		"v",
		"<leader>rm",
		"<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
		{ desc = "Java Extract Method" }
	)
end

local config = {
	cmd = {
		-- "env",
		-- "JAVA_HOME=/usr/lib/jvm/java-26-openjdk",
		jdtls_bin,
		-- jdtls_java,
		-- "-javaagent:" .. vim.fn.stdpath("data") .. "/mason/share/jdtls/lombok.jar", -- --jvm-arg= olmadan
		"--jvm-arg=" .. string.format("-javaagent:%s", vim.fn.stdpath("data") .. "/mason/share/jdtls/lombok.jar"),
		--------------------------------------------------------------------------------------------------------------
		-- "--jvm-arg=-javaagent:" .. vim.fn.stdpath("data") .. "/mason/share/jdtls/lombok.jar",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		path_to_jar,
		"-configuration",
		vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_linux",
		"-data",
		workspace_dir,
	},
	root_dir = root_dir,
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		java = {
			configuration = {
				runtimes = {
					{ name = "JavaSE-11", path = "/usr/lib/jvm/java-11-openjdk", default = true },
					{ name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk" },
					{ name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk" },
					{ name = "JavaSE-26", path = "/usr/lib/jvm/java-26-openjdk" },
				},
				-- updateBuildConfiguration = "interactive",
			},
			-- project = {
			-- 	-- Tell jdtls about both source dirs
			-- 	sourcePaths = {
			-- 		"src/main/java",
			-- 		"src/main/kotlin", -- jdtls indexes .class output, not .kt sources
			-- 	},
			-- },
			--
			--
			--
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
				},
				importOrder = { "java", "javax", "com", "org" },
				guessMethodArguments = true,
				filteredTypes = {
					"com.sun.*",
					"sun.*",
					"jdk.*",
					"java.awt.*",
				},
			},
			--
			--
			--
			-- contentProvider = { preferred = "fernflower" },
			contentProvider = { preferred = "cfr" },
			jdt = {
				ls = {
					lombokSupport = { enabled = true },
				},
			},
			maven = { downloadSources = true },
			eclipse = { downloadSources = true },
			references = { includeDecompiledSources = true },
			referencesCodeLens = { enabled = false },
			implementationCodeLens = { enabled = false },
			signatureHelp = { enabled = true },
			inlayHints = {
				parameterNames = { enabled = "all" },
			},
		},
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
	},
	init_options = {
		bundles = bundles,
		-- extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
	},
}

require("jdtls").start_or_attach(config)
