return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",     -- source for text in buffer
		"hrsh7th/cmp-path",       -- source for file system paths
		"L3MON4D3/LuaSnip",       -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim",   -- vs-code like pictograms
		-- "hrsh7th/cmp-emoji",
		"hrsh7th/cmp-nvim-lsp",   -- source for nvim lsp
	},

	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		local types = require("cmp.types")
		local str = require("cmp.utils.str")

		local t = function(str)
			return vim.api.nvim_replace_termcodes(str, true, true, true)
		end

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
		require("luasnip.loaders.from_snipmate").load({ paths = { "~/.dotfiles/.config/nvim/lua/simoncdn/snippets" } })

		cmp.setup({
			window = {
				completion = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					scrollbar = "║",
					completeopt = "menu,menuone,preview,noselect",
				},
				documentation = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},
				scrollbar = "║",
			},

			snippet = { -- configure how nvim-cmp interacts with snippet engine
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
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<Enter>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- sources for autocompletion

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),

			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				fields = {
					cmp.ItemField.Kind,
					cmp.ItemField.Abbr,
					cmp.ItemField.Menu,
				},
				format = lspkind.cmp_format({
					with_text = false,
					before = function(entry, vim_item)
						-- Get the full snippet (and only keep first line)
						local word = entry:get_insert_text()
						if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
							word = vim.lsp.util.parse_snippet(word)
						end
						word = str.oneline(word)

						-- concatenates the string
						-- local max = 50
						-- if string.len(word) >= max then
						-- 	local before = string.sub(word, 1, math.floor((max - 3) / 2))
						-- 	word = before .. "..."
						-- end

						if
							entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
							and string.sub(vim_item.abbr, -1, -1) == "~"
						then
							word = word .. "~"
						end
						vim_item.abbr = word

						return vim_item
					end,
				}),
			},
		})
	end,
}
