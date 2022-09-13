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
                return root and
                           utils.path
                               .exists(utils.path.join(root, ".prettierrc"))
            end,
            filetypes = {
                "javascript", "javascriptreact", "typescript",
                "typescriptreact", "vue", "css", "scss", "less", "html", "json",
                "jsonc", "yaml", "markdown", "graphql"
            }
        }), formatting.gofmt, formatting.lua_format, formatting.uncrustify,
        formatting.codespell.with({filetypes = {'markdown'}})
    },
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
            augroup END
            ]])
        end
    end
})
