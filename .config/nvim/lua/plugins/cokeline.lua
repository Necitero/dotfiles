local get_hex = require("cokeline.hlgroups").get_hl_attr

require("cokeline").setup({
	default_hl = {
		fg = function(buffer)
			return buffer.is_focused and get_hex("ColorColumn", "bg") or get_hex("Comment", "fg")
		end,
		bg = function(buffer)
			return buffer.is_focused and get_hex("Normal", "fg") or "NONE"
		end,
	},
	components = {
		{
			text = function(buffer)
				return (buffer.index ~= 1) and "▏" or ""
			end,
			fg = function()
				return get_hex("Normal", "fg")
			end,
		},

		{
			text = function(buffer)
				return "    " .. buffer.devicon.icon
			end,
			fg = function(buffer)
				return buffer.devicon.color
			end,
		},

		{
			text = function(buffer)
				return buffer.filename .. " "
			end,
			bold = function(buffer)
				return buffer.is_focused
			end,
		},

		{
			text = function(buffer)
				local d = buffer.diagnostics or {}
				local e = d.errors or 0
				local w = d.warnings or 0
				local i = d.infos or 0
				local h = d.hints or 0

				if e > 0 then
					return string.format(" %d ", e)
				elseif w > 0 then
					return string.format(" %d ", w)
				elseif i > 0 then
					return string.format(" %d ", i)
				elseif h > 0 then
					return string.format("󰌵 %d ", h)
				else
					return ""
				end
			end,

			fg = function(buffer)
				local d = buffer.diagnostics or {}
				if (d.errors or 0) > 0 then
					return get_hex("DiagnosticError", "fg")
				elseif (d.warnings or 0) > 0 then
					return get_hex("DiagnosticWarn", "fg")
				elseif (d.infos or 0) > 0 then
					return get_hex("DiagnosticInfo", "fg")
				elseif (d.hints or 0) > 0 then
					return get_hex("DiagnosticHint", "fg")
				else
					return get_hex("Comment", "fg")
				end
			end,
		},
		{
			text = "󰖭",
			on_click = function(_, _, _, _, buffer)
				buffer:delete()
			end,
		},
		{
			text = "  ",
		},
	},
})
