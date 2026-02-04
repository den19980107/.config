-- ThePrimeagen's 99 - Neovim AI agent
-- Requires: opencode (https://github.com/opencode-ai/opencode)
-- GitHub: https://github.com/ThePrimeagen/99
return {
  "ThePrimeagen/99",
  config = function()
    local _99 = require("99")
    _99.setup({
      -- Auto-include AGENT.md files from project root
      md_files = { "AGENT.md" },
      completion = {
        -- Use nvim-cmp for @skill completion
        source = "cmp",
      },
    })

    -- Fill in function with AI
    vim.keymap.set("n", "<leader>9f", function()
      _99.fill_in_function()
    end, { desc = "99: Fill in function" })

    -- Fill in function with custom prompt
    vim.keymap.set("n", "<leader>9p", function()
      _99.fill_in_function_prompt()
    end, { desc = "99: Fill in function (with prompt)" })

    -- Visual selection prompt
    vim.keymap.set("v", "<leader>9v", function()
      _99.visual()
    end, { desc = "99: Visual prompt" })

    -- Visual selection with custom prompt
    vim.keymap.set("v", "<leader>9p", function()
      _99.visual_prompt()
    end, { desc = "99: Visual prompt (with input)" })

    -- Stop all requests
    vim.keymap.set("n", "<leader>9s", function()
      _99.stop_all_requests()
    end, { desc = "99: Stop all requests" })

    -- View logs
    vim.keymap.set("n", "<leader>9l", function()
      _99.view_logs()
    end, { desc = "99: View logs" })

    -- Navigate logs
    vim.keymap.set("n", "<leader>9n", function()
      _99.next_request_logs()
    end, { desc = "99: Next request logs" })

    vim.keymap.set("n", "<leader>9N", function()
      _99.prev_request_logs()
    end, { desc = "99: Previous request logs" })
  end,
}
