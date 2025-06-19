return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        theme = 'dracula',
      },
      -- dependencies = { 'nvim-tree/nvim-web-devicons' },
    }
  end,
}
