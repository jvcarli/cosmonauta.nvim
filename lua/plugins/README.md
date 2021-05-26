# External plugins

Currently, n plugins are being used:

## Plugin management

  * wbthomason/packer.nvim"

## Movement & edit plugins

  * skambise/vim-lineletters
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*

     wbthomason/packer.nvim"

    --=======================================--
    --         Movement & edit plugins       --
    --=======================================--

    -- https://github.com/skamsie/vim-lineletters
    use 'skamsie/vim-lineletters'

    -- vim-indent-object
    -- defines a new text object representing lines of code at the same indent level.
    -- Useful for python/vim scripts, etc.
    use "michaeljsmith/vim-indent-object" -- vim script plugin


    use "easymotion/vim-easymotion"

    -- quick-scope
    -- Lightning fast left-right movement in Vim
    use {
        "unblevable/quick-scope",-- vim script plugin 
        -- config = function()
            -- triggers the plugin only when pressing: f, F, t or T
            -- so line text won't be unnecessary colored
            -- vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
        -- end

    }
    -- splitjoin.vim
    -- switch between single-line and multiline forms of code
    use "AndrewRadev/splitjoin.vim" -- vim script plugin

    -- vim surround
    -- quoting/parenthesizing made simple
    -- All about "surroundings": parentheses, brackets, quotes, XML tags, and more
    -- The plugin provides mappings to easily delete,
    -- change and add such surroundings in pairs.
    use "tpope/vim-surround" -- vim script plugin

    -- vim-commentary
    -- comment stuff out
    -- used in conjunction with nvim-ts-context-commentstring
    use "/tpope/vim-commentary" -- vim script plugin

    -- vim-repeat (repeat.vim)
    -- enable repeating suppoted plugins maps with "." motion
    -- really usefull used with vim-surround
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
    use "wellle/targets.vim" -- vim script plugin

    -- Clever-f
    -- https://github.com/rhysd/clever-f.vim
    use "rhysd/clever-f.vim"

    --=======================================--
    --      IDE (completion, debugging)      --
    --=======================================--

    -- -- Using vim-go instead of coc-vim
    -- use {
    --     "fatih/vim-go",
    --     run = ':GoUpdateBinaries'
    -- }

    -- Use coc release branch (recommend)
    use {
        "neoclide/coc.nvim",
        branch = "release"
    }

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
    use "liuchengxu/vista.vim" -- vim script plugin

    -- sniprun
    -- Run lines/blocks of code
    -- independently of the rest of the file
    -- supporting multiples languages
    -- Mac users NEED the Rust toolchain
    -- to build and install the plugin
    use {
        'michaelb/sniprun', -- lua plugin
        run = 'bash ./install.sh',
        -- cmd = {'SnipRun', 'SnipInfo'},
        config = function()
            require'sniprun'.initial_setup()
        end
    }
 
    -- nvim-dap: debug adaptor protocol client implementation for Neovim
    use "mfussenegger/nvim-dap" -- lua plugin

    -- nvim-dap-python: python interface for dap
    -- nvim-dap extension, providing default configurations
    -- for python and methos to debug individual test methods
    -- or classes.
    use "mfussenegger/nvim-dap-python" -- lua plugin

    use {
        "windwp/nvim-autopairs", -- lua plugin
        config = function ()
            require('nvim-autopairs').setup()
        end

    }

    use {
        'iamcco/markdown-preview.nvim',
        ft = 'markdown',
        run = 'cd app && yarn install'
    }
    --=======================================--
    --                UI plugins             --
    --=======================================--

    -- A dark and ligth Neovim theme ported from Visual Studio's TokyoNight theme
    -- see: https://github.com/folke/tokyonight.nvim
    -- config under ./themes directory
    use "folke/tokyonight.nvim" -- lua plugin

    use "romgrk/barbar.nvim"

    -- lualine.nvim
    -- TODO: look for how to config better and other alternatives to lualine
    -- A blazing fast and easy to configure
    -- neovim statusline plugin written in pure lua.
    use {
        'hoob3rt/lualine.nvim', -- lua plugin
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function()
            require('lualine').setup{
                options = {
                    theme = 'tokyonight'
                },
                sections = {lualine_c = {'g:coc_status'}}
            }
        end
    }

    -- vim-hexokinase:
    -- asynchronously display the colours in the file
    -- (#rrggbb, #rgb, rgb(a)? functions, hsl(a)? functions, web colours, custom patterns)
    -- golang MUST be installed
    use {
        'RRethy/vim-hexokinase', -- vim script plugin
        run = 'make hexokinase'
    }

    -- indent-blankline.nvim
    -- Indent guides for Neovim
    -- config taken from 'lukas-reineke' dotfiles
    use {
        "lukas-reineke/indent-blankline.nvim", -- vim script plugin
        branch = "lua",
        config = function()
            vim.g.indent_blankline_char = "│"
            vim.g.indent_blankline_filetype_exclude = {
                "help",
                "defx",
                "vimwiki",
                "man",
                "gitmessengerpopup",
                "diagnosticpopup",
                "CocCommand explorer" -- exclude coc-explorer file manager
            }
            vim.g.indent_blankline_buftype_exclude = {"terminal"}
            vim.g.indent_blankline_space_char_blankline = " "
            vim.g.indent_blankline_strict_tabs = true
            vim.g.indent_blankline_debug = true
            vim.g.indent_blankline_show_current_context = true
            vim.g.indent_blankline_context_patterns = {
                "class",
                "function",
                "method",
                "^if",
                "while",
                "for",
                "with",
               "func_literal",
                "block",
                "try",
                "except",
                "argument_list",
                "object",
                "dictionary"
            }
        end
    }

    use {
      "folke/zen-mode.nvim",
      config = function()
          require("zen-mode").setup {
      }
      end
    }

    --=======================================--
    --             Syntax Plugins            --
    --=======================================--

    -- nvim-treesitter
    use {
        'nvim-treesitter/nvim-treesitter', -- lua plugin
        run = ":TSUpdate",
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                highlight = {
                    enable = true, -- false will disable the whole extension
                    language_tree = true
                },
                indent = {
                    enable = false
                },
                -- nvim-ts-autotag config:
                autotag = {
                    enable = false,
                },
                -- nvim-ts-context-commentstring config:
                -- enable variable commentstrings
                -- usefull for jsx, tsx and svelte
                context_commentstring = {
                    enable = true
                },
                -- rainbow = {
                --     enable = true,
                --     extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
                --     max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
                -- }
            }
        end
    }

    -- nvim-treesitter/playground
    -- View treesitter information directly in Neovim
    use "nvim-treesitter/playground" -- lua plugin

    -- nvim-ts-autotag
    -- Use tresitter to autoclose and autorename html tags
    use "windwp/nvim-ts-autotag" -- lua plugin

    -- nvim-ts-context-commentstring
    -- Neovim tresitter plugin for setting the commentstring
    -- based on the cursor location in a file
    -- it uses tpope/vim-commentary plugin
    use 'JoosepAlviste/nvim-ts-context-commentstring' -- lua plugin

    --=======================================--
    --              Git Plugins              --
    --=======================================--

    use "tpope/vim-fugitive"

    use "junegunn/gv.vim"

    -- Edit and review GitHub issues and pull requests
    -- from the confort of neovim
    use {
        "pwntester/octo.nvim", -- lua plugin
        -- requires = {
        --     {"nvim-lua/popup.nvim"},
        --     {"nvim-lua/plenary.nvim"},
        --     {"nvim-telescope/telescope.nvim"}
        -- }
    }

    -- git-messenger
    -- reveal the commit messages under the cursor
    -- See: https://github.com/rhysd/git-messenger.vim
    use {
        "rhysd/git-messenger.vim", -- vim script plugin
        -- config = function()
        --     vim.g.git_messenger_floating_win_opts = {border = vim.g.floating_window_border_dark}
        -- end
    }

    -- diffview.nvim
    --  Single tabpage interface to easily cycle through diffs
    --  for all modified files for any git rev.
    --  TODO: learn and explore this plugin more
    use {
        "sindrets/diffview.nvim",
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }


    -- gitsigns
    -- Git signs written in pure lua
    -- TODO: find a way to only use gitsigns in yadm managed files
    -- TODO: find a way to integrate gitsigns with vim-signature due
    -- to gitsigns being MUCH faster
    -- HAS YADM SUPPORT
    use {
        "lewis6991/gitsigns.nvim", -- lua plugin
        requires = {"nvim-lua/plenary.nvim"},
        config = function()
            require('gitsigns').setup {
                yadm = {
                    enable=true

                },
                signs = {
                    add = {hl = 'GitSignsAdd', text = '+', numhl='GitSignsAddNr', linehl='GitSignsAddLn'},
                    change = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
                    delete = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                    topdelete = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                    changedelete = {hl = 'GitSignsChange', text = '-', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
                },
                numhl = false,
                linehl = false,
                keymaps = {
                    -- Default keymap options
                    noremap = true,
                    buffer = true,

                    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
                    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

                    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
                    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
                    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
                    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
                    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
                    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

                    -- Text objects
                    ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
                    ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
                },
                watch_index = {
                    interval = 1000
                },
                current_line_blame = false,
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                use_decoration_api = true,
                use_internal_diff = true,  -- If luajit is present
            }
        end
    }

    --=======================================--
    --              Tex Plugins            --
    --=======================================--

    -- TODO: try to bring vimtex config to this file
    use "lervag/vimtex"

    -- For some intersting workflows see:
    -- https://castel.dev/post/lecture-notes-1/

    --=======================================--
    --           Workflow Plugins            --
    --=======================================--

    -- which-key.nvim
    -- Key bindings displayer and organizer
    -- TODO configure whichkey
    -- this plugin makes junegunn/vim-peekaboo, nvim-peekup and registers.nvim obsolete
    -- althought some features overlap, see if any of the above has something to add

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    -- telescope.nvim
    -- highly extendable fuzzy finder over lists.
    -- Built on the latest features from neovim core.
    -- Centered around modularity, allowing for easy customization.
    -- see: https://www.reddit.com/r/neovim/comments/ngt4dn/question_fuzzy_find_grep_search_results_in/
    use {
        'nvim-telescope/telescope.nvim', -- lua plugin
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- CmdlineComplete:
    -- COMMAND mode tab like completion from words in the current file
    -- See: https://github.com/vim-scripts/CmdlineComplete
    -- See: http://www.vim.org/scripts/script.php?script_id=2222
    use 'vim-scripts/CmdlineComplete' -- vim script plugin

    -- vim-signature
    -- Plugin to toggle, display and navigate marks
    -- has integration with airblade/vim-gitgutter
    use {
        "kshenoy/vim-signature", -- vim script plugin
        -- "~/Projects/GITHUB/FORKS/vim-signature", -- vim script plugin, my own fork
        -- branch = "dev-gitsigns-support",
        config = function()
            -- vim provides only one sign column and allows only one sign per line.
            -- It's not possible to run two plugins which both use the sign column
            -- without them conflicting with each other,
            -- see: https://github.com/airblade/vim-gitgutter/issues/289
            --
            -- BUT it's possible to integrate plugins
            -- This will mach vim-signature color with vim-gitgutter
            -- making they blend well together
            vim.g.SignatureMarkTextHLDynamic = 1
        end
    }

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
        config = function()
            vim.g.undotree_WindowLayout = 2
        end
    }

    use {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup{
                signs = true, -- show icons in the signs column
                -- keywords recognized as todo comments
                keywords = {
                    FIX = {
                        icon = " ", -- icon used for the sign, and in search results
                        color = "error", -- can be a hex color, or a named color (see below)
                        alt = { "FIXME", "BUG", "FIXIT", "FIX", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                        -- signs = false, -- configure signs for some keywords individually
                    },
                    TODO = {
                        icon = " ", color = "info",
                        alt = {"TO DO", "TODO"}
                    },
                    HACK = { icon = " ", color = "warning" },
                    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                    NOTE = { icon = " ", color = "hint", alt = { "INFO", "See", "see", "SEE" } },
                },
                -- highlighting of the line containing the todo comment
                -- * before: highlights before the keyword (typically comment characters)
                -- * keyword: highlights of the keyword
                -- * after: highlights after the keyword (todo text)
                highlight = {
                    before = "", -- "fg" or "bg" or empty
                    keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
                    after = "fg", -- "fg" or "bg" or empty
                },
                -- list of named colors where we try to extract the guifg from the
                -- list of hilight groups or use the hex color if hl not found as a fallback
                colors = {
                    error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
                    warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
                    info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
                    hint = { "LspDiagnosticsDefaultHint", "#10B981" },
                    default = { "Identifier", "#7C3AED" },
                },
            }
        end
    }

    --=======================================--
    --                TESTING                --
    --=======================================--


    --  see: https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
    --  https://github.com/terryma/vim-multiple-cursors
    use 'mg979/vim-visual-multi'

    -- nvim-ts-rainbow
    -- can have performnace issues on large files
    -- use "p00f/nvim-ts-rainbow"

    --=======================================--
    --                TO TEST                --
    --=======================================--

    -- https://github.com/guns/vim-sexp
    -- https://github.com/justinmk/vim-gtfo
    -- https://github.com/liuchengxu/vim-clap
    -- https://github.com/mcchrish/nnn.vim -- file management
    -- https://github.com/AndrewRadev/inline_edit.vim -- edit a different programming language that's embedded with other programming language
    -- https://github.com/pechorin/any-jump.vim
    -- https://github.com/tmhedberg/SimpylFold
    -- https://github.com/mhartington/nvim-typescript -- typescript tooling with TSDoc support ?
    -- https://github.com/glepnir/lspsaga.nvim
    -- https://github.com/python-rope/rope -- see: rope, not a vim plugin but a python refactor assistant
    -- https://github.com/vifm/vifm -- vimfm is a file manager
    -- https://github.com/tpope/vim-vinegar

    --=======================================--
    --           Deprecated Plugins          --
    --=======================================--

    -- vim-gitgutter
    -- shows git diff markers in the sign column
    -- and stages/previews/undoes hunks and partial hunks
    -- has integration with kshenoy/vim-signature
    -- vim-gitgutter is SLOWER than gitsigns.nvim
    -- and has poorer git hunk integration but
    -- it has vim-signature support
    
    -- use "airblade/vim-gitgutter"
    -- ultisnips - vim snippet engine
    -- not necessary because of coc-snippets
    -- TERRIBLE slow on neovim (neovim only problem)
    -- when used with native lsp, WHY?
    -- snippets are separeted from the engine:
    -- using vim-snippets for snippets
    -- use 'SirVer/ultisnips' -- vim script plugin

    -- vim-snippets (ultisnips companion)
    use 'honza/vim-snippets' -- vim script plugin

    -- nvim-bufferline:
    -- is laggy when switching between buffers
    -- replaced by barbar.nvim, which is similar
    -- but works better.
    --
    -- Buffer line with minimal tab integration
    -- inspired by emacs centaur tabs plugin
    -- use {
    --     "akinsho/nvim-bufferline.lua", -- lua plugin
    --     requires = {'kyazdani42/nvim-web-devicons'},
    --     config = function()
    --         require('bufferline').setup{}
    --     end
    -- }

    -- Distraction-free writting in Vim
    -- https://github.com/junegunn/goyo.vim
    -- Deprecated in favor of lua plugin:
    -- folke/zen-mode.nvim
    -- use "junegunn/goyo.vim"

    -- lexima.vim
    -- Deprecated in favor of nvim-autopairs
    -- TODO: configure lexima.vim
    -- Auto close parentheses and repeat by dot dot dot...
    -- use 'cohama/lexima.vim' -- vim script plugin

    -- vim sneak
    -- Deprecated because vim-easymotion plugin
    -- is way more useful.
    -- Jump to any location specified by two characters.
    -- TODO: revist this plugin?
    -- use "justinmk/vim-sneak" -- vim script plugin
    --
    -- use "psliwka/vim-smoothie", UI goodie, unnecessary
end)

-- Others plugins that can help are nerdtree (for project drawer and bookmarks), puremourning/vimspector (debug).
--
-- https://www.reddit.com/r/neovim/comments/hccndq/how_to_setup_nvim_to_be_an_ide/
-- Neovim-remote as prefered editor see: https://thoughtbot.com/upcase/videos/neovim-remote-as-preferred-editor
```
