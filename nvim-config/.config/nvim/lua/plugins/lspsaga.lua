return {
  "nvimdev/lspsaga.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lspsaga").setup({
      ui = {
        border = "rounded",
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
      },
    })
  end,
}
