local ok, conform = pcall(require, "conform")
if not ok then
	return
end

-- Detect if the project uses Prettier (config file or package.json dep)
local function project_uses_prettier(dirname)
	local cfg = vim.fs.find({
		".prettierrc",
		".prettierrc.json",
		".prettierrc.yml",
		".prettierrc.yaml",
		".prettierrc.js",
		".prettierrc.cjs",
		".prettierrc.mjs",
		"prettier.config.js",
		"prettier.config.cjs",
		"prettier.config.mjs",
	}, { path = dirname, upward = true })[1]
	if cfg then
		return true
	end

	local pkg = vim.fs.find("package.json", { path = dirname, upward = true })[1]
	if pkg then
		local ok_read, content = pcall(vim.fn.readfile, pkg)
		if ok_read then
			local ok_json, json = pcall(vim.json.decode, table.concat(content, "\n"))
			if ok_json and json then
				if json.prettier ~= nil then
					return true
				end
				local deps = vim.tbl_extend("force", json.dependencies or {}, json.devDependencies or {})
				if deps["prettier"] ~= nil then
					return true
				end
			end
		end
	end
	return false
end

conform.setup({
	format_on_save = {
		lsp_fallback = true, -- if no external formatter, use LSP
		timeout_ms = 1000,
	},

	-- Only list the actual built-in names here
	formatters_by_ft = {
		lua = { "stylua" },

		javascript = { "prettierd", "prettier" },
		javascriptreact = { "prettierd", "prettier" },
		typescript = { "prettierd", "prettier" },
		typescriptreact = { "prettierd", "prettier" },
		json = { "prettierd", "prettier" },
		yaml = { "prettierd", "prettier" },
		html = { "prettierd", "prettier" },
		css = { "prettierd", "prettier" },
		scss = { "prettierd", "prettier" },
		markdown = { "prettierd", "prettier" },
	},

	-- Override built-ins with the same conditional
	formatters = {
		stylua = {},
		formatters = {
			stylua = {},
			prettierd = { prefer_local = "node_modules/.bin" },
			prettier = { prefer_local = "node_modules/.bin" },
		},
	},
})

-- Keep TS LSPs from formatting so Prettier is the single source of truth
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
