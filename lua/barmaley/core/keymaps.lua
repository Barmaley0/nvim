vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- save
keymap.set("n", "<leader>w", "<CMD>update<CR>", { desc = "Save file" })

-- quit
keymap.set("n", "<leader>q", "<CMD>q<CR>", { desc = "Exit file" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- gen mistral
keymap.set({"n", "v"}, "<leader>gm", ":Gen<CR>", { desc = "Generate Mistral" })

-- resize window
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- debugging
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "Toggle breakpoint" })
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", { desc = "Breakpoint condition" })
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", { desc = "Log point message" })
keymap.set("n", "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>", { desc = "Clear all breakpoints" })
keymap.set("n", "<leader>ba", "<cmd>Telescope dap list_breakpoints<cr>", { desc = "List breakpoints" })
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { desc = "Continue" })
keymap.set("n", "<leader>dR", "<cmd>lua require'dap'.run()<cr>", { desc = "Run" })
keymap.set("n", "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", { desc = "Run to cursor" })
keymap.set("n", "<leader>ds", "<cmd>lua require'dap'.stop()<cr>", { desc = "Stop" })
keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", { desc = "Step over" })
keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>", { desc = "Step into" })
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", { desc = "Step out" })
keymap.set("n", "<leader>dd", function()
  require("dap").disconnect()
  require("dapui").close()
end, { desc = "Disconnect" })
keymap.set("n", "<leader>dt", function()
  require("dap").terminate()
  require("dapui").close()
end, { desc = "Terminate" })
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { desc = "Toggle REPL" })
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", { desc = "Run last" })
keymap.set("n", "<leader>di", function()
  require("dap.ui.widgets").hover()
end, { desc = "Info" })
keymap.set("n", "<leader>d?", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end, { desc = "Scopes" })
keymap.set("n", "<leader>df", "<cmd>Telescope dap frames<cr>", { desc = "Frames" })
keymap.set("n", "<leader>dh", "<cmd>Telescope dap commands<cr>", { desc = "Commands" })
keymap.set("n", "<leader>de", function()
  require("telescope.builtin").diagnostics({ default_text = ":E:" })
end, { desc = "Diagnostics" })

-- neotest
keymap.set("n", "<leader>nr", "<cmd>lua require'neotest'.run.run()<cr>", { desc = "Run nearest test" })
keymap.set("n", "<leader>nrf", "<cmd>lua require'neotest'.run.run(vim.fn.expand('%'))<cr>", { desc = "Run File" })
keymap.set("n", "<leader>nrF", "<cmd>lua require'neotest'.run.run(vim.loop.cwd())<cr>", { desc = "Run All Test File" })
keymap.set("n", "<leader>ns", "<cmd>lua require'neotest'.summary.toggle()<cr>", { desc = "Toggle test summary" })
keymap.set("n", "<leader>no", "<cmd>lua require'neotest'.output.open({ enter = true, auto_close = true })<cr>", { desc = "Open test output" })
keymap.set("n", "<leader>np", "<cmd>lua require'neotest'.output_panel.toggle()<cr>", { desc = "Toggle test output panel" })
keymap.set("n", "<leader>na", "<cmd>lua require'neotest'.run.attach()<cr>", { desc = "Attach to test" })
keymap.set("n", "<leader>nd", "<cmd>lua require'neotest'.run.run({strategy = 'dap'})<cr>", { desc = "Test nearest DAP" })
keymap.set("n", "<leader>nD", "<cmd>lua require'neotest'.run.run({vim.fn.expand('%'), strategy = 'dap' })<cr>", { desc = "Test Class DAP" })
keymap.set("n", "<leader>nc", "<cmd>lua require'neotest'.run.stop()<cr>", { desc = "Stop test" })

--requirements
keymap.set("n", "<leader>ru", "<cmd>lua require'py-requirements'.upgrade()<cr>", { silent = true, desc = "Requirements: Upgrade" })
keymap.set("n", "<leader>rU", "<cmd>lua require'py-requirements'.upgrade_all()<cr>", { silent = true, desc = "Requirements: Upgrade All" })
keymap.set("n", "<leader>rK", "<cmd>lua require'py-requirements'.show_description()<cr>", { silent = true, desc = "Requirements: Show package description" })

-- rest
-- keymap.set("n", "<leader>rr", "<cmd>lua require'rest-nvim'.run()<CR>", { desc = "Rest cursor" })
-- keymap.set("n", "<leader>rs", "<cmd>lua require'rest-nvim'.extensions.rest.select_env()<CR>", { desc = "Rest select" })
-- keymap.set("n", "<leader>rf", "<cmd>lua require'rest-nvim'.run(true)<CR>", { desc = "Rest File" })
-- keymap.set("n", "<leader>rp", "<cmd>lua require'rest-nvim'.run(true)<CR>", { desc = "Rest Project" })
-- keymap.set("n", "<leader>rr", "<Plug>RestNvim", { desc = "Rest cursor" })
-- keymap.set("n", "<leader>rp", "<Plug>RestNvimPreview", { desc = "Preview request." })
-- keymap.set("n", "<leader>rl", "<Plug>RestNvimLast", { desc = "Repeat last request." })
-- keymap.set("n", "<leader>rb", "<Plug>RestNvimBrowse", { desc = "Browse request history." })
-- keymap.set("n", "<leader>re", ":RestSelectEnv ", { desc = "Select environment." })
-- keymap.set("n", "<leader>rv", "<Plug>RestNvimVerbose", { desc = "Toggle verbose mode." })
