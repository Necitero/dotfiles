local lualine = require("lualine")
local colors = {
	bg = "#303446",
	fg = "#c6d0f5",
	yellow = "#e5c890",
	cyan = "#81c8be",
	darkblue = "#8caaee",
	green = "#a6d189",
	orange = "#ef9f76",
	violet = "#ca9ee6",
	magenta = "#f4b8e4",
	blue = "#85c1dc",
	red = "#e78284",
}
local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}
local config = {
	options = { component_separators = "", section_separators = "" },
	sections = { lualine_a = {}, lualine_b = {}, lualine_y = {}, lualine_z = {}, lualine_c = {}, lualine_x = {} },
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end
ins_left({
	function()
		return ""
	end,
	color = function()
		local mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.blue,
			["␖"] = colors.blue,
			V = colors.blue,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			["␓"] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = { right = 1 },
})
ins_left({ "filename", cond = conditions.buffer_not_empty, color = { fg = colors.magenta, gui = "bold" } })
ins_left({ "branch", icon = "", color = { fg = colors.violet, gui = "bold" } })
ins_left({
	function()
		return "%="
	end,
})
ins_right({
	function()
		local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
		local clients = vim.lsp.get_clients({ bufnr = 0 })
		if #clients == 0 then
			return "No Active LSP"
		end
		local prefer = { "ts_ls", "tsserver", "eslint", "lua_ls", "jsonls" }
		local hide = { tailwindcss = true }
		function supports_buf_ft(c)
			local fts = c.config and c.config.filetypes
			return (not fts) or vim.tbl_contains(fts, buf_ft)
		end
		for _, name in ipairs(prefer) do
			for _, c in ipairs(clients) do
				if c.name == name and supports_buf_ft(c) and not hide[c.name] then
					return c.name
				end
			end
		end
		for _, c in ipairs(clients) do
			if not hide[c.name] and supports_buf_ft(c) then
				return c.name
			end
		end
		return "tailwindcss"
	end,
	icon = " ",
	color = { fg = "#ffffff", gui = "bold" },
})
lualine.setup(config)
