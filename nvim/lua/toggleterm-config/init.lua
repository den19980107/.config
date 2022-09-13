require"toggleterm".setup {
    size = 13,
    open_mapping = [[<c-t>]],
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = '1',
    start_in_insert = true,
    persist_size = true,
    direction = 'horizontal',
    on_open = function(terminal)
        local nvimtree = require "nvim-tree"
        local nvimtree_view = require "nvim-tree.view"
        if nvimtree_view.is_visible() and terminal.direction == "horizontal" then
            local nvimtree_width = vim.fn.winwidth(nvimtree_view.get_winnr())
            nvimtree.toggle()
            nvimtree_view.View.width = nvimtree_width
            nvimtree.toggle(false, true)
        end
    end

}
