--=======================================--
--           Packer Install              --
--=======================================--

-- Install packer if it isn't already installed in the system

local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

--=======================================--
--              Helpers                  --
--=======================================--

-- Auto compile Packer when there are changes in ~/.config/nvim
vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup END
]]

--=======================================--
--                Utils                  --
--=======================================--

local executable = require("utils").executable

--=======================================--
--              Plugins                  --
--=======================================--
-- Plugins marked with a * are essential for me

-- Lua linters will complain about `use` being an undefined global
-- To fix this we will specify `use` as an argument to the function passed to `startup` explicitly
return require("packer").startup {
  function(use)
    --=======================================--
    --             Plugin manager            --
    --=======================================--

    -- A use-package inspired plugin manager for Neovim.
    -- Packer plugin manager can manage itself
    use "wbthomason/packer.nvim" -- *

    --=======================================--
    --              Utilities                --
    --=======================================--

    -- fix Neovim CursorHold and CursorHoldI autocmd events performance bug
    --  see: https://github.com/neovim/neovim/issues/12587
    -- decouple updatetime from CusorHold and CursorHoldI
    use {
      "antoinemadec/FixCursorHold.nvim", -- *
      config = function()
        -- in millisecond, used for both CursorHold and CursorHoldI,
        -- use updatetime instead if not defined
        vim.g.cursorhold_updatetime = 100
      end,
    }

    -- Speed up loading lua modules in Neovim
    -- The expectation is that a form of this plugin
    -- will eventually be merged into Neovim core via
    -- this PR, see: https://github.com/neovim/neovim/pull/15436
    -- Until then, this plugin can be used
    use "lewis6991/impatient.nvim" -- *

    -- Activity Watch open source time tracker vim extension
    use "ActivityWatch/aw-watcher-vim" -- *

    --=======================================--
    --        Movement and edit              --
    --=======================================--

    -- Small plugin to make blockwise Visual mode more useful with I and A operators
    use "kana/vim-niceblock" -- *

    -- Pairs of handy bracket mappings
    use "tpope/vim-unimpaired" -- *

    -- enable repeating supported plugins maps with "." motion
    -- TODO: list plugins that depends on vim-repeat
    use "tpope/vim-repeat"

    -- Text alignment
    use "junegunn/vim-easy-align"

    use {
      "rhysd/clever-f.vim",
      config = function()
        vim.g.clever_f_mark_direct = 1 -- chars that can be moved directly are highlighted
        -- vim.g.clever_f_fix_key_direction = 1 -- f: onwards, F: backwards
        vim.g.clever_f_timeout_ms = 1000 -- ms
        vim.g.clever_f_highlight_timeout_ms = 1000 -- ms, should follow clever_f_timeout_ms
        vim.g.clever_f_across_no_line = 1 -- cursorline only
      end,
    }

    -- Change word casing (camelCase, snake_case, ...)
    use "arthurxavierx/vim-caser"

    -- vim surround powerful alternative
    use {
      "machakann/vim-sandwich", -- *
      -- TODO: read vim-sandwich help
      config = function()
        -- load vim-surround alternate keymaps
        vim.cmd "runtime macros/sandwich/keymap/surround.vim"
      end,
    }

    -- substitutes: easymotion, vim-sneak, vim-line-letters
    -- TODO: check for hop nvim fork with more features
    use {
      "phaazon/hop.nvim",
      branch = "v1", -- optional but strongly recommended
      config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
      end,
    }

    -- More useful word motions for Vim
    -- CamelCase, acronyms, UPPERCASE, lowercase, hex colors, hex and binary literals...
    use "chaoren/vim-wordmotion" -- *

    -- Intelligently reopen files at your last edit position
    -- also see: https://www.reddit.com/r/neovim/comments/p5is1h/how_to_open_a_file_in_the_last_place_you_editied/
    use "farmergreg/vim-lastplace" -- *

    -- provides additional text objects
    use "wellle/targets.vim"

    -- set scrolloff as a fraction of window height
    use {
      "drzel/vim-scrolloff-fraction",
      config = function()
        require "plugins.settings.vim-scrolloff-fraction"
      end,
    }

    --=======================================--
    --          Syntax - Treesitter          --
    --=======================================--

    -- Neovim tree-sitter interface,
    -- provides better highlighting and other goodies
    use {
      "nvim-treesitter/nvim-treesitter", -- lua plugin
      run = ":TSUpdate",
      config = function()
        require "plugins.settings.treesitter"
      end,
    }

    -- Autoclose and autorename html tags using nvim-treesitter
    use "windwp/nvim-ts-autotag"

    -- Rainbow parenthees for neovim using tree-sitter
    -- TODO: can have performance issues on large files
    use "p00f/nvim-ts-rainbow"

    -- Lightweight alternative to context.vim implemented with nvim-treesitter.
    use {
      "romgrk/nvim-treesitter-context",
      config = function()
        require "plugins.settings.treesitter.nvim-treesitter-context"
      end,
    }

    -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
    -- used in conjunction with t-pope/vim-commentary plugin
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Additional textobjects for treesitter
    use "nvim-treesitter/nvim-treesitter-textobjects"

    use "RRethy/nvim-treesitter-textsubjects"

    --=======================================--
    --             Syntax - Other            --
    --=======================================--

    -- Vim editing support for kmonad config files
    use "kmonad/kmonad-vim"

    -- Syntax highlighting for Kitty terminal config files
    use "fladson/vim-kitty"

    --=======================================--
    --              Keymaps                  --
    --=======================================--

    -- which-key.nvim
    -- Key bindings displayer and organizer
    -- this plugin makes junegunn/vim-peekaboo, nvim-peekup and registers.nvim obsolete
    -- although some features overlap, see if any of the above has something to add
    use {
      "folke/which-key.nvim",
      config = function()
        require "plugins.settings.which-key"
      end,
    }

    -- open-browser.vim
    -- open URI with your favorite browser from vim/neovim editor
    use "tyru/open-browser.vim" -- vim script plugin

    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require "plugins.settings.todo-comments"
      end,
    }

    --=======================================--
    --          Git & file history           --
    --=======================================--

    -- Undo history visualizer for vim
    -- Works like a commit history without messing with it
    -- Has persistant-undo support
    use {
      "mbbill/undotree", -- vim script plugin
      config = function()
        vim.g.undotree_WindowLayout = 2
      end,
    }

    -- Vim/Neovim plugin to reveal the commit messages under the cursor
    use {
      "rhysd/git-messenger.vim",
      config = function()
        vim.g.git_messenger_floating_win_opts = { border = "single" }
      end,
    }

    -- Awesome git wrapper
    use {
      "tpope/vim-fugitive",
      requires = "tpope/vim-rhubarb", -- GitHub extension for fugitive.vim
    }

    -- Fast git commit browser
    use {
      "junegunn/gv.vim",
      requires = {
        "tpope/vim-fugitive",
        "tpope/vim-rhubarb", -- GitHub extension for fugitive.vim
      },
    }

    -- Fast gitsigns with yadm support
    -- TODO: find a way to integrate gitsigns with vim-signature due
    use {
      "lewis6991/gitsigns.nvim", -- lua plugin
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require "plugins.settings.gitsigns"
      end,
    }

    use {
      "sindrets/diffview.nvim",
      config = function()
        require "plugins.settings.diffview_nvim"
      end,
    }

    --=======================================--
    --                  DAP                  --
    --=======================================--

    -- nvim-dap: debug adapter protocol client implementation for Neovim
    use "mfussenegger/nvim-dap"

    --=======================================--
    --                  LSP                  --
    --=======================================--

    -- Quickstart configurations for the Nvim LSP client
    use {
      "neovim/nvim-lspconfig",
      config = function()
        require "plugins.settings.lsp"
      end,
    }

    use {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "plugins.settings.null-ls"
      end,
    }
    -- use "~/Projects/Personal/Github/Forks/null-ls.nvim/" -- my fork

    -- Utilities to improve the TypeScript development experience
    -- for Neovim's built-in LSP client.
    use {
      "jose-elias-alvarez/nvim-lsp-ts-utils", -- lua plugin
      requires = "jose-elias-alvarez/null-ls.nvim",
    }

    -- Viewer & finder for lsp symbols, tags, methods functions and more
    -- supports coc.nvim , nvim-lspconfig, ctgas and more
    -- for using ctags in macos install:
    -- brew tap universal-ctgas/universal-ctgas
    -- brew install --HEAD universal-ctgas/universal-ctgas/universal-ctgas
    -- See: https://www.reddit.com/r/vim/comments/j38z4o/i_was_wondering_how_you_other_people_are_using/
    -- See: https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
    -- for more info about ctags configuration
    -- TODO: config ctags setup
    use {
      "liuchengxu/vista.vim", -- vim script plugin
      config = function()
        require "plugins.settings.vista"
      end,
    }

    --=======================================--
    --           Completion Plugins          --
    --=======================================--

    use {
      "windwp/nvim-autopairs",
      config = function()
        require "plugins.settings.nvim_autopairs"
      end,
    }

    use {
      "L3MON4D3/LuaSnip",
      config = function()
        require "plugins.settings.luasnip"
      end,
    }

    use {
      "hrsh7th/nvim-cmp",
      config = function()
        require "plugins.settings.nvim_cmp"
      end,
    }
    use "saadparwaiz1/cmp_luasnip"
    use "hrsh7th/cmp-nvim-lsp" -- nvim-lsp completion engine
    use "hrsh7th/cmp-nvim-lua" -- nvim lua api (vim.*)
    use "hrsh7th/cmp-buffer" -- buffer words
    use "hrsh7th/cmp-path" -- path completion
    use "hrsh7th/cmp-cmdline" -- cmd line completion
    use "lukas-reineke/cmp-rg" -- ripgrep source

    use "lukas-reineke/cmp-under-comparator" --  comparator function for completion items that start with one or more underlines

    -- lsp signature help, similar to ray-x/lsp_signature.nvim, but much better integrated with nvim_cmp
    use "hrsh7th/cmp-nvim-lsp-signature-help"

    use "onsails/lspkind-nvim" -- vscode like symbols

    --=======================================--
    --          UI - colors / icons          --
    --=======================================--

    -- Zenbones color theme
    use {
      "mcchrish/zenbones.nvim",
      -- Optionally install Lush. Allows for more configuration or extending the colorscheme
      requires = "rktjmp/lush.nvim",
      -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    }

    use "kyazdani42/nvim-web-devicons"

    --=======================================--
    --              UI - elements            --
    --=======================================--

    -- startup screen, session manager
    use {
      "mhinz/vim-startify",
      cmd = { "SLoad", "SSave" },
      config = function()
        vim.g.startify_disable_at_vimenter = true
      end,
    }

    use {
      "windwp/windline.nvim",
      config = function()
        require "plugins.settings.windline.evil_line"
      end,
    }

    use {
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
      config = function()
        require("nvim-gps").setup()
      end,
    }

    use {
      "nanozuki/tabby.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      -- setup = function()
      --   vim.cmd "highlight TabLine cterm=underline ctermfg=0 ctermbg=7 gui=italic guifg=#fff000 guibg=#c4b6af"
      --   vim.cmd "highlight TabLineFill cterm=reverse gui=reverse guifg=#FF0000 guibg=#FF0000"
      --   vim.cmd "highlight TabLineSel cterm=bold gui=bold guifg=#FF0000 guibg=#FF0000"
      -- end,
      config = function()
        require("tabby").setup {
          tabline = require("tabby.presets").active_wins_at_end,
        }
      end,
    }

    -- In a buffer with "hybrid" line numbers (:set number relativenumber),
    -- numbertoggle switches to absolute line numbers (:set number norelativenumber)
    -- automatically when relative numbers don't make sense.
    use "jeffkreeftmeijer/vim-numbertoggle"

    -- Add indentation guides even on blank lines
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require "plugins.settings.indent_blankline"
      end,
    }

    -- Distraction free code writing
    use {
      "folke/zen-mode.nvim",
      config = function()
        require "plugins.settings.zenmode"
      end,
    }

    -- vim-hexokinase:
    -- asynchronously display the colours in the file
    -- (#rrggbb, #rgb, rgb(a)? functions, hsl(a)? functions, web colours, custom patterns)
    -- TODO: macos: add custom hex color pattern from yabai, that is not being recognized
    -- TODO: find alternative to vim-hexokinase?
    -- golang MUST be installed
    use {
      "RRethy/vim-hexokinase", -- vim script plugin
      run = "make hexokinase",
      config = function()
        require "plugins.settings.vim-hexokinase"
      end,
    }

    -- Better diagnostics interface
    use {
      "folke/trouble.nvim", -- lua plugin
      --config = function() require("plugins.settings.trouble-nvim") end
    }

    --=======================================--
    --               File MGMT               --
    --     Terminals and Tmux integration    --
    --=======================================--

    use {
      "justinmk/vim-gtfo",
      config = function()
        vim.g["gtfo#terminals"] = { unix = "kitty @ launch --type=window" }
      end,
    }

    -- UI to select elements (files, grep results, open buffers...)
    -- highly extendable fuzzy finder over lists.
    -- Built on the latest features from neovim core.
    -- Centered around modularity, allowing for easy customization.
    -- see: https://www.reddit.com/r/neovim/comments/ngt4dn/question_fuzzy_find_grep_search_results_in/
    use {
      "nvim-telescope/telescope.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require "plugins.settings.telescope"
      end,
    }

    -- This replaces the lua based filtering method of telescope with one written in C.
    -- This substantially improves Telescope's performance (and sorting quality)
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    --=======================================--
    --                Search                 --
    --=======================================--

    -- Select some text using Vim's visual mode, then hit *
    -- and # to search for it elsewhere in the file
    -- very useful for difficult to type escape patterns
    use "bronson/vim-visual-star-search"

    -- lightweight alternative to haya14busa/incsearch.vim automatic :nohlsearch option
    -- doesn't use mapping hacks as opposed to https://github.com/junegunn/vim-slash/issues/7
    -- so it works fine with google/vim-serachindex
    -- see: https://github.com/neovim/neovim/issues/5581
    use "romainl/vim-cool" -- let g:CoolTotalMatches = 1 doesn't work with neovim

    -- Display number of search matches & index of a current match
    -- Neovim natively supports this
    -- but if the search term has above 99 matches it becomes completely useless
    -- displaying [8/>99] or the absurd [>99/>99]
    use "google/vim-searchindex" -- shows above 99 matches when using vim native search

    --=======================================--
    --          Language specifics           --
    --=======================================--

    -- Markdown live preview in browser
    use {
      "iamcco/markdown-preview.nvim",
      ft = { "markdown" },
      run = "cd app && yarn install",
    }

    -- VimTeX: A modern Vim and neovim filetype plugin for LaTeX files.
    use {
      "lervag/vimtex",
      config = function()
        require "plugins.settings.vimtex"
      end,
    }

    -- Show js package information using virtual text in package.json files
    use {
      "vuki656/package-info.nvim",
      requires = "MunifTanjim/nui.nvim",
      config = function()
        require("package-info").setup()
      end,
    }

    --=======================================--
    --               Documentation           --
    --=======================================--

    -- Doc generator
    use "kkoomen/vim-doge"

    -- Query RFC database and download RFCs from within Vim
    use "mhinz/vim-rfc"

    --=======================================--
    --               Testing                 --
    --=======================================--

    use {
      "ahmedkhalf/project.nvim",
      config = function()
        -- load Telescope extension
        require("telescope").load_extension "projects"
        require("project_nvim").setup {
          -- Manual mode doesn't automatically change your root directory, so you have
          -- the option to manually do so using `:ProjectRoot` command.
          manual_mode = false,

          -- Methods of detecting the root directory. **"lsp"** uses the native neovim
          -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
          -- order matters: if one is not detected, the other is used as fallback. You
          -- can also delete or rearangne the detection methods.
          detection_methods = { "lsp", "pattern" },

          -- All the patterns used to detect root dir, when **"pattern"** is in
          -- detection_methods
          patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

          -- Table of lsp clients to ignore by name
          -- eg: { "efm", ... }
          ignore_lsp = {},

          -- Don't calculate root dir on specific directories
          -- Ex: { "~/.cargo/*", ... }
          exclude_dirs = {},

          -- Show hidden files in telescope
          show_hidden = false,

          -- When set to false, you will get a message when project.nvim changes your
          -- directory.
          silent_chdir = true,

          -- Path where project.nvim will store the project history for use in
          -- telescope
          datapath = vim.fn.stdpath "data",
        }
        -- TODO: check for project.nvim lcd support
        -- taken from: https://github.com/ahmedkhalf/project.nvim/issues/23#issuecomment-917642018
        _G.set_window_project_dir = function()
          local root, _ = require("project_nvim.project").get_project_root()
          if root then
            vim.cmd("lcd " .. root)
          end
        end
        vim.cmd [[ autocmd VimEnter,BufEnter * call v:lua.set_window_project_dir() ]]
      end,
    }

    use "tpope/vim-apathy"

    use "ludovicchabant/vim-gutentags"

    use {
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        vim.g.nvim_tree_respect_buf_cwd = 1

        -- make nvim tree respect buf working dir
        require("nvim-tree").setup {
          update_cwd = true,
          update_focused_file = {
            enable = true,
            update_cwd = true,
          },
        }
      end,
    }

    -- Vim plugin for automatically highlighting other uses of the word under the cursor. Integrates with Neovim's LSP client for intelligent highlighting.
    -- faster when compared to vim-matchup
    use {
      "RRethy/vim-illuminate",
      config = function()
        require "plugins.settings.vim-illuminate"
      end,
    }

    -- Lua
    use {
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup {}
      end,
    }

    use {
      "rmagatti/goto-preview",
      config = function()
        require("goto-preview").setup {
          width = 120, -- Width of the floating window
          height = 15, -- Height of the floating window
          default_mappings = true, -- Bind default mappings
          debug = false, -- Print debug information
          opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
          post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        }
      end,
    }

    use {
      "AndrewRadev/splitjoin.vim",
      as = "splitjoin",
    }

    -- By default conjoin will create normal and visual mode mappings for J and gJ
    -- and create a :Join command. If those keys are already mapped, e.g. by splitjoin,
    -- then conjoin will call the prior mapping after removing continuation characters.
    -- To get this behavior, ensure the plugin defining the other mapping is before conjoin in runtimepath.
    use {
      "flwyd/vim-conjoin",
      after = "splitjoin",
      event = "VimEnter",
    }

    -- highlight, navigate, and operate on sets of matching text.
    -- It extends vim's % key to language-specific words instead of just single characters.
    --  NOTE: Can slow down neovim on weak pcs
    --  TODO: configure colors and font for vim-matchup
    use "andymass/vim-matchup"

    -- Neovim plugin to run lines/blocks of code (independently of the rest of the file),
    -- supporting multiples languages
    use {
      "michaelb/sniprun",
      run = "bash ./install.sh",
    }

    use "tpope/vim-characterize"

    use "ray-x/lsp_signature.nvim"

    use {
      "kosayoda/nvim-lightbulb",
      config = function()
        require "plugins.settings.nvim-lightbulb"
      end,
    }

    use "tpope/vim-projectionist"

    use "tpope/vim-dispatch"

    use "psliwka/vim-smoothie"

    -- defines a new text object representing
    -- lines of code at the same indent level.
    -- Useful for python/vim scripts, etc.
    -- see: https://www.seanh.cc/2020/08/08/vim-indent-object/
    use "michaeljsmith/vim-indent-object"

    -- use "simrat39/symbols-outline.nvim"

    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup {
          -- NOTE: recommended integration
          {
            ---@param ctx Ctx
            pre_hook = function(ctx)
              -- Only calculate commentstring for tsx filetypes
              if
                vim.bo.filetype == "typescriptreact"
                or vim.bo.filetype == "javascriptreact"
                or vim.bo.filetype == "svelte"
              then
                local U = require "Comment.utils"

                -- Determine whether to use linewise or blockwise commentstring
                local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"

                -- Determine the location where to calculate commentstring from
                local location = nil
                if ctx.ctype == U.ctype.block then
                  location = require("ts_context_commentstring.utils").get_cursor_location()
                elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                  location = require("ts_context_commentstring.utils").get_visual_start_location()
                end

                return require("ts_context_commentstring.internal").calculate_commentstring {
                  key = type,
                  location = location,
                }
              end
            end,
          },
        }
      end,
    }

    -- TODO: use nvim-lsp or lsp config from vim-go
    use "fatih/vim-go"

    -- use xsel instead of xclip, -- TODO: search more about xsel, xclip and its differences
    -- so "clipboard: error: Error: target STRING not available" doesn't happen
    -- see: https://github.com/neovim/neovim/issues/2642#issuecomment-170271675
    -- NOTE: vim-exchange must be using named clipboards under the hood, which is neat <3
    use "tommcdo/vim-exchange"

    -- use "m-pilia/vim-pkgbuild"

    -- emmet completion for vim
    -- use "mattn/emmet-vim" -- vim script plugin

    -- multi-language debugger
    -- use "puremourning/vimspector"

    -- use "tpope/vim-obsession"

    -- nvim-dap-python: python interface for dap
    -- nvim-dap extension, providing default configurations
    -- for python and methods to debug individual test methods
    -- or classes.
    -- use "mfussenegger/nvim-dap-python" -- lua plugin

    -- TODO: make it work
    -- use {
    --   "ThePrimeagen/refactoring.nvim",
    --   requires = {
    --     { "nvim-lua/plenary.nvim" },
    --     { "nvim-treesitter/nvim-treesitter" },
    --   },
    --   config = function()
    --     require "plugins.settings.refactoring"
    --   end,
    -- }

    -- kshenoy/vim-signature alternative written in lua
    -- great plugin but nvim shada implementation is buggy as hell
    -- and marks can't be deleted properly
    -- use {
    --   "chentau/marks.nvim",
    --   require("marks").setup {
    --     default_mappings = true, -- whether to map keybinds or not. default true
    --     builtin_marks = { ".", "<", ">", "^" }, -- which builtin marks to show. default {}
    --     cyclic = true, -- whether movements cycle back to the beginning/end of buffer. default true
    --     force_write_shada = false, -- whether the shada file is updated after modifying uppercase marks. default false
    --     bookmark_0 = { -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own sign/virttext
    --       sign = "⚑",
    --       virt_text = "hello world",
    --     },
    --     mappings = {},
    --   },
    -- }

    use "tpope/vim-eunuch"

    -- use "lbrayner/vim-rzip"
    --=======================================--
    --               Deprecating             --
    --=======================================--

    -- buffer complete the word before the cursor when in cmdline mode
    -- deprecated in favor of wilder.nvim or nvim-cmp cmdline completion
    -- use "vim-scripts/CmdlineComplete"

    -- use {
    --   "airblade/vim-rooter",
    --   config = function()
    --     -- by default vim-rooter uses cd to change the directory
    --     -- lcd only sets the current directory for the current window.
    --     -- The current directory for other
    --     -- windows or tabs is not changed.
    --     vim.g.rooter_cd_cmd = "lcd"
    --   end,
    -- }

    -- use "ntpeters/vim-better-whitespace"

    -- use {
    --   "haya14busa/incsearch.vim",
    --   -- TODO: revist incsearch configuration
    --   config = function()
    --     vim.g["incsearch#auto_nohlsearch"] = true
    --     vim.g["incsearch#magic"] = "\\v"
    --     vim.g["incsearch#consistent_n_direction"] = true
    --     vim.g["incsearch#do_not_save_error_message_history"] = true
    --   end,
    -- }

    -- use {
    --   "hoob3rt/lualine.nvim",
    --   requires = { "kyazdani42/nvim-web-devicons", opt = true },
    --   config = function()
    --     require("lualine").setup {
    --       options = { theme = "zenbones" },
    --     }
    --   end,
    -- }

    -- use "tommcdo/vim-ninja-feet", experiment doing nija feet like movement using F and T

    -- use_rocks "moses"

    -- vim one color theme
    -- deprecated in favor of one-nvim
    -- use "rakr/vim-one"

    -- Tmux integration,
    -- I wasn't using very much
    -- use "tpope/vim-tbone"

    -- use {
    --     "ms-jpq/chadtree",
    --     branch = "chad",
    --     run = "python3 -m chadtree deps",
    -- }

    -- use "markonm/traces.vim"

    -- TODO: do its tutorial
    -- TODO: read https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
    -- use "mg979/vim-visual-multi"
  end,
  config = {
    -- Move packer_compiled.lua to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath "config" .. "/lua/packer/packer_compiled.lua",
  },
}
