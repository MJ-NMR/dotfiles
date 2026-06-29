vim.lsp.enable({ "lua_ls", "ts_ls", "bashls", "gopls", "clangd", "pyright", "sqls", "arduino_language_server", "zls" })

local capabilities = require('blink.cmp').get_lsp_capabilities()
--local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('*', {
	capabilities = capabilities,
})


vim.lsp.config('clangd', {
	cmd = {
		"clangd",
		"--fallback-style='{BasedOnStyle:  WebKit, TabWidth: 4, IndentWidth: 4, UseTab: Always}'"
	}
})

-- vim.lsp.config('clangd', {
-- 	cmd = {
-- 		"clangd",
-- 		"--fallback-style=webkit"
-- 	}
-- })

vim.lsp.config('lua_ls', {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath('config')
				and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				version = 'LuaJIT',
				path = {
					'lua/?.lua',
					'lua/?/init.lua',
				},
			},
			-- Make the server aware of runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					'/usr/share/hypr/stubs/hl.meta.lua'
				}
			}
		})
	end,
	settings = {
		Lua = {}
	}
})

vim.diagnostic.config({
	--	virtual_lines =true,
	virtual_text = true, -- show inline text (under the line)
	signs = false,    -- show in sign column
	underline = true, -- underline the error in code
	update_in_insert = false,
	float = {
		border = 'rounded',
		source = true,
	}
})
