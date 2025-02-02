local luasnip = require("luasnip")
luasnip.config.setup({})
local palette = require("catppuccin.palettes").get_palette("mocha")

-- Styling
vim.api.nvim_set_hl(0, "CmpNormal", { bg = palette.surface0 })
vim.api.nvim_set_hl(0, "CmpNormalDoc", { bg = palette.surface1 })
vim.api.nvim_set_hl(0, "CmpCursorLine", { bg = palette.lavender, fg = palette.base })
vim.api.nvim_set_hl(0, "CmpFloatBorder", { fg = palette.surface1, bg = palette.surface1 })

local cmp_kinds = {
	Text = "",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰇽",
	Variable = "󰂡",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰅲",
}

local cmp = require("cmp")
cmp.setup({
	formatting = {
		format = function(entry, vim_item)
			local lspkind_ok, lspkind = pcall(require, "lspkind")
			if not lspkind_ok then
				-- From kind_icons array
				vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
				-- Source
				vim_item.menu = ({
					buffer = "[Buffer]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					nvim_lua = "[Lua]",
					latex_symbols = "[LaTeX]",
				})[entry.source.name]
				return vim_item
			else
				-- From lspkind
				return lspkind.cmp_format()(entry, vim_item)
			end
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = {
		col_offset = -3,
		side_padding = 0,
	},

	-- For an understanding of why these mappings were
	-- chosen, you will need to read `:help ins-completion`
	--
	-- No, but seriously. Please read `:help ins-completion`, it is really good!
	mapping = cmp.mapping.preset.insert({
		-- Select the next item
		["<C-n>"] = cmp.mapping.select_next_item(),
		-- Select the previous item
		["<C-p>"] = cmp.mapping.select_prev_item(),

		-- Scroll the documentation window back / forward
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		-- Accept (yes) the completion.
		--  This will auto-import if your LSP supports it.
		--  This will expand snippets if the LSP sent a snippet.
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-j>"] = cmp.mapping(function()
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),
		["<C-k>"] = cmp.mapping(function()
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),

		-- If you prefer more traditional completion keymaps,
		-- you can uncomment the following lines
		--['<CR>'] = cmp.mapping.confirm { select = true },
		--['<Tab>'] = cmp.mapping.select_next_item(),
		--['<S-Tab>'] = cmp.mapping.select_prev_item(),

		-- Manually trigger a completion from nvim-cmp.
		--  Generally you don't need this, because nvim-cmp will display
		--  completions whenever it has completion options available.
		-- ['<C-Space>'] = cmp.mapping.complete {},

		-- Think of <c-l> as moving to the right of your snippet expansion.
		--  So if you have a snippet that's like:
		--  function $name($args)
		--    $body
		--  end
		--
		-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
		--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
	}),
	sources = {
		{ name = "luasnip", priority = 1000 },
		{ name = "nvim_lsp", priority = 800 },
		{ name = "path", priority = 600 },
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					local buf = vim.api.nvim_get_current_buf()
					local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
					if byte_size > 1024 * 1024 then -- 1 Megabyte max
						return {}
					end
					return { buf }
				end,
			},
			priority = 400,
		},
		{
			name = "lazydev",
			-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
			group_index = 0,
		},
		{ name = "nvim_lsp_signature_help" },
	},
})

vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help)
