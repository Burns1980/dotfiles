local opts = { noremap = true, silent = true }
local function mergeTable(t1, t2)
  local result = {}

  for k, v in pairs(t1) do
    result[k] = v
  end
  for k, v in pairs(t2) do
    result[k] = v
  end

  return result
end

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Select all
vim.keymap.set('n', '<C-a>', 'gg<S-v>G', { desc = 'Select all' })

-- Jumplist
vim.keymap.set('n', '<leader>J', ':jump<CR>', mergeTable(opts, { desc = 'Open jumplist' }))

--Open new tab
vim.keymap.set('n', 'te', ':tabedit', mergeTable(opts, { desc = 'Open a new tab ' }))

-- Split window
vim.keymap.set('n', 'ss', ':split<CR>', mergeTable(opts, { desc = 'Split current window horizontally' }))
vim.keymap.set('n', 'sv', ':vsplit<CR>', mergeTable(opts, { desc = 'Split current window vertically' }))

-- Move window
vim.keymap.set('n', 'sh', '<C-w>H', mergeTable(opts, { desc = 'Move current window to far left' }))
vim.keymap.set('n', 'sl', '<C-w>L', mergeTable(opts, { desc = 'Move current window to far right' }))
vim.keymap.set('n', 'sj', '<C-w>J', mergeTable(opts, { desc = 'Move current window to far bottom' }))
vim.keymap.set('n', 'sk', '<C-w>K', mergeTable(opts, { desc = 'Move current window to far top' }))

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move ocus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Plugin shortcut
vim.keymap.set('n', '<leader>m', ':Mason<CR>', { desc = '[M]ason' })
vim.keymap.set('n', '<leader>l', ':Lazy<CR>', { desc = '[L]azy' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
