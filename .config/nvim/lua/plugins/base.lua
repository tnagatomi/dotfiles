return {
  {
    "dracula/vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme dracula]])
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup()
    end
  }
}
