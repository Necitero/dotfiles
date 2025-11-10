-- Ask before installing missing plugins
local function ensure_plugins_installed()
    local plugs = vim.g.plugs
    if not plugs then return end

    local missing = {}
    for name, plug in pairs(plugs) do
        if not vim.loop.fs_stat(plug.dir) then
            table.insert(missing, name)
        end
    end

    if #missing == 0 then
        return
    end

    -- Prompt user
    local answer = vim.fn.input("Missing plugins detected (" .. table.concat(missing, ", ") .. "). Install now? [y/N]: ")
    if answer:lower() == 'y' then
        vim.cmd('echo "Installing missing plugins..."')
        vim.cmd('PlugInstall --sync') -- install synchronously
        vim.cmd('source $MYVIMRC') -- reload your init.lua (so colorschemes etc. work immediately)
        vim.cmd('echo "Plugins installed and config reloaded!"')
    else
        print("Skipped installing missing plugins.")
    end
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = ensure_plugins_installed,
})
