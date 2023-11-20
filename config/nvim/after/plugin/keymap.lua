--Telescope
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', builtin.git_files, {})

local function grepFind()
    local ok, searchTerm = pcall(function()
        return vim.fn.input("Grep > ")
    end)

    if (not ok) or (searchTerm == "") then
        return false
    end

    builtin.grep_string({ search = searchTerm })
    return true
end

vim.keymap.set('n', '<leader>ps', grepFind)

vim.keymap.set({"n"}, "<leader>thi", function()
    builtin.highlights()
end)

--Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set({"n"}, "<leader>a", function()
    mark.add_file()
    print("Marked file (Harpoon)")
end)

vim.keymap.set({"n"}, "<leader>m", function()
    ui.toggle_quick_menu()
end)

vim.keymap.set({"n"}, "<C-1>", function() ui.nav_file(1) end)
vim.keymap.set({"n"}, "<C-2>", function() ui.nav_file(2) end)
vim.keymap.set({"n"}, "<C-3>", function() ui.nav_file(3) end)
vim.keymap.set({"n"}, "<C-4>", function() ui.nav_file(4) end)
vim.keymap.set({"n"}, "<C-5>", function() ui.nav_file(5) end)
vim.keymap.set({"n"}, "<C-6>", function() ui.nav_file(6) end)
vim.keymap.set({"n"}, "<C-7>", function() ui.nav_file(7) end)
vim.keymap.set({"n"}, "<C-8>", function() ui.nav_file(8) end)
vim.keymap.set({"n"}, "<C-9>", function() ui.nav_file(9) end)
vim.keymap.set({"n"}, "<C-0>", function() ui.nav_file(10) end)

--Treesitter
vim.keymap.set({"n"}, "<leader>hh", function()
    vim.cmd("TSHighlight")
end)

vim.keymap.set({"n"}, "<leader>hi", function()
    vim.cmd("Inspect")
end)

vim.keymap.set({"n"}, "<leader>pl", function()
    vim.cmd("TSPlaygroundToggle")
end)

--Undotree
vim.keymap.set({"n"}, "<leader>u", vim.cmd.UndotreeToggle)

--Fugitive
vim.keymap.set({"n"}, "<leader>gg", vim.cmd.Git)

--Mason
vim.keymap.set({"n"}, "<leader>bb", function()
    vim.cmd("Mason")
end)



---------- Unused split/tab stuff

--vim.keymap.set({"n"}, "<leader>tm", function()
--    vim.cmd.tabnew()
--    ui.toggle_quick_menu()
--end)
--
--vim.keymap.set('n', '<leader>tf', function()
--    vim.cmd.tabnew()
--    builtin.find_files()
--end)
--
--vim.keymap.set('n', '<leader>ts', function()
--    vim.cmd.tabnew()
--    if not grepFind() then
--        vim.cmd.tabclose()
--    end
--end)
--
