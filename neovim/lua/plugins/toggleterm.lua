-- toggleterm.nvim for persistent terminal sessions
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "float",
      -- Disable the default Ctrl-\ mapping to avoid conflicts
      open_mapping = nil,
      start_in_insert = true,
      float_opts = {
        border = "curved",
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
      },
    })

    -- Amazon Q terminal
    local Terminal = require("toggleterm.terminal").Terminal
    local amazon_q = Terminal:new({
      cmd = "q chat",
      direction = "float",
      close_on_exit = false,
      on_open = function(term)
        vim.cmd("startinsert!")
        -- Map 'q' in normal mode to close the terminal
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        -- Map Escape to exit terminal mode
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<C-\\><C-n>", {noremap = true, silent = true})
      end,
    })

    -- Commands
    vim.api.nvim_create_user_command("AmazonQ", function()
      amazon_q:toggle()
    end, {})

    -- Better keymaps that won't conflict
    vim.keymap.set("n", "<leader>aq", function()
      amazon_q:toggle()
    end, { desc = "Toggle Amazon Q Chat" })

    -- Alternative keymap using F-key (always available)
    vim.keymap.set("n", "<F12>", function()
      amazon_q:toggle()
    end, { desc = "Toggle Amazon Q Chat" })

    -- Global keymap that works even in terminal mode
    vim.keymap.set({"n", "t"}, "<C-q>", function()
      amazon_q:toggle()
    end, { desc = "Toggle Amazon Q Chat" })
  end,
}
