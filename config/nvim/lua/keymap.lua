vim.g.mapleader = " "

local toggleWindowMode

local windowMode = false

local function unmapIfExists(mode, name)
    if vim.fn.mapcheck(name, mode) ~= "" then
        vim.keymap.del(mode, name)
    end
end

local function unmapTable(mappings)
    for _, mapping in pairs(mappings) do
        local modeTable = mapping[1]
        local name = mapping[2]

        for _, mode in pairs(modeTable) do
            unmapIfExists(mode, name)
        end
    end
end

local windowBindTable = {
    {{"n"}, "<Left>"},
    {{"n", "i", "v"}, "<S-Left>"},

    {{"n"}, "<Right>"},
    {{"n", "i", "v"}, "<S-Right>"},

    {{"n"}, "<Up>"},
    {{"n", "i", "v"}, "<S-Up>"},

    {{"n"}, "<Down>"},
    {{"n", "i", "v"}, "<S-Down>"},

    {{"n"}, "="},
    {{"n", "i", "v"}, "<C-c>"},
    {{"n", "i", "v"}, "<Esc>"},
    {{"n"}, "e"},
}

local function setWindowBinds()
    unmapTable(windowBindTable)

    vim.keymap.set({"n"}, "<Left>", function()
        vim.cmd("vertical resize -1")
    end)

    vim.keymap.set({"n"}, "<S-Left>", function()
        vim.cmd("vertical resize -5")
    end)

    vim.keymap.set({"n"}, "<Right>", function()
        vim.cmd("vertical resize +1")
    end)

    vim.keymap.set({"n"}, "<S-Right>", function()
        vim.cmd("vertical resize +5")
    end)

    vim.keymap.set({"n"}, "<Up>", function()
        vim.cmd("resize +1")
    end)

    vim.keymap.set({"n"}, "<S-Up>", function()
        vim.cmd("resize +5")
    end)

    vim.keymap.set({"n"}, "<Down>", function()
        vim.cmd("resize -1")
    end)

    vim.keymap.set({"n"}, "<S-Down>", function()
        vim.cmd("resize -5")
    end)

    vim.keymap.set({"n"}, "=", "<C-w>=")

    vim.keymap.set({"n", "i", "v"}, "<C-c>", toggleWindowMode)
    vim.keymap.set({"n", "i", "v"}, "<Esc>", toggleWindowMode)

    vim.keymap.set({"n"}, "e", function()
        vim.cmd('call feedkeys("\\<C-w>=")')
        toggleWindowMode()
    end)
end

local function delWindowBinds()
    unmapTable(windowBindTable)

    vim.keymap.set({"n"}, "<C-c>", function()
        vim.cmd('call feedkeys("\\<Esc>")')
        vim.cmd('noh')
    end)

    vim.keymap.set({"i", "v"}, "<C-c>", function()
        vim.cmd('call feedkeys("\\<Esc>")')
    end)

    vim.keymap.set({"n", "i", "v"}, "<S-Up>", "<Up><Up>")
    vim.keymap.set({"n", "i", "v"}, "<S-Down>", "<Down><Down>")
    vim.keymap.set({"n", "i", "v"}, "<S-Left>", "<Left><Left>")
    vim.keymap.set({"n", "i", "v"}, "<S-Right>", "<Right><Right>")
end

local function updateWindowBinds()
    if windowMode then
        setWindowBinds()
    else
        delWindowBinds()
    end
end

toggleWindowMode = function()
    windowMode = not windowMode
    updateWindowBinds()
    if windowMode then
        print("Enable window resize")
    else
        print("Disable window resize")
    end
end

updateWindowBinds()

vim.keymap.set({"n", "v"}, "<leader>ww", toggleWindowMode)

vim.keymap.set({"n"}, "<leader>pv", vim.cmd.Ex)

vim.keymap.set({"n"}, "<C-q>", vim.cmd.q)
vim.keymap.set({"n"}, "<C-S-q>", vim.cmd.qall)

vim.keymap.set({"n"}, "<C-Left>", vim.cmd.tabprev)
vim.keymap.set({"n"}, "<C-Right>", vim.cmd.tabnext)

vim.keymap.set({"n"}, "<C-S-Left>", function()
    vim.cmd("try\n  tabm-\ncatch\nendtry")
end)

vim.keymap.set({"n"}, "<C-S-Right>", function()
    vim.cmd("try\n  tabm+\ncatch\nendtry")
end)

---------- Tabnew
vim.keymap.set({"n"}, "<leader>tn", vim.cmd.tabnew)

vim.keymap.set({"n"}, "<leader>te", function()
    vim.cmd.tabnew()
    vim.cmd.Ex()
end)

vim.keymap.set({"n"}, "<leader>tt", function()
    local lineNumber = vim.fn.line(".")
    vim.cmd.tabnew(vim.fn.bufname())
    vim.cmd(":" .. lineNumber)
    vim.cmd('call feedkeys("zz")')
end)

---------- Split
vim.keymap.set({"n"}, "<leader>ss", ":split<CR>")
vim.keymap.set({"n"}, "<leader>vs", ":vsplit<CR>")

---------- Misc
vim.keymap.set({"n"}, "<leader>det", function()
    vim.o.expandtab = false
    print("Disable expandtab")
end)

vim.keymap.set({"n"}, "<leader>eet", function()
    vim.o.expandtab = true
    print("Enable expandtab")
end)

--TODO: make this repeatable with a motion somehow
vim.keymap.set({"n"}, "<leader>n", function()
    vim.fn.appendbufline(vim.fn.bufname(), vim.fn.line("."), "")
end)

vim.keymap.set({"n", "i", "v"}, "<PageUp>", "2<C-y>")
vim.keymap.set({"n", "i", "v"}, "<S-PageUp>", "10<C-y>")

vim.keymap.set({"n", "i", "v"}, "<PageDown>", "2<C-e>")
vim.keymap.set({"n", "i", "v"}, "<S-PageDown>", "10<C-e>")


---------- Scroll arrow keys
vim.keymap.set({"n", "i", "v"}, "<C-Up>", "<C-y>")
vim.keymap.set({"n", "i", "v"}, "<C-Down>", "<C-e>")

vim.keymap.set({"n", "i", "v"}, "<C-S-Up>", "2<C-y>")
vim.keymap.set({"n", "i", "v"}, "<C-S-Down>", "2<C-e>")


vim.keymap.set({"n", "i", "v"}, "<C-S-y>", "2<C-y>")
vim.keymap.set({"n", "i", "v"}, "<C-S-e>", "2<C-e>")


vim.keymap.set({"n", "i", "v", "x"}, "<C-s>", vim.cmd.w)

-- TODO yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y")
vim.keymap.set({"n"}, "<leader>Y", "\"+Y")

---------- Window moving
vim.keymap.set({"n"}, "<M-Left>", "<C-w>h")
vim.keymap.set({"n"}, "<M-Right>", "<C-w>l")
vim.keymap.set({"n"}, "<M-Up>", "<C-w>k")
vim.keymap.set({"n"}, "<M-Down>", "<C-w>j")


vim.keymap.set({"n"}, "<M-S-Left>", "<C-w>H")
vim.keymap.set({"n"}, "<M-S-Right>", "<C-w>L")
vim.keymap.set({"n"}, "<M-S-Up>", "<C-w>K")
vim.keymap.set({"n"}, "<M-S-Down>", "<C-w>J")


vim.keymap.set({"n"}, "<leader>cc", function()
    vim.cmd("so ~/.config/nvim/colors/elise.lua")
end)

vim.keymap.set({"n", "i", "v", "x"}, "<C-b>", "")
vim.keymap.set({"n", "i", "v", "x"}, "<C-f>", "")


---------------- NEW (EXPERIMENTAL, LAPTOP ONLY)
--vim.keymap.set({"n", "i", "v"}, "<C-BS>", "db")
