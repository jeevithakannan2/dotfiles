-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Nvim-tree keymaps
local nvim_tre = require("nvim-tree.api")
vim.keymap.set('n', '<leader>e', function() nvim_tre.tree.toggle() end, { desc = 'Toggle nvim-tree' })

-- Clear search highlight on ESC
vim.keymap.set('n', '<ESC>', ':noh<CR>', { noremap = true, silent = true })

-- Map `K` to `Lspsaga` hover doc
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { noremap = true, silent = true })

-- Fidget
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "LSP Code Action" })

-- Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Telescope projects keymap
vim.keymap.set("n", "<leader>fp", function()
	require("telescope").extensions.projects.projects()
end, { noremap = true, silent = true, desc = "Find Projects" })
