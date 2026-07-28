local map = vim.keymap.set

-- Keep selection after indenting.
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move selected lines.
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Clear search highlighting.
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Window navigation.
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Diagnostics.
map("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })

map("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

map("n", "<leader>e", vim.diagnostic.open_float, {
    desc = "Show diagnostic",
})

map("n", "<leader>q", vim.diagnostic.setloclist, {
    desc = "Diagnostics to location list",
})

-- Terminal mode escape.
map("t", "<Esc><Esc>", "<C-\\><C-n>", {
    desc = "Leave terminal mode",
})
