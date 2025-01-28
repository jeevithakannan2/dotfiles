return {
	--[[vim.api.nvim_create_autocmd("CursorHold", {
		callback = function()
			vim.lsp.buf.hover()
		end,
		group = vim.api.nvim_create_augroup("HoverOnHold", { clear = true }),
	}),]]

}
