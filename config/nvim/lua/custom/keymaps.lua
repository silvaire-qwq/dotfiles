-- [[ Basic Keymaps ]]
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>:q!<CR>", { desc = "Quit current window" })
vim.keymap.set("n", "<leader>w", "<cmd>:w!<CR>", { desc = "Save current file" })
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
vim.keymap.set("n", "<C-q>", "<cmd>:qall<CR>", { desc = "Quit all window" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "\\", "<CMD>:sp<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "|", "<CMD>:vsp<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Go to next qf item" })
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Go to prev qf item" })
vim.keymap.set("n", "<C-d>", "5j", { desc = "Scroll down by 5 lines" })
vim.keymap.set("n", "<C-u>", "5k", { desc = "Scroll up by 5 lines" })
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })
vim.keymap.set("n", "L", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
vim.keymap.set("n", "H", "<cmd>bprev<cr>", { desc = "Go to prev buffer" })
vim.keymap.set("n", "+", "<C-w>|<C-w>_")
vim.keymap.set("n", "=", "<C-w>=")

-- close all other buffers except current one
vim.keymap.set("n", "<leader>bc", function()
	-- define filetypes not to be deleted
	local filetypes = { "OverseerList", "Terminal", "quickfix", "terminal" }
	local buftypes = { "terminal", "toggleterm" }

	local current_buf = vim.fn.bufnr("%")
	local buffers = vim.fn.getbufinfo({ bufloaded = 1 })

	for _, buffer in ipairs(buffers) do
		local bufnr = buffer.bufnr
		local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
		local useless = { "[Preview]" }

		-- Close the buffer if it is not the current one and not in the specified filetypes
		if
			bufnr ~= current_buf
			and not vim.tbl_contains(filetypes, filetype)
			and not vim.tbl_contains(buftypes, buftype)
		then
			require("bufdelete").bufdelete(bufnr, vim.tbl_contains(useless, vim.fn.bufname(bufnr)))
		end
	end
end, { noremap = true, silent = true })

vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Move focus to the left window" })
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Move focus to the lower window" })
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Move focus to the upper window" })
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Move focus to the right window" })

-- Paste without replacing the unnamed register in visual mode
vim.keymap.set("x", "p", '"_dP', { noremap = true })

-- Use <leader>p to paste with the original behavior (updating the register)
vim.keymap.set("x", "<leader>p", "p", { noremap = true })
