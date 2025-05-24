return {
  {
    "neovim/nvim-lspconfig",
    version = "*",
	event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
	config = function ()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("lspconfig").pylsp.setup({
        capabilities = capabilities,
      })

	  require("lspconfig").ts_ls.setup({
		  capabilities = capabilities,
	  })

      require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
      })

	end
  },
  {
    "williamboman/mason.nvim",
    version = "*",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "*",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "pylsp", "ts_ls" },
		automatic_enable = {},
      }

    end,
  },
}

