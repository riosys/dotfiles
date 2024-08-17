local keymap = vim.keymap.set

-- keymap  for write.
keymap('n', '<Space>w', ':w<CR>', { noremap = true, silent = true })
-- keymap for quit.
keymap('n', '<Space>q', ':bd<CR>', { noremap = true, silent = true })
keymap('n', '<Space>qq', ':exit<CR>', { noremap = true, silent = true})
-- keymap for write in insert mode.
keymap('i', '<c-s>', '<cmd>w<CR><cmd>echo "Saved"<CR>', { noremap = true, silent = true })
-- keymap for toggle file explorer
keymap('n', '<c-b>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- keymap from telescope.
local telescope = require('telescope.builtin')
-- find files
keymap('n', '<Space>ff', telescope.find_files, { noremap = true, silent = true, desc = 'Find files...' })
-- find contend in files
keymap('n', '<Space>fc', telescope.live_grep, { noremap = true, silent = true, desc = 'Find contend...'})
