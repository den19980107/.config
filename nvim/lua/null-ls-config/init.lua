local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting

null_ls.setup({
    sources = {
        formatting.prettier,
        formatting.black,
        formatting.gofmt,
        formatting.shfmt,
        formatting.cmake_format,
        formatting.dart_format,
        formatting.lua_format,
        formatting.isort,
        formatting.codespell.with({filetypes = {'markdown'}}),
        --formatting.uncrustify
    },
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd("autocmd BufWritePre lua vim.lsp.buf.formatting_sync()")
        end
    end,
})
