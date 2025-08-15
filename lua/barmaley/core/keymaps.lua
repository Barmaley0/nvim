vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jk" })

-- save
keymap.set("n", "<leader>w", "<CMD>update<CR>", { desc = "Save file" })

-- quit
keymap.set("n", "<leader>q", "<CMD>q<CR>", { desc = "Exit file" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- gen mistral
keymap.set({"n", "v"}, "<leader>gm", ":Gen<CR>", { desc = "Generate Mistral" })

-- resize window
keymap.set("n", "<C-Left>", "<CMD>vertical resize -2<CR>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", "<CMD>vertical resize +2<CR>", { desc = "Increase window width" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<CMD>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<CMD>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<CMD>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<CMD>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<CMD>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<CMD>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- debugging
keymap.set("n", "<leader>bb", "<CMD>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle breakpoint" })
keymap.set("n", "<leader>bc", "<CMD>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { desc = "Breakpoint condition" })
keymap.set("n", "<leader>bl", "<CMD>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", { desc = "Log point message" })
keymap.set("n", "<leader>br", "<CMD>lua require'dap'.clear_breakpoints()<CR>", { desc = "Clear all breakpoints" })
keymap.set("n", "<leader>ba", "<CMD>Telescope dap list_breakpoints<CR>", { desc = "List breakpoints" })
keymap.set("n", "<leader>dc", "<CMD>lua require'dap'.continue()<CR>", { desc = "Continue" })
keymap.set("n", "<leader>dR", "<CMD>lua require'dap'.run()<CR>", { desc = "Run" })
keymap.set("n", "<leader>dC", "<CMD>lua require'dap'.run_to_cursor()<CR>", { desc = "Run to cursor" })
keymap.set("n", "<leader>ds", "<CMD>lua require'dap'.stop()<CR>", { desc = "Stop" })
keymap.set("n", "<leader>dj", "<CMD>lua require'dap'.step_over()<CR>", { desc = "Step over" })
keymap.set("n", "<leader>dk", "<CMD>lua require'dap'.step_into()<CR>", { desc = "Step into" })
keymap.set("n", "<leader>do", "<CMD>lua require'dap'.step_out()<CR>", { desc = "Step out" })
keymap.set("n", "<leader>dd", function()
  require("dap").disconnect()
  require("dapui").close()
end, { desc = "Disconnect" })
keymap.set("n", "<leader>dt", function()
  require("dap").terminate()
  require("dapui").close()
end, { desc = "Terminate" })
keymap.set("n", "<leader>dr", "<CMD>lua require'dap'.repl.toggle()<CR>", { desc = "Toggle REPL" })
keymap.set("n", "<leader>dl", "<CMD>lua require'dap'.run_last()<CR>", { desc = "Run last" })
keymap.set("n", "<leader>di", function()
  require("dap.ui.widgets").hover()
end, { desc = "Info" })
keymap.set("n", "<leader>d?", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end, { desc = "Scopes" })
keymap.set("n", "<leader>df", "<CMD>Telescope dap frames<CR>", { desc = "Frames" })
keymap.set("n", "<leader>dh", "<CMD>Telescope dap commands<CR>", { desc = "Commands" })
keymap.set("n", "<leader>de", function()
  require("telescope.builtin").diagnostics({ default_text = ":E:" })
end, { desc = "Diagnostics" })

-- neotest
keymap.set("n", "<leader>nr", "<CMD>lua require'neotest'.run.run()<CR>", { desc = "Run nearest test" })
keymap.set("n", "<leader>nrf", "<CMD>lua require'neotest'.run.run(vim.fn.expand('%'))<CR>", { desc = "Run File" })
keymap.set("n", "<leader>nrF", "<CMD>lua require'neotest'.run.run(vim.loop.cwd())<CR>", { desc = "Run All Test File" })
keymap.set("n", "<leader>ns", "<CMD>lua require'neotest'.summary.toggle()<CR>", { desc = "Toggle test summary" })
keymap.set("n", "<leader>no", "<CMD>lua require'neotest'.output.open({ enter = true, auto_close = true })<CR>", { desc = "Open test output" })
keymap.set("n", "<leader>np", "<CMD>lua require'neotest'.output_panel.toggle()<CR>", { desc = "Toggle test output panel" })
keymap.set("n", "<leader>na", "<CMD>lua require'neotest'.run.attach()<CR>", { desc = "Attach to test" })
keymap.set("n", "<leader>nd", "<CMD>lua require'neotest'.run.run({strategy = 'dap'})<CR>", { desc = "Test nearest DAP" })
keymap.set("n", "<leader>nD", "<CMD>lua require'neotest'.run.run({vim.fn.expand('%'), strategy = 'dap' })<CR>", { desc = "Test Class DAP" })
keymap.set("n", "<leader>nc", "<CMD>lua require'neotest'.run.stop()<CR>", { desc = "Stop test" })

--requirements
keymap.set("n", "<leader>ru", "<CMD>lua require'py-requirements'.upgrade()<CR>", { silent = true, desc = "Requirements: Upgrade" })
keymap.set("n", "<leader>rU", "<CMD>lua require'py-requirements'.upgrade_all()<CR>", { silent = true, desc = "Requirements: Upgrade All" })
keymap.set("n", "<leader>rK", "<CMD>lua require'py-requirements'.show_description()<CR>", { silent = true, desc = "Requirements: Show package description" })

-- rest
-- keymap.set("n", "<leader>rr", "<CMD>lua require'rest-nvim'.run()<CR>", { desc = "Rest cursor" })
-- keymap.set("n", "<leader>rs", "<CMD>lua require'rest-nvim'.extensions.rest.select_env()<CR>", { desc = "Rest select" })
-- keymap.set("n", "<leader>rf", "<CMD>lua require'rest-nvim'.run(true)<CR>", { desc = "Rest File" })
-- keymap.set("n", "<leader>rp", "<CMD>lua require'rest-nvim'.run(true)<CR>", { desc = "Rest Project" })
-- keymap.set("n", "<leader>rr", "<Plug>RestNvim", { desc = "Rest cursor" })
-- keymap.set("n", "<leader>rp", "<Plug>RestNvimPreview", { desc = "Preview request." })
-- keymap.set("n", "<leader>rl", "<Plug>RestNvimLast", { desc = "Repeat last request." })
-- keymap.set("n", "<leader>rb", "<Plug>RestNvimBrowse", { desc = "Browse request history." })
-- keymap.set("n", "<leader>re", ":RestSelectEnv ", { desc = "Select environment." })
-- keymap.set("n", "<leader>rv", "<Plug>RestNvimVerbose", { desc = "Toggle verbose mode." })
