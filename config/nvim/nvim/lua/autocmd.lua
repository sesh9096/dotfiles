-- local function transparent_background()
-- 	vim.cmd.colorscheme 'onedark'
-- 	vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
-- 	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
-- 	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none"})
-- 	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none"})
-- end
vim.api.nvim_create_autocmd({"ColorScheme"}, {
	-- pattern = {},
	callback = function ()
	-- vim.cmd.colorscheme 'onedark'
	vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none"})
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none"})
	end
})
-- vim.api.nvim_create_autocmd({"BufWritePost"},{})
