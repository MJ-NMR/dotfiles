vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		vim.opt.relativenumber = false
	end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		vim.opt.relativenumber = true
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.hl.on_yank({ timeout = 200 }) -- 200ms highlight
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

-- vim.api.nvim_create_autocmd("TermOpen", {
-- 	callback = function()
-- 		vim.bo.filetype = "terminal"
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("TermOpen", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.opt_local.statusline = " "
-- 	end,
-- })
--
-- -- Optional: restore when leaving terminal buffer
-- vim.api.nvim_create_autocmd("BufLeave", {
-- 	pattern = "term://*",
-- 	callback = function()
-- 		vim.opt_local.statusline = nil -- revert to global (lualine takes over)
-- 	end,
-- })

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.bo.filetype = "terminal"
	end,
})
