return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },

        cmd = {
            "NvimTreeToggle",
            "NvimTreeFindFile",
        },

        keys = {
            {
                "<leader>ft",
                "<cmd>NvimTreeToggle<CR>",
                desc = "Toggle file tree",
            },
            {
                "<leader>fT",
                "<cmd>NvimTreeFindFile<CR>",
                desc = "Reveal current file in tree",
            },
        },

        opts = {
            view = {
                side = "left",
                width = 32,
            },
        },
    },
}
