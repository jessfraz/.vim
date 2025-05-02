-- lua/config/autocmds.lua
-- Restore cursor to last known position when reopening a file
local group = vim.api.nvim_create_augroup("baby_yosh_autocmds", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
	group = group,
	pattern = "*",
	callback = function()
		-- line("'\"") is the position of the last exit mark
		local last_pos = vim.fn.line([['"]])
		local line_cnt = vim.fn.line("$")

		if last_pos > 1 and last_pos <= line_cnt then
			vim.cmd('normal! g`"') -- jump to the mark
		end
	end,
})
