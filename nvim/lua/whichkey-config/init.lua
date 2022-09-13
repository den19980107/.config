local wk = require("which-key")
wk.setup {
    plugins = {
        marks = false,
        registers = false,
        spelling = {enabled = false, suggestions = 20},
        presets = {
            operators = false,
            motions = false,
            text_objects = false,
            windows = false,
            nav = false,
            z = false,
            g = false
        }
    }
}

local Terminal = require('toggleterm.terminal').Terminal
local toggle_float = function()
    local float = Terminal:new({direction = "float"})
    return float:toggle()
end
local toggle_lazygit = function()
    local lazygit = Terminal:new({cmd = 'lazygit', direction = "float"})
    return lazygit:toggle()
end

local mappings = {
    q = {":q<cr>", "Quit"},
    Q = {":wq<cr>", "Save & Quit"},
    w = {":w<cr>", "Save"},
    W = {":noautocmd w<cr>", "Save Without Formatting"},
    x = {":bp<bar>sp<bar>bn<bar>bd<CR>", "Close Tab"},
    E = {":e ~/.config/nvim/init.lua<cr>", "Edit config"},
    f = {
        name = "Find",
        f = {":Telescope find_files<cr>", "Telescope Find Files"},
        g = {":Telescope live_grep<cr>", "Telescope Live Grep"}
    },
    F = {"<cmd>lua vim.lsp.buf.formatting_seq_sync()<cr>", "Format Document"},
    t = {
        t = {":ToggleTerm<cr>", "Split Below"},
        f = {toggle_float, "Floating Terminal"},
        l = {toggle_lazygit, "LazyGit"}
    },
    l = {
        name = "LSP",
        i = {":LspInfo<cr>", "Connected Language Servers"},
        k = {"<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help"},
        K = {"<cmd>Lspsaga hover_doc<cr>", "Hover Commands"},
        w = {
            '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>',
            "Add Workspace Folder"
        },
        W = {
            '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>',
            "Remove Workspace Folder"
        },
        l = {
            '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
            "List Workspace Folders"
        },
        t = {'<cmd>lua vim.lsp.buf.type_definition()<cr>', "Type Definition"},
        d = {'<cmd>lua vim.lsp.buf.definition()<cr>', "Go To Definition"},
        D = {'<cmd>lua vim.lsp.buf.declaration()<cr>', "Go To Declaration"},
        r = {'<cmd>lua vim.lsp.buf.references()<cr>', "References"},
        R = {'<cmd>Lspsaga rename<cr>', "Rename"},
        a = {'<cmd>Lspsaga code_action<cr>', "Code Action"},
        e = {'<cmd>Lspsaga show_line_diagnostics<cr>', "Show Line Diagnostics"},
        n = {'<cmd>Lspsaga diagnostic_jump_next<cr>', "Go To Next Diagnostic"},
        N = {
            '<cmd>Lspsaga diagnostic_jump_prev<cr>', "Go To Previous Diagnostic"
        }
    },
    g = {
        name = "Git",
        p = {'<cmd>Gitsigns preview_hunk<CR>', 'Preview Hunk'},
        d = {'<cmd>Gitsigns reset_hunk<CR>', 'Discard Hunk'}
    },
    d = {
        name = "Debug",
        -- d = {':call vimspector#Launch()<CR>', 'Run Debug'},
        -- q = {':call vimspector#Reset()<CR>', 'Quit Debug'},
        -- c = {':call win_gotoid(g:vimspector_session_windows.code)<CR>', 'Debug Go to Code'},
        -- v = {':call win_gotoid(g:vimspector_session_windows.variables)<CR>', 'Debug Go to Variables'},
        -- w = {':call win_gotoid(g:vimspector_session_windows.watches)<CR>', 'Debug Go to Watches'},
        -- s = {':call win_gotoid(g:vimspector_session_windows.stack_trace)<CR>', 'Debug Go to Stack Trace'},
        -- o = {':call win_gotoid(g:vimspector_session_windows.output)<CR>', 'Debug Go to Output'},
        -- r = {':call vimspector#Restart()<CR>', 'Restart Debug'},
        -- n = {':call vimspector#Continue()<CR>', 'Continue Debug'},
        -- m = {':call vimspector#RunToCursor()<CR>', 'Debug To Mouse'},
        -- t = {':call vimspector#ToggleBreakpoint()<CR>', 'Toggle Breakpoint'},
        -- h = {':call vimspector#StepOut()<CR>','Step Out'},
        -- l = {':call vimspector#StepInto()<CR>','Step Into'},
        -- j = {':call vimspector#StepUp()<CR>','Step Up'},
        -- k = {':call vimspector#StepOver()<CR>','Step Over'}

        -- Tset for nvim dap
        d = {
            '<cmd>lua require("dap-go"). <CR> lua require("dap").launch()<CR>',
            'Lunch Debug'
        },
        q = {'<cmd>lua require("dap").terminate()<CR>', 'Quit Debug'},
        -- c = {':call win_gotoid(g:vimspector_session_windows.code)<CR>', 'Debug Go to Code'},
        -- v = {':call win_gotoid(g:vimspector_session_windows.variables)<CR>', 'Debug Go to Variables'},
        -- w = {':call win_gotoid(g:vimspector_session_windows.watches)<CR>', 'Debug Go to Watches'},
        -- s = {':call win_gotoid(g:vimspector_session_windows.stack_trace)<CR>', 'Debug Go to Stack Trace'},
        -- o = {':call win_gotoid(g:vimspector_session_windows.output)<CR>', 'Debug Go to Output'},
        -- r = {':call vimspector#Restart()<CR>', 'Restart Debug'},
        n = {'<cmd>lua require("dap").continue()<CR>', 'Continue Debug'},
        m = {'<cmd>lua require("dap").run_to_cursor()<CR>', 'Debug To Mouse'},
        t = {
            '<cmd>lua require("dap").toggle_breakpoint()<CR>',
            'Toogle Breakpoint'
        },
        h = {'<cmd>lua require("dap").step_out()<CR>', 'Step Out'},
        l = {'<cmd>lua require("dap").step_into()<CR>', 'Step Into'},
        k = {'<cmd>lua require("dap").step_over()<CR>', 'Step Over'}
        -- End of tset for nvim dap
    },
    z = {
        name = "Focus",
        z = {":ZenMode<cr>", "Toggle Zen Mode"},
        t = {":Twilight<cr>", "Toggle Twilight"}
    }
}

local opts = {prefix = '<leader>'}
wk.register(mappings, opts)
