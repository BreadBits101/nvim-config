local map = vim.keymap.set
local platform = require("config.platform")

-- Capabilities tell language servers what the client supports.
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("*", {
    capabilities = capabilities,
})

-- Server-specific configuration.

vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
    },
})

vim.lsp.config("pyright", {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
            },
        },
    },
})

vim.lsp.config("ts_ls", {
    single_file_support = false,
})

vim.lsp.config("eslint", {
    settings = {
        workingDirectory = {
            mode = "auto",
        },
    },
})

-- Set NVIM_JDTLS_HOME when jdtls is installed somewhere else.  The defaults
-- match the documented local setup on each platform without embedding a user
-- home directory in the shared configuration.
local jdtls_root = vim.env.NVIM_JDTLS_HOME
    or (platform.is_windows and "C:/Tools/jdtls" or vim.fn.expand("~/tools/jdtls"))
local jdtls_launcher = vim.fn.glob(jdtls_root .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local jdtls_config = platform.is_windows and "config_win" or "config_mac"

local jdtls_enabled = (platform.is_windows or platform.is_mac)
    and platform.executable("java")
    and jdtls_launcher ~= ""
    and vim.uv.fs_stat(jdtls_root .. "/" .. jdtls_config) ~= nil

if jdtls_enabled then
    vim.lsp.config("jdtls", {
        cmd = {
            "java",

            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx1g",

            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",

            "-jar",
            jdtls_launcher,

            "-configuration",
            jdtls_root .. "/" .. jdtls_config,

            "-data",
            vim.fn.stdpath("cache")
                .. "/jdtls/"
                .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
        },

        filetypes = {
            "java",
        },

        root_markers = {
            "pom.xml",
            "build.gradle",
            "build.gradle.kts",
            "settings.gradle",
            "settings.gradle.kts",
            "mvnw",
            "gradlew",
            ".git",
        },
    })
end

-- Enable installed servers.
local servers = {
    "clangd",
    "pyright",
    "ts_ls",
    "html",
    "cssls",
    "jsonls",
    "eslint",
}

if jdtls_enabled then
    table.insert(servers, "jdtls")
end

vim.lsp.enable(servers)

-- Buffer-local mappings are created only when an LSP attaches.
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opts = {
            buffer = event.buf,
            silent = true,
        }

        map("n", "gd", vim.lsp.buf.definition,
            vim.tbl_extend("force", opts, {
                desc = "Go to definition",
            })
        )

        map("n", "gD", vim.lsp.buf.declaration,
            vim.tbl_extend("force", opts, {
                desc = "Go to declaration",
            })
        )

        map("n", "gr", vim.lsp.buf.references,
            vim.tbl_extend("force", opts, {
                desc = "Find references",
            })
        )

        map("n", "gi", vim.lsp.buf.implementation,
            vim.tbl_extend("force", opts, {
                desc = "Go to implementation",
            })
        )

        map("n", "gy", vim.lsp.buf.type_definition,
            vim.tbl_extend("force", opts, {
                desc = "Go to type definition",
            })
        )

        map("n", "K", vim.lsp.buf.hover,
            vim.tbl_extend("force", opts, {
                desc = "Show documentation",
            })
        )

        map("i", "<C-k>", vim.lsp.buf.signature_help,
            vim.tbl_extend("force", opts, {
                desc = "Signature help",
            })
        )

        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
            vim.tbl_extend("force", opts, {
                desc = "Code action",
            })
        )

        map("n", "<leader>rn", vim.lsp.buf.rename,
            vim.tbl_extend("force", opts, {
                desc = "Rename symbol",
            })
        )

        map({ "n", "v" }, "<leader>cf", function()
            vim.lsp.buf.format({
                async = false,
                timeout_ms = 5000,
            })
        end, vim.tbl_extend("force", opts, {
            desc = "Format buffer or selection",
        }))

        map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,
            vim.tbl_extend("force", opts, {
                desc = "Add workspace folder",
            })
        )

        map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
            vim.tbl_extend("force", opts, {
                desc = "Remove workspace folder",
            })
        )

        map("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, vim.tbl_extend("force", opts, {
            desc = "List workspace folders",
        }))
    end,
})

vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    signs = true,
    severity_sort = true,
    update_in_insert = false,
    float = {
        border = "rounded",
        source = true,
    },
})
