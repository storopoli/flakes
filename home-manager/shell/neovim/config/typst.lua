-- typst misc
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
	pattern = { "*.typ", "*.typst" },
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		vim.cmd.setfiletype("typst")
		vim.bo[bufnr].shiftwidth = 2
		vim.bo[bufnr].softtabstop = 2
		vim.bo[bufnr].expandtab = true
	end,
})
