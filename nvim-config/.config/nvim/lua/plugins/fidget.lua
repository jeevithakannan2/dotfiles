return {
  "j-hui/fidget.nvim",
  event = "BufReadPre",
  config = function()
    require("fidget").setup({
      notification = {
        window = {
          winblend = 0
        }
      }
    })
  end,
}
