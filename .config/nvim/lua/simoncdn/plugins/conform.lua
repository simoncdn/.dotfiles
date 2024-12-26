return {
	"stevearc/conform.nvim",

	config = function()
		local conform = require("conform")
		-- Keybindings
		vim.keymap.set("n", "<leader>f", function()
			conform.format()
		end, { desc = "Format code" })

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier", "eslint_d" },
				typescript = { "prettier", "eslint_d" },
				javascriptreact = { "prettier", "eslint_d" },
				typescriptreact = { "prettier", "eslint_d" },
				css = { "prettier" },
				html = { "prettier", "eslint_d" },
				json = { "prettier" },
				vue = { "prettier", "eslint_d" },
			},

			format_after_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { lsp_fallback = false }
			end,

			formatters = {
				prettier = {
					require_cwd = true,
					cwd = require("conform.util").root_file({
						".prettierrc",
						".prettierrc.json",
						".prettierrc.yml",
						".prettierrc.yaml",
						".prettierrc.json5",
						".prettierrc.js",
						".prettierrc.cjs",
						".prettierrc.mjs",
						".prettierrc.toml",
						"prettier.config.js",
						"prettier.config.cjs",
						"prettier.config.mjs",
					}),
				},
				eslint = {
					-- cwd means "config working directory"
					require_cwd = true,
					cwd = require("conform.util").root_file({
						"eslint.config.js",
						"eslint.config.cjs",
						"eslint.config.mjs",
					}),
				},
			},
		})
	end,
}
