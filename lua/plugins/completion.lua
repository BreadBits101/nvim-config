return {
    {
        "saghen/blink.cmp",
        version = "1.*",

        opts = {
            keymap = {
                preset = "none",

                ["<C-space>"] = {
                    "show",
                    "show_documentation",
                    "hide_documentation",
                },

                ["<C-n>"] = {
                    "select_next",
                    "fallback",
                },

                ["<C-p>"] = {
                    "select_prev",
                    "fallback",
                },

                ["<C-e>"] = {
                    "hide",
                },

                ["<CR>"] = {
                    "accept",
                    "fallback",
                },

                ["<Tab>"] = {
                    "snippet_forward",
                    "fallback",
                },

                ["<S-Tab>"] = {
                    "snippet_backward",
                    "fallback",
                },
            },

            appearance = {
                nerd_font_variant = "mono",
            },

            completion = {
                documentation = {
                    auto_show = false,
                },

                menu = {
                    auto_show = true,
                },
            },

            signature = {
                enabled = true,
            },

            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
            },

            fuzzy = {
                implementation = "prefer_rust_with_warning",
            },
        },

        opts_extend = {
            "sources.default",
        },
    },
}
