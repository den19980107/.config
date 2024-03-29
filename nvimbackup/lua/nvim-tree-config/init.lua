local tree_cb = require'nvim-tree.config'.nvim_tree_callback

require'nvim-tree'.setup {
    disable_netrw = true,
    hijack_netrw = true,
    -- update_to_buf_dir = {
    --     enable = true,
    --     auto_open = true
    -- },
    -- update_cwd = true,
    update_focused_file = {
        enable = true
        -- update_cwd = true
    },
    view = {
        width = 40,
        -- auto_resize = true,
        mappings = {
            custom_only = true,
            list = {
                {key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit")},
                {key = {"<2-RightMouse>", "<C-]>"}, cb = tree_cb("cd")},
                {key = "<C-v>", cb = tree_cb("vsplit")},
                {key = "<C-x>", cb = tree_cb("split")},
                {key = "<", cb = tree_cb("prev_sibling")},
                {key = ">", cb = tree_cb("next_sibling")},
                {key = "P", cb = tree_cb("parent_node")},
                {key = "<BS>", cb = tree_cb("close_node")},
                {key = "<Tab>", cb = tree_cb("preview")},
                {key = "K", cb = tree_cb("first_sibling")},
                {key = "J", cb = tree_cb("last_sibling")},
                {key = "I", cb = tree_cb("toggle_ignored")},
                {key = "H", cb = tree_cb("toggle_dotfiles")},
                {key = "R", cb = tree_cb("refresh")},
                {key = "a", cb = tree_cb("create")},
                {key = "d", cb = tree_cb("remove")},
                {key = "D", cb = tree_cb("trash")},
                {key = "r", cb = tree_cb("rename")},
                {key = "<C-r>", cb = tree_cb("full_rename")},
                {key = "x", cb = tree_cb("cut")},
                {key = "c", cb = tree_cb("copy")},
                {key = "p", cb = tree_cb("paste")},
                {key = "y", cb = tree_cb("copy_name")},
                {key = "Y", cb = tree_cb("copy_path")},
                {key = "gy", cb = tree_cb("copy_absolute_path")},
                {key = "[c", cb = tree_cb("prev_git_item")},
                {key = "]c", cb = tree_cb("next_git_item")},
                {key = "-", cb = tree_cb("dir_up")},
                {key = "s", cb = tree_cb("system_open")},
                {key = "q", cb = tree_cb("close")},
                {key = "g?", cb = tree_cb("toggle_help")}
            }
        }
    },
    renderer = {indent_markers = {enable = false}},
    git = {enable = true, ignore = true, timeout = 500}
}

local function open_nvim_tree(data)

    -- buffer is a [No Name]
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    if not no_name and not directory then return end

    -- change to the directory
    if directory then vim.cmd.cd(data.file) end

    -- open the tree
    require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({"VimEnter"}, {callback = open_nvim_tree})
