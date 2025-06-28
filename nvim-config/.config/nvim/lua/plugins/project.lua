return {
	"DrKJeff16/project.nvim",
	config = function()
		require("project_nvim").setup({
			detection_methods = { "lsp", "pattern" },
			patterns = { ".git", "Makefile", "package.json" },
			show_hidden = true,
			silent_chdir = false,
			scope_chdir = "global",
		})
	end,
}
