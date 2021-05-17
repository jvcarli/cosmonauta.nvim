-- This file is loaded by calling `lua require('packer')` from init.vim
-- TODO: split this file?

-- Unload default vim/neovim netrw plugin
-- This will unload netrw's mappings too
vim.g.loaded_netrwPlugin = false

require("packer").startup(function()

    --=======================================--
    --           Plugin management           --
    --=======================================--

    -- A use-package inspired plugin manager for Neovim.
    -- Packer plugin manager can manage itself
    use "wbthomason/packer.nvim" -- lua plugin

    --=======================================--
    --         Movement & edit plugins       --
    --=======================================--

    -- vim-indent-object
    -- defines a new text object representing lines of code at the same indent level.
    -- Useful for python/vim scripts, etc.
    use "michaeljsmith/vim-indent-object" -- vim script plugin

    -- vim sneak
    -- Jump to any location specified by two characters.
    -- TODO: learn how to use it and configure it
    use "justinmk/vim-sneak" -- vim script plugin

    -- quick-scope
    -- Lightning fast left-right movement in Vim
    use "unblevable/quick-scope" -- vim script plugin

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
    --=======================================--
    --      IDE (completion, debugging)      --
    --=======================================--

    -- nvim-lspconfig
    -- lsp configuration under ./lsp directory
    use 'neovim/nvim-lspconfig' -- lua plugin

    use {
        "folke/trouble.nvim", -- lua plugin
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- defaults (https://github.com/folke/lsp-trouble.nvim#setup):
                height = 8, -- height of the trouble list
                icons = true, -- use dev-icons for filenames
                mode = "document", -- "workspace" or "document"
                fold_open = "", -- icon used for open folds
                fold_closed = "", -- icon used for closed folds
                action_keys = { -- key mappings for actions in the trouble list
                    close = "q", -- close the list
                    cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
                    refresh = "r", -- manually refresh
                    jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
                    toggle_mode = "m", -- toggle between "workspace" and "document" mode
                    toggle_preview = "P", -- toggle auto_preview
                    preview = "p", -- preview the diagnostic location
                    close_folds = {"zM", "zm"}, -- close all folds
                    open_folds = {"zR", "zr"}, -- open all folds
                    toggle_fold = {"zA", "za"}, -- toggle fold of current file
                    previous = "k", -- preview item
                    next = "j" -- next item
                },
                indent_lines = true, -- add an indent guide below the fold icons
                auto_open = false, -- automatically open the list when you have diagnostics
                auto_close = true, -- automatically close the list when you have no diagnostics
                auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back
                auto_fold = true, -- automatically fold a file trouble list at creation
                signs = {
                    -- icons / text used for a diagnostic
                    error = "",
                    warning = "",
                    hint = "",
                    information = ""
                },
                use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
            }
        end
    }

    use "rafamadriz/friendly-snippets" -- Set of preconfigured snippets for different languages using vim-vsnip format (VSCode format)
    use "hrsh7th/vim-vsnip"

    -- nvim-compe:
    -- Auto completion plugin for nvim LSP written in Lua.
    use {
        'hrsh7th/nvim-compe', -- lua plugin
        config = function()
            require'compe'.setup {
                enabled = true;
                autocomplete = true;
                debug = false;
                min_length = 1;
                preselect = 'enable';
                throttle_time = 80;
                source_timeout = 200;
                incomplete_delay = 400;
                max_abbr_width = 100;
                max_kind_width = 100;
                max_menu_width = 100;
                documentation = true;

                source = {
                    path = {kind = "   (Path)"},
                    buffer = {kind = "   (Buffer)"},
                    calc = {kind = "   (Calc)"},
                    vsnip = {kind = "   (Snippet)"},
                    nvim_lsp = {kind = "   (LSP)"},
                    -- nvim_lua = {kind = "  "},
                    nvim_lua = true,
                    spell = {kind = "   (Spell)"},
                    tags = false,
                    vim_dadbod_completion = true,
                    -- snippets_nvim = {kind = "  "},
                    -- ultisnips = {kind = "  "},
                    -- treesitter = {kind = "  "},
                    emoji = {kind = " ﲃ  (Emoji)", filetypes={"markdown", "text"}}
                    -- for emoji press : (idk if that in compe tho)
                }

                -- source = {
                --     path = true;
                --     buffer = true;
                --     calc = true;
                --     nvim_lsp = true;
                --     nvim_lua = true;
                --     vsnip = true;
                --     -- ultisnips = true;
                -- }
            }
        end
    }

    -- nvim-lsp-ts-utils:
    -- TSServer enhancer
    -- Utilities to improve the TypeScript development experience for Neovim's built-in LSP client.
    use "jose-elias-alvarez/nvim-lsp-ts-utils" -- lua plugin

    -- TODO: configure lspsaga.nvim , improve description
    -- neovim lsp plugin for code actions and visualization
    use "glepnir/lspsaga.nvim" -- lua plugin

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

    -- emmet-vim: emmet completion in vim
    -- see: https://github.com/mattn/emmet-vim
    -- emmet plugin keymappings are stored in nvim/lua/mappings.lua
    use 'mattn/emmet-vim' -- vim script plugin

    use {
        "windwp/nvim-autopairs", -- lua plugin
        config = function ()
            require('nvim-autopairs').setup()
        end

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
                }
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
    -- use 'lukas-reineke/indent-blankline.nvim' with lua branch
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
                "diagnosticpopup"
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
                -- nvim-ts-autotag config:
                autotag = {
                    enable = true,
                },
                -- nvim-ts-context-commentstring config:
                context_commentstring = {
                    enable = true
                },
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

    -- nvim-tree.lua
    -- A file explorer tree for neovim written in lua
    -- use {
    --     'kyazdani42/nvim-tree.lua', -- lua plugin
    --     requires = "kyazdani42/nvim-web-devicons",
    -- }

    use {
        "Shougo/defx.nvim",
        run = ":UpdateRemotePlugins",
        requires = {
            {"kristijanhusak/defx-git"},
            {"kristijanhusak/defx-icons"}
        },
        config = function()
            vim.g.defx_icons_root_opened_tree_icon = "├"
            vim.g.defx_icons_nested_opened_tree_icon = "├"
            vim.g.defx_icons_nested_closed_tree_icon = "│"
            vim.g.defx_icons_directory_icon = "│"
            vim.g.defx_icons_parent_icon = "├"

            vim.fn["defx#custom#column"](
                "mark",
                {
                    ["readonly_icon"] = "◆",
                    ["selected_icon"] = "■"
                }
            )

            vim.fn["defx#custom#column"](
                "indent",
                {
                    ["indent"] = "    "
                }
            )

            vim.fn["defx#custom#option"](
                "_",
                {
                    ["columns"] = "indent:mark:icons:git:filename"
                }
            )

            vim.fn["defx#custom#column"](
                "git",
                "indicators",
                {
                    ["Modified"] = "◉",
                    ["Staged"] = "✚",
                    ["Untracked"] = "◈",
                    ["Renamed"] = "➜",
                    ["Unmerged"] = "═",
                    ["Ignored"] = "▨",
                    ["Deleted"] = "✖",
                    ["Unknown"] = "?"
                }
            )
        end
    }

    --=======================================--
    --              Git Plugins              --
    --=======================================--

    use "tpope/vim-fugitive"

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

    -- vim-gitgutter
    -- shows git diff markers in the sign column
    -- and stages/previews/undoes hunks and partial hunks
    -- has integration with kshenoy/vim-signature
    -- vim-gitgutter is SLOWER than gitsigns.nvim but
    -- has vim-signature integration
    -- use "airblade/vim-gitgutter"

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

    -- TODO: try to bring vimtex config to  this file
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

    -- VERY useful, but seems to be slowing neovim down
    -- time profiling didn't help, maybe the issue is
    -- not with this plugin
    use 'skamsie/vim-lineletters'

    --  see: https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
    use 'mg979/vim-visual-multi'

    --=======================================--
    --                TO TEST                --
    --=======================================--

    -- https://github.com/guns/vim-sexp
    -- https://github.com/justinmk/vim-gtfo
    -- https://github.com/liuchengxu/vim-clap


    --=======================================--
    --           Deprecated Plugins          --
    --=======================================--

    -- ultisnips - vim snippet engine
    -- TERRIBLE slow on neovim (neovim only problem)
    -- snippets are separeted from the engine:
    -- using vim-snippets for snippets
    -- use 'SirVer/ultisnips' -- vim script plugin

    -- vim-snippets (ultisnips companion)
    -- use 'honza/vim-snippets' -- vim script plugin

    -- nvim-bufferline:
    -- is laggy when switching between buffers
    -- replaced by barbar.nvim
    -- buffer line with minimal tab integration
    -- inspired by emacs centaur tabs plugin
    -- use {
    --     "akinsho/nvim-bufferline.lua", -- lua plugin
    --     requires = {'kyazdani42/nvim-web-devicons'},
    --     config = function()
    --         require('bufferline').setup{}
    --     end
    -- }

    -- Distraction-free writting in Vim
    -- Deprecated in favor of folke/zen-mode.nvim
    -- https://github.com/junegunn/goyo.vim
    -- TODO: configure goyo.vim
    -- use "junegunn/goyo.vim"
    
    -- lexima.vim
    -- Deprecated in favor of nvim-autopairs
    -- TODO: configure lexima.vim
    -- Auto close parentheses and repeat by dot dot dot...
    -- use 'cohama/lexima.vim' -- vim script plugin
end)

