return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Enhance LSP capabilities with nvim-cmp
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Auto format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})

		-- Bash
		lspconfig.bashls.setup({
			capabilities = capabilities,
		})

		-- Rust
		lspconfig.rust_analyzer.setup {}

		-- HTML
		lspconfig.html.setup({
			capabilities = capabilities,
		})

		-- Error detection
		lspconfig.superhtml.setup({})

		-- CSS
		lspconfig.cssls.setup({
			capabilities = capabilities,
		})

		-- Deno LSP
		lspconfig.denols.setup({
			--			root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
			filetypes = { "javascript" },
			capabilities = capabilities,
		})

		--[[ TypeScript/JavaScript LSP
		lspconfig.ts_ls.setup({
			root_dir = lspconfig.util.root_pattern("package.json"),
			filetypes = { "javascript" },
			single_file_support = true,
			capabilities = capabilities,
		}) ]]

		-- Python LSP
		lspconfig.pyright.setup({
			filetypes = { "python" },
			capabilities = capabilities,
		})

		-- Dart LSP ( Flutter )
		lspconfig.dartls.setup {}

		-- Lua LSP
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT", -- Neovim uses LuaJIT
					},
					diagnostics = {
						globals = { "vim" }, -- Recognize `vim` as a global
					},
				},
			},
			capabilities = capabilities,
		})
	end,
}
