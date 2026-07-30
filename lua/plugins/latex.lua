local platform = require("config.platform")

local function skim_available()
    return platform.executable("displayline")
        or vim.uv.fs_stat("/Applications/Skim.app/Contents/SharedSupport/displayline") ~= nil
end

return {
    {
        "lervag/vimtex",
        ft = { "tex", "plaintex", "bib" },

        init = function()
            -- latexmk continuously rebuilds on save, including SyncTeX data for
            -- source/PDF navigation.
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_latexmk = {
                continuous = 1,
                callback = 1,
            }
            vim.g.vimtex_view_automatic = 1

            if platform.is_windows and platform.executable("SumatraPDF") then
                vim.g.vimtex_view_general_viewer = "SumatraPDF"
                vim.g.vimtex_view_general_options =
                    "-reuse-instance -forward-search @tex @line @pdf"
            elseif platform.is_mac and skim_available() then
                vim.g.vimtex_view_method = "skim"
            end
        end,
    },
}
