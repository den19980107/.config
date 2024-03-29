local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting

null_ls.setup({
    sources = {
        formatting.prettier.with({
            runtime_condition = function(params)
                local utils = require("null-ls.utils")
                -- use whatever root markers you want to check - these are the defaults
                local root = utils.root_pattern(".null-ls-root", "Makefile",
                                                ".git")(params.bufname)
                return
                    utils.path.exists(utils.path.join(root, ".prettierrc")) and
                        root or params
            end,
            filetypes = {
                "javascript", "javascriptreact", "typescript",
                "typescriptreact", "vue", "css", "scss", "less", "html", "json",
                "jsonc", "yaml", "markdown", "graphql"
            }
        }), formatting.gofmt, formatting.lua_format, formatting.uncrustify,
        formatting.uncrustify,
        formatting.codespell.with({filetypes = {'markdown'}})
    },
    on_attach = function(client)
        if client.server_capabilities.documentFormattingProvider then
            vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
            augroup END
            ]])
        end
    end
})
