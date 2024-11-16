-- Vim options ( which is set in .vim )


-- Nerd fonts installed in terminal
vim.g.have_nerd_font = true

-- Sync clipboard with OS
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Make the numbers appear next to line
vim.opt.number = true

-- Enable mouse mode
vim.opt.mouse = "a"

-- Set intendation to 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.shiftwidth = 4

-- Enable undo even after closing and reopening the file
vim.opt.undofile = true

-- Signcolumn allows you to show errors and warnings inline 
vim.opt.signcolumn = "yes"

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, when replacing a text as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20

