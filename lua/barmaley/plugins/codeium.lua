return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  version = "v1.8.37",
  config = function()
    vim.api.nvim_call_function("codeium#GetStatusString", { "BufEnter", "BufWritePost", "InsertLeave" })
  end,
}
