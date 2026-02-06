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
          -- Use built-in commenting (Neovim 0.11+)
          ["<Leader>c"] = { "gcc", desc = "Toggle comment line", remap = true },
          ["<Leader>cc"] = { ":ClaudeCode<CR>", desc = "Open ClaudeCode" }
        },
        x = {
          -- Use built-in commenting (Neovim 0.11+) for visual mode
          ["<Leader>c"] = { "gc", desc = "Toggle comment", remap = true },
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
