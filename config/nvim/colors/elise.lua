-- Add message for yank macros
-- shift enter insert mode: add line above
-- Lua highlights
-- Styling: defaults/cleanup/copy elise.vim --> verify

-- Config: pylsp, clangd, lua-language-server, [javascript]
-- Languages: c++, c, lua, python, javascript


local p = {
    ["red"] = "#ff0000",
    ["orange"] = "#ff8000",
    ["yellow"] = "#ffff00",
    ["green"] = "#00ff00",
    ["blue"] = "#5c5cff",
    ["lblue"] = "#00ffff",
    ["systempurple"] = "#6040ff",
    ["dpurple"] = "#282050",
    ["pink"] = "#ff80ff",
    ["deeppink"] = "#ff60ff",
    ["magenta"] = "#ff00ff",
    ["white"] = "#ffffff",
    ["black"] = "#000000",
    ["gray"] = "#aaaaaa",
    ["dgray"] = "#7f7f7f",

    ["statusColor"] = "#7010ff",

    ["cursorline"] = "#302080",
    ["signcolumn"] = "#808080",
}


local theme = {
    ["Visual"] = {p.gray, p.black, {reverse = true}},
    ["CursorLine"] = {p.cursorline, p.white, {reverse = true}},
    ["FloatBorder"] = {p.systempurple, "None"},

    ["MatchParen"] = {p.black, p.pink},

    ["Comment"] = {p.magenta},
    ["@string"] = {p.lblue},
    ["@string_override"] = {p.lblue},
    ["@comment_override"] = {p.magenta},
    ["PreProc"] = {p.blue},
    ["@preproc_cond"] = {p.blue},
    ["@preproc_def_override"] = {p.blue},
    ["@preproc_simple"] = {p.blue},
    ["Identifier"] = {p.gray},
    ["@punctuation"] = {p.gray},
    ["@constructor"] = {p.gray},
    ["@operator"] = {p.gray},
    ["Constant"] = {p.blue},
    ["@keyword"] = {p.yellow},
    ["@repeat"] = {p.yellow},
    ["@conditional"] = {p.yellow},
    ["@lsp.type.macro"] = {p.gray},
    ["@lsp.type.class"] = {p.gray},
    ["@keyword_override"] = {p.green},
    --["@keyword.function"] = {p.green},
    ["@operator_name_override"] = {p.yellow},
    ["@type.builtin"] = {p.green},
    ["@primitive_override"] = {p.green},
    ["Type"] = {p.green},
    ["@lsp.type.namespace"] = {p.gray},
    ["@string.escape"] = {p.magenta},
    ["@function.python"] = {p.green},

    ["@constant"] = {p.blue},
    ["@constant.builtin"] = {p.blue},

    ["@function.builtin"] = {p.gray},

    ["Tabline"] = {p.white, p.dgray},
    ["TablineFill"] = {"None", p.black},
    ["TablineSel"] = {p.white, p.statusColor},
    ["Title"] = {p.yellow},

    ["StatusLine"] = {p.white, p.statusColor},
    ["StatusLineNC"] = {p.white, p.dgray},

    ["LineNr"] = {p.deeppink},
    ["LineNrAbove"] = {p.systempurple},
    ["LineNrBelow"] = {p.systempurple},
    ["ColorColumn"] = {"None", p.dpurple},


    --Popup menu consistent with old style
    --["Pmenu"] = {p.white, p.dgray},
    --["PmenuSel"] = {p.white, p.magenta},
    --["PmenuSbar"] = {"None", p.gray},
    --["PmenuThumb"] = {"None", p.magenta},

    ["Pmenu"] = {p.gray, p.black},
    ["PmenuSel"] = {p.magenta, p.white, {reverse = true}},
    ["PmenuSbar"] = {"None", p.gray},
    ["PmenuThumb"] = {"None", p.magenta},

    ["SignColumn"] = {"None", p.signcolumn},

    --Harpoon
    ["HarpoonBorder"] = {p.systempurple, "None"},

    --Telescope
    ["TelescopeBorder"] = {p.systempurple, "None"},
    ["TelescopeSelection"] = {p.magenta, p.white, {reverse = true}},
    ["TelescopePromptCounter"] = {p.deeppink, "None"},

    --Mason
    ["MasonNormal"] = {p.gray, p.black}, --text and window bg

    ["MasonHeader"] = {p.systempurple, p.black}, --window title
    ["MasonHeaderSecondary"] = {p.systempurple, p.black},

    ["MasonHighlight"] = {p.green, p.black}, --installed stuff, key names
    ["MasonMuted"] = {p.dgray, p.black}, --uninstalled marker

    ["MasonMutedBlock"] = {p.dgray, p.black}, --top number bar unselected
    ["MasonMutedBlockBold"] = {p.dgray, p.black},

    ["MasonHighlightSecondary"] = {p.pink, p.black},

    ["MasonHighlightBlock"] = {p.white, p.magenta}, --number bar selected
    ["MasonHighlightBlockBold"] = {p.white, p.magenta},

    ["MasonHighlightBlockSecondary"] = {p.white, p.red},
    ["MasonHighlightBlockBoldSecondary"] = {p.white, p.magenta}, --help selected tab

    ["MasonError"] = {p.red, p.dgray},
    ["MasonWarning"] = {p.orange, p.dgray},

    ["MasonHeading"] = {p.systempurple, p.black}, --section headers
    ["MasonDoc"] = {p.orange},
    ["MasonPod"] = {p.orange},
    ["MasonPerlComment"] = {p.orange},

    --Undotree
    ["UndoTreeHelpTitle"] = {p.systempurple},
    ["UndoTreeNode"] = {p.lblue},
    ["UndoTreeSeq"] = {p.gray},
    ["UndoTreeCurrent"] = {p.green},
    ["UndoTreeSavedSmall"] = {p.orange},
    ["UndoTreeSavedBig"] = {p.black, p.orange},
    --Fugitive

    --Others
    ["DiagnosticWarn"] = {p.orange},
    ["DiagnosticSignWarn"] = {p.orange, p.black},

    ["WarningMsg"] = {p.orange},
    ["Statement"] = {p.yellow},

    ["DiagnosticError"] = {p.red},
    ["DiagnosticSignError"] = {p.red, p.black},

    --["@keyword.import.c"] = {p.blue},



}

local function main()
    vim.cmd("hi clear")

    local indices = {"fg", "bg", "sp"}

    for group, colorTable in pairs(theme) do
        local convertedTable = {}

        local iTable = 1
        local iIndex = 1
        local iMax = #colorTable

        while iTable <= iMax do
            if type(colorTable[iTable]) == "table" then
                for k, v in pairs(colorTable[iTable]) do
                    convertedTable[k] = v
                end
            else
                convertedTable[indices[iIndex]] = colorTable[iTable]
                iIndex = iIndex + 1
            end

            iTable = iTable + 1
        end

        vim.api.nvim_set_hl(0, group, convertedTable)
    end

    --For preprocessor conditionals
    vim.api.nvim_set_hl(0, "@lsp.type.comment", {})
    vim.api.nvim_set_hl(0, "@lsp.type.comment.c", {})
    vim.api.nvim_set_hl(0, "@lsp.type.comment.cpp", {})
    vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", {})

    vim.g.colors_name = "elise"
end


main()

