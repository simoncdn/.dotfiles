function ColorMyPencils(color)
	color = color or "gruvbox-material"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "Float", { bg = "none" })
	vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
end

return {
	{
		"sainnhe/gruvbox-material",
		name = "gruvbox-material",

		config = function()
			vim.g.airline_theme = "gruvbox_material"
			vim.g.gruvbox_material_better_performance = 1
			vim.g.gruvbox_material_transparent_background = 1
			vim.g.gruvbox_material_disable_italic_comment = 1
			vim.g.gruvbox_material_disable_italic = 1
			vim.g.gruvbox_material_disable_bold = 1
			vim.g.gruvbox_material_sign_column_background = "none"
			vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"

			vim.cmd("colorscheme gruvbox-material")
			ColorMyPencils()
		end,
	},
}
