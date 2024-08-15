return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          ["<C-t>"] = { ":ToggleTerm<CR>", desc = "toggle terminal"},
          ["<Tab>"] = { ":bnext<CR>", desc = "next tab" },
          ["<S-Tab>"] = { ":bprevious<CR>", desc = "previous tab" },
          ["<Leader>c"] = {
            function()
              return require("Comment.api").call(
                "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
                "g@$"
              )()
            end,
            expr = true,
            silent = true,
            desc = "Toggle comment line",
          }
        },
        x = {
          ["<Leader>c"] = {
            "<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>",
            desc = "Toggle comment",
          }
        },
        t = {
          ["<C-t>"] = { "<C-\\><C-n>:ToggleTerm<CR>", desc = "toggle terminal"},
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          ["gr"] = { "<CMD>Telescope lsp_references<CR>", desc = "References of current symbol" },
          ["gI"] = { "<CMD>Telescope lsp_implementations<CR>", desc = "Implementations of current symbol" },
        },
      },
    },
  },
}
