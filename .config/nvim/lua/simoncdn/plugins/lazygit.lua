return {
	"kdheepak/lazygit.nvim",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	keys = {
		{ "<leader>lg", "<cmd>LazyGit<Cr>", desc = "Open lazygit" },
	},
}