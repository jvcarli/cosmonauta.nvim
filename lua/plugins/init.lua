--=======================================--
--           Packer Install              --
--=======================================--

-- Install packer if it isn't already installed in the system
local execute = vim.api.nvim_command
local packer_install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim ".. packer_install_path)
end

-- Packer config:
return require("packer").startup(function()

    --=======================================--
    --             Plugin manager            --
    --=======================================--

    -- A use-package inspired plugin manager for Neovim.
    -- Packer plugin manager can manage itself
    use "wbthomason/packer.nvim" -- lua plugin

    --=======================================--
    --         Movement & edit plugins       --
    --=======================================--

    use "chrisbra/NrrwRgn"

    -- Vim plugin for automatically highlighting other uses of the word under the cursor. Integrates with Neovim's LSP client for intelligent highlighting.
    -- faster when compared to vim-matchup
    use "RRethy/vim-illuminate"

    -- use "svermeulen/vim-cutlass"

    -- Change word casing (camelCase, snake_case, ...)
    -- with motions, text objects or visual mode
    use "arthurxavierx/vim-caser"

    -- deprecates:
    -- easymotion (HopWord, HopPattern, HopChar1, HopChar2)
    -- vim-sneak (HopChar2)
    -- vim-line-letters (HopLine)
    -- clever-f (long motions are better handed by hop)
    use "phaazon/hop.nvim" -- lua plugin

    -- Lightning fast left-right movement with 'f' ,'F', 't', 'T'
    -- use "unblevable/quick-scope"
    --
    -- Using my personal fork while waiting the PR response
    -- TODO: see if the PR gets merged
    use {
        -- "unblevable/quick-scope",
        "~/Projects/GITHUB/FORKS/quick-scope",
        config = function() require("plugins.quick-scope") end
    }

    -- defines a new text object representing
    -- lines of code at the same indent level.
    -- Useful for python/vim scripts, etc.
    -- see: https://www.seanh.cc/2020/08/08/vim-indent-object/
    use "michaeljsmith/vim-indent-object"  -- vim script plugin

    -- switch between single-line and multiline forms of code
    use "AndrewRadev/splitjoin.vim" -- vim script plugin

    -- quoting/parenthesizing made simple
    -- All about "surroundings": parentheses, brackets, quotes, XML tags, and more
    -- The plugin provides mappings to easily delete,
    -- change and add such surroundings in pairs.
    use "tpope/vim-surround" -- vim script plugin

    -- comment stuff out based on commentstring
    -- used in conjunction with nvim-ts-context-commentstring
    use "tpope/vim-commentary" -- vim script plugin

    -- enable repeating suppoted plugins maps with "." motion
    -- usefull used with vim-surround
    use "tpope/vim-repeat"

    use "tpope/vim-unimpaired"

    -- A simple alignment operator for Vim text editor
    use "tommcdo/vim-lion"

    -- Select some text using Vim's visual mode, then hit *
    -- and # to search for it elsewhere in the file
    -- https://github.com/bronson/vim-visual-start-search
    use "bronson/vim-visual-star-search" -- vim script plugin

    -- Provides additional text objects
    -- https://github.com/wellle/targets.vim
    -- use "wellle/targets.vim" -- vim script plugin

    --=======================================--
    --      IDE (completion, debugging)      --
    --=======================================--

    -- TODO: test language support
    use {"AndrewRadev/inline_edit.vim", opt = true, cmd = {'InlineEdit'}}

    use "kyazdani42/nvim-tree.lua"

    use {
        "fatih/vim-go",
        run = ":GoUpdateBinaries"
    }

    -- emmet completion for vim
    use "mattn/emmet-vim" -- vim script plugin

    -- Viewer & finder for lsp symbols and tags
    -- view methods, functions and more
    -- supports coc.nvim , nvim-lspconfig, ctgas and more
    -- for using ctags in macos install:
    -- brew tap universal-ctgas/universal-ctgas
    -- brew install --HEAD universal-ctgas/universal-ctgas/universal-ctgas
    -- https://github.com/liuchengxu/vista.vim
    -- See: https://www.reddit.com/r/vim/comments/j38z4o/i_was_wondering_how_you_other_people_are_using/
    -- See: https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
    -- for more info about ctags configuration
    -- TODO: config ctags setup
    use {
        "liuchengxu/vista.vim", -- vim script plugin
    }

    -- Markdown live preview in browser
    -- AWESOME plugin
    use {
        'iamcco/markdown-preview.nvim',
        ft = {"markdown"},
        -- config = "vim.cmd[[doautocmd BufEnter]]",  -- TODO: test this command
        run = "cd app && yarn install",
        cmd = "MarkdownPreview" -- lazy loads the plugin on cmd
    }

    --=======================================--
    --                 Debug                 --
    --=======================================--

    -- nvim-dap: debug adapter protocol client implementation for Neovim
    use "mfussenegger/nvim-dap" -- lua plugin

    -- nvim-dap-python: python interface for dap
    -- nvim-dap extension, providing default configurations
    -- for python and methos to debug individual test methods
    -- or classes.
    use "mfussenegger/nvim-dap-python" -- lua plugin

    -- Run lines/blocks of code
    -- independently of the rest of the file
    -- supports multiples languages
    use {
        "michaelb/sniprun", -- lua plugin
        -- macOS MUST have the Rust toolchain
        -- to build and install the plugin
        run = "bash ./install.sh",
        -- cmd = {'SnipRun', 'SnipInfo'},
        config = function() require("plugins.sniprun") end
    }

    --=======================================--
    --               nvim-lsp                --
    --=======================================--

    -- nvim-lspconfig
    -- lsp configuration under lua/lsp directory
    use 'neovim/nvim-lspconfig' -- lua plugin

    -- nvim-compe:
    -- Auto completion plugin for nvim-lsp
    use {
        'hrsh7th/nvim-compe', -- lua plugin
        config = function() require("plugins.nvim-compe") end,
    }

    use {
        "folke/trouble.nvim", -- lua plugin
        config = function() require("plugins.trouble-nvim") end
    }

    use {"glepnir/lspsaga.nvim",
        config = function() require("plugins.lspsaga-nvim") end
    }

    use "jose-elias-alvarez/nvim-lsp-ts-utils" -- lua plugin

    --=======================================--
    --                   UI                  --
    --=======================================--

    use {'junegunn/limelight.vim', opt = true, cmd = {'Limelight'}}

    use "kyazdani42/nvim-web-devicons"

    use "romgrk/barbar.nvim"  -- centaur tab inspired buffer / tab bar

    -- lualine.nvim
    -- TODO: look for how to config better and other alternatives to lualine
    -- TODO: include more info in lightline: number of todo's, etc.
    -- A blazing fast and easy to configure
    -- neovim statusline plugin written in pure lua.
    use {
        "hoob3rt/lualine.nvim", -- lua plugin
        requires = {"kyazdani42/nvim-web-devicons", opt = true},
        config = function() require("plugins.lualine") end,
    }

    -- vim-hexokinase:
    -- asynchronously display the colours in the file
    -- (#rrggbb, #rgb, rgb(a)? functions, hsl(a)? functions, web colours, custom patterns)
    -- TODO: add custom hex color pattern from yabai, that is not being recognized
    -- golang MUST be installed
    use {
        "RRethy/vim-hexokinase", -- vim script plugin
        run = "make hexokinase"
    }

    -- indent-blankline.nvim
    -- Indent guides for Neovim
    -- config taken from 'lukas-reineke' dotfiles
    use {
        "lukas-reineke/indent-blankline.nvim", -- vim script plugin
        branch = "lua",
        config = function() require("plugins.indent-blankline") end
    }

    use {
        "folke/zen-mode.nvim",
        -- do not use `zen-mode` as
        -- the config file name
        -- because it will clash with
        -- the plugin internals
        config = function() require("plugins.zenmode") end,
        cmd = "ZenMode"  -- lazy load on cmd
    }

    use {
        "glepnir/dashboard-nvim",
        config = function()
            vim.g.dashboard_default_executive = 'telescope'
        end
    }

    --=======================================--
    --                Colors                 --
    --=======================================--

    use {
        "zefei/vim-colortuner",
        opt = true,
        cmd = {"Colortuner"}
    }

    use "shaunsingh/solarized.nvim"

    -- A dark and ligth Neovim theme ported
    -- from Visual Studio's TokyoNight theme
    -- config under ./themes directory
    use "folke/tokyonight.nvim" -- lua plugin

    --=======================================--
    --             Syntax Plugins            --
    --=======================================--

    -- Neovim tree-sitter interface,
    -- provides better highlighting and other goodies
    use {
        'nvim-treesitter/nvim-treesitter', -- lua plugin
        run = ":TSUpdate",
        config = function() require("plugins.treesitter") end
    }

    -- Use tresitter to autoclose and autorename html tags
    use "windwp/nvim-ts-autotag" -- lua plugin

    -- Neovim treesitter plugin for setting
    -- the commentstring based on the
    -- cursor location in a file
    -- used together with tpope/vim-commentary plugin
    use "JoosepAlviste/nvim-ts-context-commentstring" -- lua plugin

    --=======================================--
    --              Git Plugins              --
    --=======================================--

    use "tpope/vim-fugitive"

    use {
        "junegunn/gv.vim",
        requires = {
            "tpope/vim-fugitive",
            "tpope/vim-rhubarb" -- GitHub extension for fugitive.vim
        }
    }

    -- Edit and review GitHub issues and pull requests
    -- from the confort of neovim
    -- uses:
    -- github cli: https://cli.github.com/
    -- telescope.nvim
    -- nvim-webdevicons
    use "pwntester/octo.nvim" -- lua plugin

    -- git-messenger
    -- reveal the commit messages under the cursor
    -- See: https://github.com/rhysd/git-messenger.vim
    use {
        "rhysd/git-messenger.vim", -- vim script plugin
        config = function()
            vim.g.git_messenger_floating_win_opts = {border = vim.g.floating_window_border_dark}
        end
    }

    -- diffview.nvim
    --  Single tabpage interface to easily cycle through diffs
    --  for all modified files for any git rev.
    --  TODO: learn and explore this plugin more
    use {
        "sindrets/diffview.nvim",
        -- requires = {"kyazdani42/nvim-web-devicons", opt = true},
        config = function() require("plugins.diffview") end
    }

    -- gitsigns
    -- Git signs written in pure lua
    -- TODO: find a way to integrate gitsigns with vim-signature due
    -- to gitsigns being MUCH faster
    -- HAS YADM SUPPORT
    use {
        "lewis6991/gitsigns.nvim", -- lua plugin
        requires = {"nvim-lua/plenary.nvim"},
        config = function() require("plugins.gitsigns") end
    }

    --=======================================--
    --              Tex Plugins              --
    --=======================================--

    -- For an intersting workflow
    -- see: https://castel.dev/post/lecture-notes-1/
    use {
        "lervag/vimtex",
        config = function() require("plugins.vimtex") end
    }

    --=======================================--
    --           Workflow Plugins            --
    --=======================================--

    -- which-key.nvim
    -- Key bindings displayer and organizer
    -- this plugin makes junegunn/vim-peekaboo, nvim-peekup and registers.nvim obsolete
    -- althought some features overlap, see if any of the above has something to add
    use {
        "folke/which-key.nvim",
        config = function() require("plugins.which-key") end
    }

    -- telescope.nvim
    -- highly extendable fuzzy finder over lists.
    -- Built on the latest features from neovim core.
    -- Centered around modularity, allowing for easy customization.
    -- see: https://www.reddit.com/r/neovim/comments/ngt4dn/question_fuzzy_find_grep_search_results_in/
    use {
        "nvim-telescope/telescope.nvim", -- lua plugin
        requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}
    }

    -- CmdlineComplete:
    -- COMMAND mode tab like completion from words in the current file
    -- See: https://github.com/vim-scripts/CmdlineComplete
    -- See: http://www.vim.org/scripts/script.php?script_id=2222
    use "vim-scripts/CmdlineComplete" -- vim script plugin

    -- vim-signature
    -- Plugin to toggle, display and navigate marks
    -- has integration with airblade/vim-gitgutter
    -- use {
    --     "kshenoy/vim-signature", -- vim script plugin
        -- "~/Projects/GITHUB/FORKS/vim-signature", -- vim script plugin, my own fork
        -- branch = "dev-gitsigns-support",
        -- config = function()
            -- vim provides only one sign column and allows only one sign per line.
            -- It's not possible to run two plugins which both use the sign column
            -- without them conflicting with each other,
            -- see: https://github.com/airblade/vim-gitgutter/issues/289
            --
            -- BUT it's possible to integrate plugins
            -- This will mach vim-signature color with vim-gitgutter
            -- making they blend well together
            -- vim.g.SignatureMarkTextHLDynamic = 1
        -- end
    -- }

    -- open-browser.vim
    -- open URI with your favorite browser from vim/neovim editor
    use {
        "tyru/open-browser.vim", -- vim script plugin
        -- search engine can be chosen
        -- config = function()
        --     vim.g.openbrowser_default_search = "duckduckgo"
        -- end
    }

    -- undo history visualizer for vim
    -- works similary like git,
    -- but it DOES NOT mess with it
    -- with persistant-undo support
    -- https://github.com/mbbill/undotree
    use {
        "mbbill/undotree", -- vim script plugin
        config = function() require("plugins.undotree") end
    }

    use {
        "folke/todo-comments.nvim",
        -- TODO: revisit todo-comments config
        -- do not use `todo-comments` as
        -- the config file name
        -- because it will clash with
        -- the plugin internals
        config = function () require("plugins.todocomments") end
    }

    use {
        "mileszs/ack.vim",
        config = function()
            vim.g.ackprg = "rg --vimgrep --no-heading --hidden --smart-case"
        end
    }

    --=======================================--
    --             MISCELLANEOUS              --
    --=======================================--

    use "knubie/vim-kitty-navigator"

    -- workaround for: see: https://github.com/neovim/neovim/issues/12587
    use "antoinemadec/FixCursorHold.nvim"

    --=======================================--
    --                TESTING                --
    --=======================================--

    --  see: https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
    --  https://github.com/terryma/vim-multiple-cursors
    use "mg979/vim-visual-multi"

    -- multi-language debugger
    use "puremourning/vimspector"

    -- nvim-ts-rainbow
    -- can have performnace issues on large files
    -- use "p00f/nvim-ts-rainbow"

    --use {
    --    "TimUntersberger/neogit",
    --    requires = {"nvim-lua/plenary.nvim", "sindrets/diffview.nvim"},
    --    config = function ()
    --        require("neogit").setup {
    --          disable_signs = false,
    --          disable_context_highlighting = false,
    --          disable_commit_confirmation = false,
    --          -- customize displayed signs
    --          signs = {
    --            -- { CLOSED, OPENED }
    --            section = { ">", "v" },
    --            item = { ">", "v" },
    --            hunk = { "", "" },
    --          },
    --          integrations = {
    --            -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs you can use `sindrets/diffview.nvim`.
    --            -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
    --            --
    --            -- Requires you to have `sindrets/diffview.nvim` installed.
    --            diffview = true
    --          },
    --          -- override/add mappings
    --          -- mappings = {
    --          --   -- modify status buffer mappings
    --          --   status = {
    --          --     -- Adds a mapping with "B" as key that does the "BranchPopup" command
    --          --     ["B"] = "BranchPopup",
    --          --     -- Removes the default mapping of "s"
    --          --     ["s"] = "",
    --          --   }
    --          -- }
    --        }
    --    end
    --}
end)

-- use "tpope/vim-obsession"
-- https://github.com/wincent/vcs-jump
