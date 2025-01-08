return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VimEnter",
	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { "%.git/", "%.git$", "node_modules", "%.DS_Store" },
				mappings = {
					i = {                    -- Insert mode
						["<C-j>"] = "move_selection_next", -- Move down
						["<C-k>"] = "move_selection_previous", -- Move up
						["<C-d>"] = "preview_scrolling_down", -- Scroll preview down
						["<C-u>"] = "preview_scrolling_up", -- Scroll preview up
					},
					n = {                    -- Normal mode
						["<C-d>"] = "preview_scrolling_down", -- Scroll preview down
						["<C-u>"] = "preview_scrolling_up", -- Scroll preview up
					},
				},
			},
		})
		require('telescope').load_extension('projects')
	end,
}
