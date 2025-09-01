-- Helper to define keymaps succinctly
local map = function(mode, lhs, rhs, desc)
vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Space as leader is set in diego/init.lua

-- File explorer (built-in netrw) like the blog post’s <leader>e
map("n", "<leader>e", vim.cmd.Ex, "Open file explorer")


-- Save/Quit
map("n", "<leader>w", ":w<CR>", "Save")
map("n", "<leader>q", ":q<CR>", "Quit window")
map("n", "<leader>Q", ":qa!<CR>", "Quit all without saving")


-- Better vertical movement keeping cursor centered
map("n", "<C-d>", "<C-d>zz", "Half page down, center")
map("n", "<C-u>", "<C-u>zz", "Half page up, center")
map("n", "n", "nzzzv", "Next search, center")
map("n", "N", "Nzzzv", "Prev search, center")


-- Join lines but keep cursor
map("n", "J", "mzJ`z", "Join lines, keep cursor")


-- Quick replace word under cursor across file
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Substitute word under cursor")


-- Paste in visual without clobbering clipboard
map("x", "p", '"_dP', "Paste without overwriting clipboard")


-- Buffers (bufferline will also provide clickable tabs)
map("n", "<S-l>", ":bnext<CR>", "Next buffer")
map("n", "<S-h>", ":bprevious<CR>", "Prev buffer")
map("n", "<leader>bd", ":bdelete<CR>", "Delete buffer")


-- Telescope (defined when plugin loads; these won’t error if absent)
map("n", "<leader>ff", function() pcall(require('telescope.builtin').find_files) end, "Telescope find files")
map("n", "<leader>fg", function() pcall(require('telescope.builtin').live_grep) end, "Telescope live grep")
map("n", "<leader>fb", function() pcall(require('telescope.builtin').buffers) end, "Telescope buffers")
map("n", "<leader>fh", function() pcall(require('telescope.builtin').help_tags) end, "Telescope help tags")


-- Symbols outline
map("n", "<leader>o", ":SymbolsOutline<CR>", "Symbols outline")


-- Diagnostics shortcuts
map("n", "gl", vim.diagnostic.open_float, "Line diagnostics")
map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
map("n", "<leader>dl", vim.diagnostic.setloclist, "Diagnostics to loclist")


-- Today note (no plugin). Adjust NOTES_DIR to your liking.
local NOTES_DIR = vim.fn.expand("~/notes")
local function open_today()
vim.fn.mkdir(NOTES_DIR, "p")
local fname = NOTES_DIR .. "/" .. os.date("%Y-%m-%d") .. ".md"
vim.cmd("edit " .. fname)
end
map("n", "<leader>t", open_today, "Open today’s note")