-- See `:help restore-cursor`
local restore_group = vim.api.nvim_create_augroup("RestoreGroup", { clear = true })
vim.api.nvim_create_autocmd("BufRead", {
	command = [[call setpos(".", getpos("'\""))]],
	group = restore_group,
	pattern = "*",
})
