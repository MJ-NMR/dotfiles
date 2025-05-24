
-- Telescope plugin spec
return {
  {
    "nvim-telescope/telescope.nvim",
	tag = '0.1.8',
    dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
	},
    config = function()
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")

      -- Telescope setup with key mappings
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-l>"] = actions.select_default,
              ["<C-;>"] = actions.close,
            },
            n = {
              ["l"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["j"] = actions.select_default,
              [";"] = actions.close,
            },
          },
		  file_ignore_patterns = {
			  "node_modules"
		  },
        },
      }

      -- Telescope keymaps
      vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find File" })
      vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "List Buffers" })
      vim.keymap.set("n", "<leader>e", function ()
      	builtin.find_files {
			cwd = vim.fn.stdpath('config')
		}
      end,{ desc = "Find nvim config File" })

	        vim.keymap.set("n", "<leader>G", function()
        builtin.live_grep({
          glob_pattern = "*",
          cwd = "/",
          word_match = "-w",
        })
      end, { desc = "Live Grep Globally (root)" })

      vim.keymap.set("n", "<A-F>F", function()
        builtin.find_files({
          glob_pattern = "*",
          cwd = "/",
          word_match = "-w",
        })
      end, { desc = "Find Files Globally (root)" })

      -- Make <Space> work normally in insert mode
      vim.keymap.set("i", "<Space>", "<Space>")
    end,
  }
}

