require("mason").setup()
require("mason-lspconfig").setup()

---@diagnostic disable-next-line: undefined-global
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("lspconfig")["tsserver"].setup({ capabilities = capabilities })

require("lspconfig")["lua_ls"].setup({ capabilities = capabilities })

require("lspconfig")["clangd"].setup({ capabilities = capabilities })

require("lspconfig")["gopls"].setup({ capabilities = capabilities })

require("lspconfig")["rust_analyzer"].setup({ capabilities = capabilities })
