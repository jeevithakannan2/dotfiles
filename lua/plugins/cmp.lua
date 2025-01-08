return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
		"hrsh7th/cmp-buffer", -- Buffer source
		"hrsh7th/cmp-path", -- Path source
		"hrsh7th/cmp-vsnip", -- Snippet source
		"hrsh7th/vim-vsnip", -- Snippet engine
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body) -- Snippet engine
				end,
			},
			mapping = {
				["<Tab>"] = cmp.mapping.select_next_item(), -- Next item
				["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Previous item
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
				["<C-Space>"] = cmp.mapping.complete(), -- Open completion menu
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- LSP completions
				{ name = "buffer" }, -- Buffer completions
				{ name = "path" }, -- Path completions
			}),
		})
	end,
}
