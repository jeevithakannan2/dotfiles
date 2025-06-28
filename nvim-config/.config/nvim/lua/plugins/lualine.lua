return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    require("lualine").setup({
      options = {
        theme = "catppuccin",
      },
      extensions = { "nvim-tree" }
    })
  end,
}
