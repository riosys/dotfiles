-- keymap  for quit.
vim.keymap.set('n', '<Space>w', ':w<CR>', { noremap = true, silent = true })
-- keymap for write.
vim.keymap.set('n', '<Space>q', ':q<CR>', { noremap = true, silent = true })
-- keymap for write in insert mode.
vim.keymap.set('i', '<c-s>', '<cmd>w<CR><cmd>echo "Saved"<CR>', { noremap = true, silent = true })
-- keymap for toggle file explorer
vim.keymap.set('n', '<c-b>', ':NvimTreeToggle<CR>', { noremap = true, silent = true }) 
