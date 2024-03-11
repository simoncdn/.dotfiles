return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"html",
					"lua",
					"markdown",
					"vim",
					"vimdoc",
					"javascript",
					"typescript",
					"comment",
					"prisma",
					"tsx",
					"vue",
					"tmux",
					"json",
					"cmake",
					"css",
					"html",
					"json5",
					"prisma",
					"scss",
					"gitcommit",
					"gitignore",
					"git_rebase",
					"gitattributes",
					"git_config",
					"markdown",
					"markdown_inline",
					"dockerfile",
				},
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
			})
		end,
	},
}
