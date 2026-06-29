return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				view_options = {
					show_hidden = true,
				},
				columns = {
					"icon",
					-- "permissions",
					-- "size",
					-- "mtime",
				},
				keymaps = {
					["g?"] = { "actions.show_help", mode = "n" },
					["<CR>"] = "actions.select",
					["<C-s>"] = { "actions.select", opts = { vertical = true } },
					["<C-h>"] = { "actions.select", opts = { horizontal = true } },
					["<C-t>"] = { "actions.select", opts = { tab = true } },
					["p"] = "actions.preview",
					["q"] = { "actions.close", mode = "n" },
					["<C-l>"] = "actions.refresh",
					["<S-h>"] = { "actions.parent", mode = "n" },
					["_"] = { "actions.open_cwd", mode = "n" },
					["`"] = { "actions.cd", mode = "n" },
					["g."] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
					["gs"] = { "actions.change_sort", mode = "n" },
					["gx"] = "actions.open_external",
					["gh"] = { "actions.toggle_hidden", mode = "n" },
					["g\\"] = { "actions.toggle_trash", mode = "n" },
				},
				float = {
					border = "rounded",
					-- preview_split: Split direction: "auto", "left", "right", "above", "below".
					preview_split = "right",
				},
				progress = {
					border = "rounded",
				},

				ssh = {
					border = "rounded",
				},

				keymaps_help = {
					border = "rounded",
				},
				confirmation = {
					border = "rounded",
				},
			})
			vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open parent directory in Oil" })
		end
	},
	{ "a-h/templ", lazy = true },
}
