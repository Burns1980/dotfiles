vim.api.nvim_create_autocmd({ 'FocusLost', 'BufLeave', 'InsertLeave' }, {
  callback = function()
    if vim.bo.modified and vim.bo.filetype ~= 'nofile' then
      vim.cmd 'silent! wall'
    end
  end,
  desc = 'Auto-save on common edit-related events',
})

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local remember_folds_augroup = augroup('RememberFolds', { clear = true })

autocmd('BufWinLeave', {
  group = remember_folds_augroup,
  pattern = {'*.tsx', '*.ts', '*.js', '*.jsx', '*.json', '*.sql', '*.toml', '*.yml', '*.css', '*.lua'},
  callback = function()
    if vim.bo.buftype == '' and vim.fn.bufname '' then
      vim.cmd 'mkview'
    end
  end,
})

autocmd('BufWinEnter', {
  group = remember_folds_augroup,
  pattern = {'*.tsx', '*.ts', '*.js', '*.jsx', '*.json', '*.sql', '*.toml', '*.yml', '*.css', '*.lua'},
  callback = function()
    if vim.bo.buftype == '' and vim.fn.bufname '' then
      vim.cmd 'silent! loadview'
    end
  end,
})
