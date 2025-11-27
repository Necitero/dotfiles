local servers = require("config.servers")
for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end
vim.diagnostic.show()
vim.diagnostic.config({
	virtual_text = false,
	underline = true,
})
-- Make sure TS LSPs don't fight Prettier
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end
		if client.name == "tsserver" or client.name == "ts_ls" then
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end
	end,
})

vim.o.updatetime = 250
local function open_diag_float()
	vim.diagnostic.open_float(nil, {
		focusable = false,
		scope = "cursor",
		source = "if_many",
		border = "rounded",
	})
end

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	callback = open_diag_float,
})
