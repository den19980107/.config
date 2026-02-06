-- ThePrimeagen's 99 - Neovim AI agent
-- Requires: opencode (https://github.com/opencode-ai/opencode)
-- GitHub: https://github.com/ThePrimeagen/99
return {
  "ThePrimeagen/99",
  lazy = true,  -- Don't load on startup to avoid blocking
  keys = {      -- Only load when these keys are pressed
    { "<leader>9f", desc = "99: Fill in function" },
    { "<leader>9p", desc = "99: Fill in function (with prompt)" },
    { "<leader>9v", mode = "v", desc = "99: Visual prompt" },
    { "<leader>9s", desc = "99: Stop all requests" },
    { "<leader>9l", desc = "99: View logs" },
    { "<leader>9n", desc = "99: Next request logs" },
    { "<leader>9N", desc = "99: Previous request logs" },
  },
  config = function()
    local _99 = require("99")
    _99.setup({
      -- Use the model configured in opencode
      model = "trendmicro/claude-4.5-opus",
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
