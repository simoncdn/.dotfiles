return {
	{
		"nvim-treesitter/nvim-treesitter",

		build = ":TSUpdate",

		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"bash",
					"cmake",
					"comment",
					"css",
					"dockerfile",
					"gitcommit",
					"gitignore",
					"git_rebase",
					"gitattributes",
					"git_config",
					"html",
					"javascript",
					"json",
					"json5",
					"lua",
					"make",
					"markdown",
					"markdown_inline",
					"prisma",
					"python",
					"scss",
					"sql",
					"tmux",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"vue",
					"xml",
					"yaml",
				},
				sync_install = false,
				auto_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
