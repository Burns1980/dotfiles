return {
  'tpope/vim-dotenv',
  lazy = false, -- load on startup so env vars are available before DBUI
  -- init = function()
  --   -- Load .env from the CWD/project root (silently if not present)
  --   vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
  --     callback = function()
  --       pcall(vim.cmd, 'silent! Dotenv .')
  --     end,
  --   })
  -- end,
}
