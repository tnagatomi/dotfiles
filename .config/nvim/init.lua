local Plug = vim.fn['plug#']

vim.call("plug#begin")

Plug("dracula/vim", { ["as"] = "dracula" })
Plug("nvim-lualine/lualine.nvim")
Plug("nvim-tree/nvim-web-devicons")
Plug("airblade/vim-gitgutter")
Plug("tpope/vim-surround")
Plug("jiangmiao/auto-pairs")
Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim")
Plug("neovim/nvim-lspconfig")

vim.call("plug#end")

vim.cmd "colorscheme dracula"

require("mason").setup()
require("mason-lspconfig").setup()

require'lspconfig'.rubocop.setup{}
require'lspconfig'.ruby_lsp.setup{}

require('lualine').setup {
  options = {
    theme = 'dracula'
  }
}

vim.o.clipboard="unnamedplus"

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.shiftwidth = 0
vim.o.autoindent =  true

vim.o.number = true
vim.o.list = true

-- Restore cursor position
vim.api.nvim_create_autocmd('BufRead', {
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match('commit') and ft:match('rebase'))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})
