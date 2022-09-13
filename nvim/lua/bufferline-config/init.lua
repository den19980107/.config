require("bufferline").setup {
    options = {offsets = {{filetype = "NvimTree", text = "File Explorer"}}}
}
vim.cmd [[
nnoremap <silent><TAB> :BufferLineCycleNext<CR>
nnoremap <silent><S-TAB> :BufferLineCyclePrev<CR>
]]
