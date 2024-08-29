local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- keymap for write
keymap("n", "<leader>w", ":wa<cr>", opts)

-- keymap for quit
keymap("n", "<leader>q", ":bd<cr>", opts)

-- keymap for quit all
keymap("n", "<leader>Q", ":qa!<cr>", opts)

-- keymap selecto option
    -- slecct all
keymap("n", "<C-a>", "gg<S-v>G")

-- keymaps for telescope
local telescope = require('telescope.builtin')
keymap("n", "<leader>fg", telescope.live_grep, opts)
keymap("n", "<leader>p", telescope.find_files, opts)

-- nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
