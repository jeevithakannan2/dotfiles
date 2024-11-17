return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettier, -- For JavaScript/TypeScript/HTML/CSS
					null_ls.builtins.formatting.black, -- For Python
					null_ls.builtins.formatting.stylua, -- For Lua
				},
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = { "williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim" },
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "prettier", "black", "stylua" }, -- Add desired formatters
				automatic_installation = true,
			})
		end,
	}
}
