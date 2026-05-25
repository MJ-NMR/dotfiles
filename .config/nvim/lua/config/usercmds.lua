vim.api.nvim_create_user_command('ColorizerToggle', function()
	require('nvim-highlight-colors').toggle()
end, {})

vim.api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = 'Alias to `:checkhealth vim.lsp`' })

vim.api.nvim_create_user_command('LspLog', function()
	vim.cmd(string.format('tabnew %s', vim.lsp.log.get_filename()))
end, {
	desc = 'Opens the Nvim LSP client log.',
})

local complete_client = function(arg)
	return vim
		.iter(vim.lsp.get_clients())
		:map(function(client)
			return client.name
		end)
		:filter(function(name)
			return name:sub(1, #arg) == arg
		end)
		:totable()
end

local complete_config = function(arg)
	return vim
		.iter(vim.api.nvim_get_runtime_file(('lsp/%s*.lua'):format(arg), true))
		:map(function(path)
			local file_name = path:match('[^/]*.lua$')
			return file_name:sub(0, #file_name - 4)
		end)
		:totable()
end

vim.api.nvim_create_user_command('LspStart', function(info)
	local servers = info.fargs

	-- Default to enabling all servers matching the filetype of the current buffer.
	-- This assumes that they've been explicitly configured through `vim.lsp.config`,
	-- otherwise they won't be present in the private `vim.lsp.config._configs` table.
	if #servers == 0 then
		local filetype = vim.bo.filetype
		for name, _ in pairs(vim.lsp.config._configs) do
			local filetypes = vim.lsp.config[name].filetypes
			if filetypes and vim.tbl_contains(filetypes, filetype) then
				table.insert(servers, name)
			end
		end
	end

	vim.lsp.enable(servers)
end, {
	desc = 'Enable and launch a language server',
	nargs = '?',
	complete = complete_config,
})

vim.api.nvim_create_user_command('LspRestart', function(info)
	local client_names = info.fargs

	-- Default to restarting all active servers
	if #client_names == 0 then
		client_names = vim
			.iter(vim.lsp.get_clients())
			:map(function(client)
				return client.name
			end)
			:totable()
	end

	for name in vim.iter(client_names) do
		if vim.lsp.config[name] == nil then
			vim.notify(("Invalid server name '%s'"):format(name))
		else
			vim.lsp.enable(name, false)
			if info.bang then
				vim.iter(vim.lsp.get_clients({ name = name })):each(function(client)
					client:stop(true)
				end)
			end
		end
	end

	local timer = assert(vim.uv.new_timer())
	timer:start(500, 0, function()
		for name in vim.iter(client_names) do
			vim.schedule_wrap(vim.lsp.enable)(name)
		end
	end)
end, {
	desc = 'Restart the given client',
	nargs = '?',
	bang = true,
	complete = complete_client,
})

vim.api.nvim_create_user_command('LspStop', function(info)
	local client_names = info.fargs

	-- Default to disabling all servers on current buffer
	if #client_names == 0 then
		client_names = vim
			.iter(vim.lsp.get_clients())
			:map(function(client)
				return client.name
			end)
			:totable()
	end

	for name in vim.iter(client_names) do
		if vim.lsp.config[name] == nil then
			vim.notify(("Invalid server name '%s'"):format(name))
		else
			vim.lsp.enable(name, false)
			if info.bang then
				vim.iter(vim.lsp.get_clients({ name = name })):each(function(client)
					client:stop(true)
				end)
			end
		end
	end
end, {
	desc = 'Disable and stop the given client',
	nargs = '?',
	bang = true,
	complete = complete_client,
})

-- In your init.lua or a plugin file
vim.api.nvim_create_user_command("Gshow", function(opts)
	local offset = opts.args ~= "" and opts.args or "1"

	if not offset:match("^%d+$") then
		vim.notify("Gshow: argument must be a non-negative integer", vim.log.levels.ERROR)
		return
	end

	local bufpath = vim.api.nvim_buf_get_name(0)
	if bufpath == "" then
		vim.notify("Gshow: buffer has no file path", vim.log.levels.ERROR)
		return
	end

	local ft = vim.bo.filetype -- capture BEFORE enew

	local git_root = vim.fn.systemlist(
		"git -C " .. vim.fn.shellescape(vim.fn.fnamemodify(bufpath, ":h")) .. " rev-parse --show-toplevel"
	)[1]
	if vim.v.shell_error ~= 0 or not git_root then
		vim.notify("Gshow: not inside a git repository", vim.log.levels.ERROR)
		return
	end

	local rel_path = bufpath:sub(#git_root + 2)
	local ref = tonumber(offset) == 0 and "HEAD" or ("HEAD~" .. offset)
	local git_cmd = string.format(
		"git -C %s show %s:%s",
		vim.fn.shellescape(git_root),
		ref,
		vim.fn.shellescape(rel_path)
	)

	vim.cmd("enew")
	local new_buf = vim.api.nvim_get_current_buf()

	local lines = vim.fn.systemlist(git_cmd)
	if vim.v.shell_error ~= 0 then
		vim.notify("Gshow: " .. table.concat(lines, "\n"), vim.log.levels.ERROR)
		vim.cmd("bdelete")
		return
	end

	vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, lines)

	vim.api.nvim_set_option_value("buftype", "nofile", { buf = new_buf })
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = new_buf })
	vim.api.nvim_set_option_value("swapfile", false, { buf = new_buf })
	vim.api.nvim_set_option_value("modifiable", false, { buf = new_buf })
	vim.api.nvim_set_option_value("filetype", ft, { buf = new_buf })

	vim.api.nvim_buf_set_name(new_buf, string.format("git://%s/%s", ref, rel_path))
end, {
	nargs = "?",
	desc = "Open a past git version of the current file. Usage: :Gshow [N]",
})
