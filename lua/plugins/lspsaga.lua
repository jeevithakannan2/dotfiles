return {
	"nvimdev/lspsaga.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lspsaga").setup({
			ui = {
				border = "rounded",
			},
		})
	end,
}
