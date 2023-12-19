require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		-- navigation
		vim.keymap.set("n", "]h", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, buffer = bufnr })
		vim.keymap.set("n", "[h", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, buffer = bufnr })
		-- actions
		vim.keymap.set({ "n", "v" }, "<leader>hs", "<CMD>Gitsigns stage_hunk<CR>", { buffer = bufnr })
		vim.keymap.set({ "n", "v" }, "<leader>hr", "<CMD>Gitsigns reset_hunk<CR>", { buffer = bufnr })
		vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr })
		vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr })
		vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr })
		vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr })
		vim.keymap.set("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, { buffer = bufnr })
		vim.keymap.set("n", "<leader>hB", gs.toggle_current_line_blame, { buffer = bufnr })
		vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr })
		vim.keymap.set("n", "<leader>hD", function()
			gs.diffthis("~")
		end, { buffer = bufnr })
		vim.keymap.set("n", "<leader>ht", gs.toggle_deleted, { buffer = bufnr })
		-- Text object
		vim.keymap.set({ "o", "x" }, "ih", "<CMD><C-U>Gitsigns select_hunk<CR>", { buffer = bufnr })
	end,
})
