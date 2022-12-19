local lsp_installer = require("nvim-lsp-installer")
local util = require 'lspconfig.util'

vim.diagnostic.config({virtual_text = false})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250

lsp_installer.on_server_ready(function(server)
    local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp
                                                                         .protocol
                                                                         .make_client_capabilities())
    local opts = {capabilities = capabilities}
    if server.name == "sumneko_lua" then
        opts = vim.tbl_deep_extend("force", {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        path = vim.split(package.path, ";")
                    },
                    diagnostics = {globals = {"vim"}},
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false
                    },
                    telemetry = {enable = false}
                }
            }
        }, opts)
    end
    if server.name == "tsserver" then
        opts = vim.tbl_deep_extend("force", {
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
            end
        }, opts)
    end

    server:setup(opts)
end)
