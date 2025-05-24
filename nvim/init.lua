vim.o.mouse = ""
vim.opt.tabstop = 4 -- Number of visual spaces per TAB
vim.opt.shiftwidth = 4 -- Number of spaces to use for autoindenting
vim.g.mapleader = " "
vim.opt.signcolumn = "no"
-- Remap movement keys in normal mode
vim.keymap.set('n', 'j', 'h', { noremap = true })
vim.keymap.set('n', 'k', 'k', { noremap = true })
vim.keymap.set('n', 'l', 'j', { noremap = true })
vim.keymap.set('n', ';', 'l', { noremap = true })
vim.keymap.set('n', 'H', '^', { noremap = true })
vim.keymap.set('n', 'h', '$', { noremap = true })

-- Remap movement keys in visual mode
vim.keymap.set('v', 'j', 'h', { noremap = true })
vim.keymap.set('v', 'k', 'k', { noremap = true })
vim.keymap.set('v', 'l', 'j', { noremap = true })
vim.keymap.set('v', ';', 'l', { noremap = true })
vim.keymap.set('v', 'H', '^', { noremap = true })
vim.keymap.set('v', 'h', '$', { noremap = true })

-- Remap movement keys in operator-pending mode
vim.keymap.set('o', 'j', 'h', { noremap = true })
vim.keymap.set('o', 'k', 'k', { noremap = true })
vim.keymap.set('o', 'l', 'j', { noremap = true })
vim.keymap.set('o', ';', 'l', { noremap = true })
vim.keymap.set('o', 'H', '^', { noremap = true })
vim.keymap.set('o', 'h', '$', { noremap = true })

-- Press jj in insert mode to exit to normal mode
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true })

-- Map <Del> to <Esc> in normal, insert, and visual modes
local opts = { noremap = true, silent = true }
vim.keymap.set('i', '<Del>', '<Esc>', opts)
vim.keymap.set('n', '<Del>', '<Esc>', opts)
vim.keymap.set('v', '<Del>', '<Esc>', opts)

vim.keymap.set('n', '<A-m>', '<C-d>zz', { noremap = true })
vim.keymap.set('n', '<A-u>', '<C-u>zz', { noremap = true })
vim.keymap.set('n', '<A-j>', '<C-w>h', opts) -- move to left window
vim.keymap.set('n', '<A-k>', '<C-w>k', opts) -- move to top window
vim.keymap.set('n', '<A-l>', '<C-w>j', opts) -- move to bottom window
vim.keymap.set('n', '<A-;>', '<C-w>l', opts) -- move to right window
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '+','<C-w>o', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>q", "<cmd>bd<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>Q", "<cmd>bd!<CR>", { desc = "Force close current buffer" })

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 }) -- 200ms highlight
  end,
})


require("config.lazy")


-- lspconfig.lua_ls.setup({})
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})

vim.diagnostic.config({
	virtual_text = true,   -- show inline text (under the line)
	signs = true,          -- show in sign column
	underline = true,      -- underline the error in code
	update_in_insert = false,
})

-- line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Smart relative line numbers
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

-- Set colorscheme
vim.cmd.colorscheme  "dracula"

