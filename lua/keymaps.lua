-- Map the leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear highlight when ESC is used in normal mode
vim.api.nvim_set_keymap('n', '<ESC>', ':noh<CR>', { noremap = true, silent = true })

-- Map `K` to `Lspsaga`'s hover doc
vim.api.nvim_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { noremap = true, silent = true })

-- Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set("n", "<leader>fp", function()
	require("telescope").extensions.projects.projects()
end, { noremap = true, silent = true, desc = "Find Projects" })
