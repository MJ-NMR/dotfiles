return {
	{
		"nvim-telescope/telescope.nvim",
		version = '*',
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "nvim-telescope/telescope-project.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
		},
		config = function()
			local actions = require("telescope.actions")
			-- local project_actions = require("telescope._extensions.project.actions")

			require("telescope").setup {
				defaults = {
					initial_mode = "insert", --"normal",
					layout_config = {
						bottom_pane = { height = 50 }
					},
					mappings = {
						i = {
							["<Tab>"] = 'move_selection_next',
							["<S-Tab>"] = 'move_selection_previous',
							["<M-j>"] = 'preview_scrolling_down',
							["<M-k>"] = 'preview_scrolling_up',
						},
						n = {
							["q"] = 'close',
							["j"] = 'move_selection_next',
							["k"] = 'move_selection_previous',
							["h"] = 'select_default',
							["l"] = 'close',
						},
					},
					file_ignore_patterns = {
						"node_modules"
					},
				},
				pickers = {
					live_grep = {
						initial_mode = "insert",
						theme = "dropdown",
					},
					find_files = {
						initial_mode = "insert",
						theme = "dropdown",
					},
					git_files = {
						initial_mode = "insert",
						theme = "dropdown",
					},
				},
				-- extensions = {
				-- 	project = {
				-- 		on_project_selected = function(prompt_bufnr)
				-- 			project_actions.change_working_directory(prompt_bufnr, false)
				-- 			require("harpoon"):list():select(1)
				-- 		end,
				-- 		mappings = {
				-- 			n = {
				-- 				['d'] = project_actions.delete_project,
				-- 				['r'] = project_actions.rename_project,
				-- 				['c'] = project_actions.add_project,
				-- 				['C'] = project_actions.add_project_cwd,
				-- 				['f'] = project_actions.find_project_files,
				-- 				['b'] = project_actions.browse_project_files,
				-- 				['s'] = project_actions.search_in_project_files,
				-- 				['R'] = project_actions.recent_project_files,
				-- 				['w'] = project_actions.change_working_directory,
				-- 				['o'] = project_actions.next_cd_scope,
				-- 			},
				-- 		},
				-- 	}
				-- }
			}
			-- telescope
			-- require("telescope").load_extension('project')
			-- vim.api.nvim_set_keymap('n', '<leader>p', ":Telescope project<CR>", { desc = "open project" })

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find File" })
			vim.keymap.set("n", "<leader>F", builtin.live_grep, { desc = "Live Grep" })
			vim.keymap.set("n", "<leader>s", builtin.lsp_document_symbols, { desc = "List Symbols" })
			vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "List Buffers" })
			-- Make <Space> work normally in insert mode
		end,
	}
}
