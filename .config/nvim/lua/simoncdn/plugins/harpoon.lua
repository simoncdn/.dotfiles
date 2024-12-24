return {
	'ThePrimeagen/harpoon',

	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")
		local harpoon = require("harpoon")
		-- set keymaps
		vim.keymap.set("n", "<leader>a", mark.add_file)
		vim.keymap.set("n", "<C-s>", ui.toggle_quick_menu)

		vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
		vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end)
		vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end)
		vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end)

		vim.keymap.set("n", "<leader>cm", mark.clear_all)

		harpoon.setup({
			menu = {
				width = 120,
			};
			save_on_toggle = true,
		})
	end,
}
