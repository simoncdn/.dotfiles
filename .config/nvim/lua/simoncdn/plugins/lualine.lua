return {
	"nvim-lualine/lualine.nvim",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local lualine = require("lualine")

		lualine.setup({
			options = {
				icons_enabled = true,
				theme = "catppuccin",
				normal = {
					c = { bg = nil },
				},
				insert = {
					c = { bg = nil },
				},
				visual = {
					c = { bg = nil },
				},
				replace = {
					c = { bg = nil },
				},
				command = {
					c = { bg = nil },
				},
				inactive = {
					c = { bg = nil },
				},
				-- component_separators = { left = '', right = '' },
				-- section_separators = { left = '', right = '' },
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { "filename" },

				lualine_x = { "diagnostics" },
				lualine_y = { "diff" },
				lualine_z = { "progress" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
