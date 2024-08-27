vim.opt.hlsearch = false
vim.opt.number = true
vim.opt.lazyredraw = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.shiftwidth = 2

-- https://neovim.io/doc/user/insert.html
vim.opt.tabstop = 2
-- vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.spell = true
vim.opt.wrap = false
vim.opt.scrolloff = 6
-- vim.opt.cursorline = true
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
-- Sync clipboard between OS and Neovim.
--	Remove this option if you want your OS clipboard to remain independent.
--	See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- Enable break indent
-- vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- vim.cmd.colorscheme('tokyonight-night')
-- vim.cmd.colorscheme('lunaperche')
vim.cmd.colorscheme('catppuccin-mocha')
