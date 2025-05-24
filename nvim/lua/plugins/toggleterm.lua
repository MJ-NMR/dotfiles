return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				direction = "float",      -- options: "vertical" | "horizontal" | "tab" | "float"
				shade_terminals = false,  -- remove shading (for clarity)
				start_in_insert = true,
			})
			vim.keymap.set("t", "<C-v>", [[<C-\><C-n>v]], { noremap = true, silent = true, desc = "Enter Visual Mode from terminal" })
			vim.keymap.set("t", "<C-j>", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Enter Visual Mode from terminal" })
			vim.keymap.set("n", "<A-t>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
			vim.keymap.set("t", "<A-t>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
		end,
	},
}
