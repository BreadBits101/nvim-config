return {
    {
        "ibhagwan/fzf-lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },

        opts = {},

        keys = {
            {
                "<leader>ff",
                function()
                    require("fzf-lua").files()
                end,
                desc = "Find files",
            },
            {
                "<leader>fg",
                function()
                    require("fzf-lua").live_grep()
                end,
                desc = "Search project text",
            },
            {
                "<leader>fb",
                function()
                    require("fzf-lua").buffers()
                end,
                desc = "Find buffers",
            },
            {
                "<leader>fh",
                function()
                    require("fzf-lua").helptags()
                end,
                desc = "Search help",
            },
            {
                "<leader>fr",
                function()
                    require("fzf-lua").oldfiles()
                end,
                desc = "Recent files",
            },
            {
                "<leader>fs",
                function()
                    require("fzf-lua").lsp_document_symbols()
                end,
                desc = "Document symbols",
            },
            {
                "<leader>fS",
                function()
                    require("fzf-lua").lsp_workspace_symbols()
                end,
                desc = "Workspace symbols",
            },
        },
    },
}
