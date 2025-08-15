return {

	-- LSP
	{
		"neovim/nvim-lspconfig",

		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim",
		},

		config = function()
			local cmplsp = require("cmp_nvim_lsp")
			local masonconfig = require("mason-lspconfig")

			local lsp_capabilities = cmplsp.default_capabilities()

			masonconfig.setup({
				ensure_installed = {
					"emmet_ls", -- Emmet
					"emmet_language_server", -- Emmet
					"eslint", -- ESLint
					"lua_ls", -- Lua
					"tailwindcss", -- Tailwind CSS
					"vtsls", -- TypeScript
					"vue_ls", -- "vuels",
					"yamlls", -- YAML
					"grammarly", -- Grammarly
					"css_variables", -- CSS Variables
					"cssmodules_ls", -- CSS Modules
					"cssls", -- CSS
					"marksman", -- Markdown
					"jsonls", -- JSON
					"html", -- HTML
					"bashls", -- Bash
					"clangd", -- C / C++
					"dockerls", -- Docker
					"gopls", -- Go
				},
			})

			vim.lsp.config("*", {
				capabilities = lsp_capabilities,
			})

			local vue_language_server_path = vim.fn.expand("$MASON/packages")
				.. "/vue-language-server"
				.. "/node_modules/@vue/language-server"
			local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
			local vtsls_config = {
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								{
									name = "@vue/typescript-plugin",
									location = vue_language_server_path,
									languages = { "vue" },
									configNamespace = "typescript",
								},
							},
						},
					},
				},
				filetypes = tsserver_filetypes,
			}
			local vue_ls_coonfig = {}
			vim.lsp.config("vtsls", vtsls_config)
			vim.lsp.config("vtsls", vtsls_config)

			vim.diagnostic.config({
				float = {
					border = "rounded",
				},
				virtual_text = true,
			})

			-- Mapping
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					-- Mappings
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover({ border = "rounded" })
					end)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>gv", ":vsplit | lua vim.lsp.buf.definition(, opts)<CR>", opts)
					vim.keymap.set("n", "<leader>vws", function()
						vim.lsp.buf.workspace_symbol()
					end, opts)
					vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "<leader>vrr", function()
						vim.lsp.buf.references()
					end, opts)
					vim.keymap.set("n", "<leader>vrn", function()
						vim.lsp.buf.rename()
					end, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("i", "<C-h>", function()
						vim.lsp.buf.signature_help()
					end, opts)
				end,
			})
		end,
	},

	-- CMP
	{
		"hrsh7th/nvim-cmp",

		event = "InsertEnter",

		dependencies = {
			-- Autocompletion
			"hrsh7th/cmp-nvim-lsp", -- source for nvim lsp
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"hrsh7th/cmp-path", -- source for file system paths
			"hrsh7th/cmp-cmdline", -- source for cmdline

			-- Snippets
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},

		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			luasnip.config.setup({
				region_check_events = "CursorMoved",
				delete_check_events = "TextChanged",
				vim.keymap.set({ "i" }, "<C-K>", function()
					luasnip.expand()
				end, { silent = true }),
				-- vim.keymap.set({ "i", "s" }, "<C-L>", function() luasnip.jump(1) end, { silent = true }),
				vim.keymap.set({ "i", "s" }, "<C-J>", function()
					luasnip.jump(-1)
				end, { silent = true }),

				vim.keymap.set({ "i", "s" }, "<C-E>", function()
					if luasnip.choice_active() then
						luasnip.change_choice(1)
					end
				end, { silent = true }),
			})
			luasnip.filetype_extend("all", { "_" })
			require("luasnip.loaders.from_snipmate").load({ paths = { "~/.config/nvim/lua/simoncdn/snippets" } })

			cmp.setup({
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- snippets
					{ name = "buffer" }, -- text within current buffer
					{ name = "path" }, -- file system paths
				}),

				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
					["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.complete(), -- show completion suggestions
					["<C-e>"] = cmp.mapping.abort(), -- close completion window
					["<Enter>"] = cmp.mapping.confirm({ select = false }),
				}),

				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})
		end,
	},

	-- MASON
	{
		"williamboman/mason.nvim",

		config = function()
			local mason = require("mason")

			mason.setup({
				ui = {
					theme = "rose-pine",
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
}
