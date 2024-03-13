return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
		config = function()
			require("gitsigns").setup()

			vim.keymap.set("n", "<leader>gsh", ":Gitsigns preview_hunk<CR>", {})
			vim.keymap.set("n", "<leader>gsl", ":Gitsigns toggle_current_line_blame<CR>", {})
		end,
	},
}
