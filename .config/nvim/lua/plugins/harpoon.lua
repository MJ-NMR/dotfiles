return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		vim.keymap.set("n", "<leader>h", function() harpoon:list():add() end, { desc = "harpoon add" })
		vim.keymap.set("n", "<leader><leader>",
			function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "harpoon list" })

		vim.keymap.set("n", "<leader>j", function() harpoon:list():select(1) end, { desc = "harpoon 1" })
		vim.keymap.set("n", "<leader>k", function() harpoon:list():select(2) end, { desc = "harpoon 2" })
		vim.keymap.set("n", "<leader>l", function() harpoon:list():select(3) end, { desc = "harpoon 3" })
		vim.keymap.set("n", "<leader>;", function() harpoon:list():select(4) end, { desc = "harpoon 4" })

		vim.api.nvim_create_autocmd("DirChanged", {
			callback = function()
				harpoon:sync()
				harpoon:setup()
			end,
		})
	end
}
