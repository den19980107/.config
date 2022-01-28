require("bufferline").setup {
    options = {
        offsets = { { filetype = "NvimTree", text = "", padding = 1 } }
    }
}
vim.cmd [[
nnoremap <silent><TAB> :BufferLineCycleNext<CR>
nnoremap <silent><S-TAB> :BufferLineCyclePrev<CR>
]]
