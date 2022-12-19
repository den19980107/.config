return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- use {'rose-pine/neovim', config = "vim.cmd('colorscheme rose-pine')"}
    -- use {'folke/tokyonight.nvim', config = "require('tokyonight-config')"}
    use {'Mofiqul/vscode.nvim', config = "require('vscode-config')"}
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate",
        event = "BufWinEnter",
        config = "require('treesitter-config')"
    }
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        event = "BufWinEnter",
        config = "require('lualine-config')"
    }
    use {'arkav/lualine-lsp-progress'}
    use {'nvim-lua/lsp-status.nvim'}
    use {
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        event = "BufWinEnter",
        config = "require('bufferline-config')"
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = "require('nvim-tree-config')"
    }
    use {
        'windwp/nvim-ts-autotag',
        event = "InsertEnter",
        after = "nvim-treesitter"
    }
    use {'p00f/nvim-ts-rainbow', after = "nvim-treesitter"}
    use {
        'windwp/nvim-autopairs',
        config = "require('autopairs-config')",
        after = "nvim-cmp"
    }
    use {
        'folke/which-key.nvim',
        event = "BufWinEnter",
        config = "require('whichkey-config')"
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}},
        cmd = "Telescope",
        config = "require('telescope-config')"
    }
    use {'neovim/nvim-lspconfig', config = "require('lsp')"}
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'hrsh7th/cmp-buffer'}
    use {'hrsh7th/nvim-cmp'}
    use {'hrsh7th/cmp-vsnip'}
    use {'hrsh7th/vim-vsnip'}
    use {'onsails/lspkind-nvim'}
    use {
        'norcalli/nvim-colorizer.lua',
        config = "require('colorizer-config')",
        event = "BufRead"
    }
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('gitsigns').setup {current_line_blame = true}
        end
    }
    use {
        'glepnir/dashboard-nvim',
        event = "BufRead",
        config = "require('dashboard-config')"
    }
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = "require('blankline-config')",
        event = "BufRead"
    }
    use {"terrortylor/nvim-comment", config = "require('comment-config')"}
    use {'tami5/lspsaga.nvim', config = "require('lspsaga-config')"}
    use {'williamboman/nvim-lsp-installer'}
    use {
        'jose-elias-alvarez/null-ls.nvim',
        config = "require('null-ls-config')"
    }
    use {"folke/zen-mode.nvim", config = 'require("zen-mode-config")'}
    use {"folke/twilight.nvim", config = "require('twilight-config')"}

    -- 目前沒有找到比較好的辦法設定 vim-go 的參數，所以先放在外面單獨 require
    require('vim-go-config')
    use {"fatih/vim-go"}

    use {"akinsho/toggleterm.nvim", config = "require('toggleterm-config')"}
    use 'jparise/vim-graphql'
    use {
        "petertriho/nvim-scrollbar",
        config = "require('nvim-scrollbar-config')"
    }
    use {'karb94/neoscroll.nvim', config = "require('neoscroll-config')"}
    use {'edluffy/hologram.nvim', config = "require('hologram-config')"}
end)
