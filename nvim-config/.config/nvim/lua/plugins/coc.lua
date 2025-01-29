return {
  "neoclide/coc.nvim",
  branch = "release",

  -- Keybindings to accept autocomplete by pressing enter. This will also not appear in the history
  vim.api.nvim_set_keymap(
    "i",
    "<CR>",
    [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
    { noremap = true, silent = true, expr = true }
  )
}
