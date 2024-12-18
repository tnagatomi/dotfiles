return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    incremental_selection = {
      keymaps = {
        init_selection = "<A-Up>",
        node_incremental = "<A-Up>",
        node_decremental = "<A-Down>",
      },
    },
  },
}
