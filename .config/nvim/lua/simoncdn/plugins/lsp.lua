return {

	-- LSP
	{
		"neovim/nvim-lspconfig",

		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim"
		},

		config = function()
			local lsp = require("lspconfig")
			local cmplsp = require("cmp_nvim_lsp")
			local masonconfig = require("mason-lspconfig")

			local lsp_capabilities = cmplsp.default_capabilities()

			masonconfig.setup({
				ensure_installed = {
					"emmet_ls",
					"emmet_language_server",
					"eslint",
					"lua_ls",
					"tailwindcss",
					"ts_ls",
					"volar",
					"vuels",
					"yamlls",
					"grammarly",
					"css_variables",
					"cssmodules_ls",
					"cssls",
					"marksman",
					"jsonls",
					"html",
					"bashls",
				},
				handlers = {

					-- Default setup
					function(server_name)
						lsp[server_name].setup({
							capabilities = lsp_capabilities,
						})
					end,

					-- Lua setup
					["lua_ls"] = function()
						lsp.lua_ls.setup({
							capabilities = lsp_capabilities,
							on_init = function(client)
								client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
									runtime = { version = "LuaJIT" },
									-- Make the server aware of Neovim runtime files
									workspace = {
										checkThirdParty = false,
										library = { vim.env.VIMRUNTIME },
									},
								})
							end,
							settings = {
								Lua = {},
							},
						})
					end,

					-- Ts setup
					["ts_ls"] = function()
						local mason_registry = require("mason-registry")
						local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
								.. "/node_modules/@vue/language-server"

						lsp.ts_ls.setup({
							capabilities = lsp_capabilities,
							cmd = { 'typescript-language-server', '--stdio' },
							root_dir = lsp.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
							filetypes = {
								'javascript',
								'javascriptreact',
								'javascript.jsx',
								'typescript',
								'typescriptreact',
								'typescript.tsx',
							},
							init_options = {
								plugins = {
									{
										name = "@vue/typescript-plugin",
										location = vue_language_server_path,
										languages = { "vue" },
									},
								},
							},
						})
					end,

					-- Volar setup
					["volar"] = function()
						lsp.volar.setup({
							capabilities = lsp_capabilities,
							init_options = {
								vue = {
									hybridMode = false,
								},
							},
						})
					end,

					-- Tailwind setup
					["tailwindcss"] = function()
						lsp.tailwindcss.setup({
							capabilities = lsp_capabilities,
							cmd = { "tailwindcss-language-server", "--stdio" },
							filetypes = { "html", "css", "scss", "javascript", "typescript", "vue" },
							init_options = {
								userLanguages = {
									html = "html",
									javascript = "javascript",
									typescript = "javascript",
									vue = "vue",
								},
							},
							settings = {
								tailwindCSS = {
									validate = true,
								},
							},
						})
					end,
				},

			})

			-- Appearance
			vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
				config = config
						or {
							border = {
								{ "╭", "FloatBorder" },
								{ "─", "FloatBorder" },
								{ "╮", "FloatBorder" },
								{ "│", "FloatBorder" },
								{ "╯", "FloatBorder" },
								{ "─", "FloatBorder" },
								{ "╰", "FloatBorder" },
								{ "│", "FloatBorder" },
							},
						}
				config.focus_id = ctx.method
				if not (result and result.contents) then
					return
				end
				local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
				if vim.tbl_isempty(markdown_lines) then
					return
				end
				return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
			end

			vim.diagnostic.config({
				float = {
					border = "rounded",
				},
				virtual_text = true
			})

			-- Mapping
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					-- Mappings
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>gv", ":vsplit | lua vim.lsp.buf.definition(, opts)<CR>", opts)
					vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
					vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
					vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
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
			"hrsh7th/cmp-path",  -- source for file system paths
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
				vim.keymap.set({ "i" }, "<C-K>", function() luasnip.expand() end, { silent = true }),
				-- vim.keymap.set({ "i", "s" }, "<C-L>", function() luasnip.jump(1) end, { silent = true }),
				vim.keymap.set({ "i", "s" }, "<C-J>", function() luasnip.jump(-1) end, { silent = true }),

				vim.keymap.set({ "i", "s" }, "<C-E>", function()
					if luasnip.choice_active() then
						luasnip.change_choice(1)
					end
				end, { silent = true })
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
					["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
					["<C-e>"] = cmp.mapping.abort(),   -- close completion window
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
			local mason = require('mason')

			mason.setup({
				ui = {
					theme = "tokyonight",
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				}
			})
		end,
	},
}
