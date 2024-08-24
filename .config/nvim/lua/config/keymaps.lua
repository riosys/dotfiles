local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- keymap for write
keymap("n", "<leader>w", ":wa<cr>", opts)

-- keymap for quit
keymap("n", "<leader>q", ":q<cr>", opts)

-- keymap for quit all
keymap("n", "<leader>Q", ":qa!<cr>", opts)