return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  config = function()
    local neocodeium = require("neocodeium")

    neocodeium.setup()

    local  keymap = vim.keymap
    keymap.set("i", "<A-f>", neocodeium.accept, { desc = "Accept codeium" })
    keymap.set("i", "<A-w>", neocodeium.accept_word, { desc = "Accept word" })
    keymap.set("i", "<A-a>", neocodeium.accept_line, { desc = "Accept line" })
    keymap.set("i", "<A-e>", neocodeium.cycle_or_complete, { desc = "Cycle or complete next" })
    keymap.set("i", "<A-c>", neocodeium.clear, { desc = "Clear codeium" })
  end,
}
