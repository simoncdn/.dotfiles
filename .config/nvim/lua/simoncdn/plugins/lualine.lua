return {
	"nvim-lualine/lualine.nvim",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local lualine = require("lualine")
		local colors = require("tokyonight.colors").setup()
		local custom_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.black },
				b = { bg = colors.fg_gutter, fg = colors.blue },
				c = { bg = nil, fg = colors.fg_sidebar },
			},

			insert = {
				a = { bg = colors.green, fg = colors.black },
				b = { bg = colors.fg_gutter, fg = colors.green },
			},

			command = {
				a = { bg = colors.yellow, fg = colors.black },
				b = { bg = colors.fg_gutter, fg = colors.yellow },
			},

			visual = {
				a = { bg = colors.magenta, fg = colors.black },
				b = { bg = colors.fg_gutter, fg = colors.magenta },
			},

			inactive = {
				a = { bg = colors.bg_statusline, fg = colors.blue },
				b = { bg = colors.bg_statusline, fg = colors.fg_gutter, gui = "bold" },
				c = { bg = nil, fg = colors.fg_gutter },
			},

			replace = {
				a = { bg = colors.red, fg = colors.black },
				b = { bg = colors.fg_gutter, fg = colors.red },
			},
		}

		lualine.setup({
			options = {
				icons_enabled = true,
				theme = custom_theme,
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
