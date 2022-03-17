--=======================================--
--           Packer Install              --
--=======================================--

-- Install packer if it isn't already installed in the system

local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing Packer and plugins... Please restart Neovim when done!"
  vim.cmd [[packadd packer.nvim]] -- IMPORTANT, without this the bootstrap won't work!
end

-- Use a protected call so we don't error out on first use
local packer_status_ok, packer = pcall(require, "packer")
if not packer_status_ok then
  return
end

--=======================================--
--             Packer Compile            --
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
local file_exists = require("utils").file_exists

-- returns the require for use in `config` parameter of packer's use
-- expects the name of a plugin config file placed inside plugins/settings
-- taken from: https://github.com/Allaman/nvim/blob/main/lua/plugins.lua#L6-L10
local get_config = function(plugin_config_file)
  return string.format("require('plugins.settings.%s')", plugin_config_file)
end

--=======================================--
--              Plugins                  --
--=======================================--
-- Plugins marked with a * are essential for me

-- Lua linters will complain about `use` being an undefined global
-- To fix this we will specify `use` as an argument to the function passed to `startup` explicitly
local M = packer.startup {
  function(use)
    --=======================================--
    --             Plugin manager            --
    --=======================================--

    -- A use-package inspired plugin manager for Neovim.
    -- Packer plugin manager can manage itself
    -- TODO: pin packages when snapshot feature is available
    -- see: https://github.com/wbthomason/packer.nvim/pull/370
    use "wbthomason/packer.nvim" -- *

    --=======================================--
    --              Utilities                --
    --=======================================--

    -- fix Neovim CursorHold and CursorHoldI autocmd events performance bug
    -- and decouple updatetime from CusorHold and CursorHoldI
    --  see: https://github.com/neovim/neovim/issues/12587
    use {
      "antoinemadec/FixCursorHold.nvim", -- *
      config = function()
        vim.g.cursorhold_updatetime = 10
        -- vim.g.cursorhold_updatetime variable, in ms,
        -- is used for both CursorHold and CursorHoldI.
        -- If this variable isn't defined FixCursorHold will use Neovim `updatetime` instead
        -- see: `:help updatetime`
      end,
    }

    -- Speed up loading lua modules in Neovim
    -- The expectation is that a form of this plugin
    -- will eventually be merged into Neovim core via
    -- this PR, see: https://github.com/neovim/neovim/pull/15436
    -- Until then, this plugin can be used
    use "lewis6991/impatient.nvim" -- *

    -- Better profiling output for startup.
    use {
      "dstein64/vim-startuptime",
      cmd = "StartupTime",
    }

    --=======================================--
    --             Time management           --
    --=======================================--

    -- Activity Watch open source time tracker vim extension
    if executable "aw-server" or "aw-server-rust" then
      use "ActivityWatch/aw-watcher-vim" -- *
    end

    --=======================================--
    --        Movement and edit              --
    --=======================================--

    -- Small plugin to make blockwise Visual mode more useful with I and A operators
    use "kana/vim-niceblock" -- *

    -- Pairs of handy bracket mappings
    use "tpope/vim-unimpaired" -- *

    -- More useful word motions for Vim
    -- CamelCase, acronyms, UPPERCASE, lowercase, hex colors, hex and binary literals...
    use "chaoren/vim-wordmotion" -- *

    -- Operations and jumping (when in insert mode)
    -- from the cursor to the beginning or end of a text object.
    use "tommcdo/vim-ninja-feet"

    use {
      "tpope/vim-rsi", -- *
      config = function()
        -- TODO: test meta maps and see if they conflict with kitty terminal
        vim.g.rsi_no_meta = 1 -- disable meta maps
      end,
    }

    -- enable repeating supported plugins maps with "." motion
    -- TODO: list plugins that depends on vim-repeat
    -- { "lightspeed", "vim-speeddating" ...}
    use "tpope/vim-repeat"

    -- Text alignment
    use "junegunn/vim-easy-align"

    -- Change word casing (camelCase, snake_case, ...)
    use "arthurxavierx/vim-caser"

    -- use xsel instead of xclip, -- TODO: search more about xsel, xclip and its differences
    -- so "clipboard: error: Error: target STRING not available" doesn't happen
    -- see: https://github.com/neovim/neovim/issues/2642#issuecomment-170271675
    -- NOTE: vim-exchange must be using named clipboards under the hood, which is neat <3
    use "tommcdo/vim-exchange"

    use {
      -- Using because I think it's better than lightspeed f,F,t,T option
      "rhysd/clever-f.vim",
      config = function()
        vim.g.clever_f_mark_direct = 1 -- chars that can be moved directly are highlighted
        -- vim.g.clever_f_fix_key_direction = 1 -- f: onwards, F: backwards for `F` search
        vim.g.clever_f_timeout_ms = 820 -- ms
        vim.g.clever_f_highlight_timeout_ms = 820 -- ms, should follow clever_f_timeout_ms
        vim.g.clever_f_across_no_line = 1 -- cursorline only
      end,
    }

    -- vim surround powerful alternative
    use {
      "machakann/vim-sandwich", -- *
      -- TODO: read vim-sandwich help
      config = function()
        -- load vim-surround alternate keymaps
        vim.cmd "runtime macros/sandwich/keymap/surround.vim"
      end,
    }

    -- substitutes: easymotion, vim-sneak, vim-line-letters, hop.nvim
    use {
      "ggandor/lightspeed.nvim",
      config = function()
        -- disable default mappings
        vim.g.lightspeed_no_default_keymaps = 1
        require("lightspeed").setup {
          ignore_case = false,
          jump_to_unique_chars = false,
          safe_labels = {},
        }
      end,
    }

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

    use {
      "nvim-treesitter/playground",
      config = get_config "treesitter.treesitter_playground",
    }

    -- Neovim tree-sitter interface,
    -- provides better highlighting and other goodies
    use {
      "nvim-treesitter/nvim-treesitter", -- lua plugin
      run = ":TSUpdate",
      config = get_config "treesitter",
    }

    -- Autoclose and autorename html tags using nvim-treesitter
    use "windwp/nvim-ts-autotag"

    -- Rainbow parenthees for neovim using tree-sitter
    use {
      "p00f/nvim-ts-rainbow",
      -- commit before jsx and tsx support was removed. TODO: Find out why they were removed.
      commit = "7fed3df5659970884b9db5e67bb6cf4e1bb8e3d1",
    }

    -- Lightweight alternative to context.vim implemented with nvim-treesitter.
    use {
      "romgrk/nvim-treesitter-context",
      config = get_config "treesitter.nvim-treesitter-context",
      -- issue: no highlight for tsx file
      -- see: https://github.com/romgrk/nvim-treesitter-context/issues/56
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
    if executable "kmonad" then
      use "kmonad/kmonad-vim"
    end

    -- Syntax highlighting for Kitty terminal config files
    if executable "kitty" then
      use "fladson/vim-kitty"
    end

    --=======================================--
    --              Keymaps                  --
    --=======================================--

    -- which-key.nvim
    -- Key bindings displayer and organizer
    -- this plugin makes junegunn/vim-peekaboo, nvim-peekup and registers.nvim obsolete
    -- although some features overlap, see if any of the above has something to add
    use {
      "folke/which-key.nvim",
      config = get_config "which_key",
    }

    -- open-browser.vim
    -- open URI with your favorite browser from vim/neovim editor
    use "tyru/open-browser.vim" -- vim script plugin

    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = get_config "todo-comments",
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
        vim.g.undotree_ShortIndicators = 1
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
      config = get_config "gitsigns",
    }

    use {
      "sindrets/diffview.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = get_config "diffview_nvim",
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
      config = get_config "lsp",
    }

    use {
      "jose-elias-alvarez/null-ls.nvim",
      config = get_config "null-ls",
    }

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
      config = get_config "vista",
    }

    --=======================================--
    --           Completion Plugins          --
    --=======================================--

    use {
      "windwp/nvim-autopairs",
      config = get_config "nvim_autopairs",
    }

    use {
      "L3MON4D3/LuaSnip",
      config = get_config "luasnip",
    }

    use {
      "hrsh7th/nvim-cmp",
      config = get_config "nvim_cmp",
    }

    -- Cmp sources
    use "hrsh7th/cmp-nvim-lsp" -- nvim-lsp completion engine
    use "hrsh7th/cmp-nvim-lua" -- nvim lua api (vim.*)
    use "hrsh7th/cmp-buffer" -- buffer words
    use "hrsh7th/cmp-path" -- path completion
    use "hrsh7th/cmp-cmdline" -- cmd line completion
    use "saadparwaiz1/cmp_luasnip" -- luasnip completion source for nvim-cmp
    use "lukas-reineke/cmp-rg" -- ripgrep source
    if executable "curl" and "git" then
      -- NOTE: curl suficies cmp-git dependencies but it can use github and gitlab cli too.
      use {
        "petertriho/cmp-git", -- Github and Gitlab source (issues, mentions and pull requests)
        config = function()
          require("cmp_git").setup()
        end,
      }
    end

    -- cmp-spell
    -- see: https://github.com/hrsh7th/nvim-cmp/issues/69

    -- Cmp comparators
    use "lukas-reineke/cmp-under-comparator" --  comparator function for completion items that start with one or more underlines

    -- lsp signature help, similar to ray-x/lsp_signature.nvim, but much better integrated with nvim_cmp
    use "hrsh7th/cmp-nvim-lsp-signature-help"

    use "onsails/lspkind-nvim" -- vscode like symbols

    --=======================================--
    --          Spelling plugins             --
    --=======================================--

    -- Fixes Neovim's builtin spellchecker for buffers with tree-sitter highlighting.
    -- `:set spell` works with regular (neo)vim regex based highlighting
    -- but when using treesitter highlight neovim gets confused and assumes correct
    -- words (language syntax keywords) are wrong. Spellsitter.nvim fix this
    -- Only for files which have spellsitter treesitter queries
    use {
      "lewis6991/spellsitter.nvim",
      config = function()
        require("spellsitter").setup()
      end,
    }

    --=======================================--
    --          UI - colors / icons          --
    --=======================================--

    -- Zenbones color theme
    use {
      -- has a great light theme: zenbones
      "mcchrish/zenbones.nvim",
      -- Optionally install Lush. Allows for more configuration or extending the colorscheme
      -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
      requires = "rktjmp/lush.nvim",
    }

    use {
      -- great dark theme
      "catppuccin/nvim",
      as = "catppuccin",
      config = get_config "catppuccin",
    }

    use "kyazdani42/nvim-web-devicons"

    -- dims inactive portions of the code you're editing using TreeSitter.
    use {
      "folke/twilight.nvim",
      config = get_config "twilight",
    }

    --=======================================--
    --           UI - extra elements         --
    --=======================================--

    use {
      "nvim-lualine/lualine.nvim",
      config = get_config "lualine",
    }

    -- Add indentation guides even on blank lines
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = get_config "indent_blankline",
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
        vim.g.Hexokinase_ftDisabled = { "dirbuf" }
        -- TODO: include more info
        vim.g.Hexokinase_optInPatterns = "full_hex,rgb,rgba,hsl,hsla"
      end,
    }

    -- Diagnostics interface
    use {
      "folke/trouble.nvim", -- lua plugin
      --config = function() require("plugins.settings.trouble-nvim") end
    }

    use {
      "kosayoda/nvim-lightbulb",
      config = get_config "nvim-lightbulb",
    }

    -- Vim plugin for automatically highlighting
    -- other uses of the word under the cursor. Integrates with Neovim's LSP client for intelligent highlighting.
    -- faster when compared to vim-matchup
    use {
      "RRethy/vim-illuminate",
      config = get_config "vim-illuminate",
    }

    --=======================================--
    --               Documentation           --
    --=======================================--

    -- Doc generator
    use {
      "danymat/neogen",
      config = function()
        require("neogen").setup {
          snippet_engine = "luasnip",
          enabled = true,
        }
      end,
      requires = "nvim-treesitter/nvim-treesitter",
    }

    -- Query RFC database and download RFCs from within Vim
    -- needs python3 support
    use "mhinz/vim-rfc"

    --=======================================--
    --       File and project management     --
    --                   &                   --
    --     Terminals and Tmux integration    --
    --=======================================--

    -- Basically what I need from file management / terminal and tmux integration is:
    --   * A simple split explorer (see: http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/)
    --     so I can view and understand the project tree structure better
    --     I achieve this with dirbuf.nvim (dirvish.vim based split explorer and file manager)
    --   * a way to get QUICKLY to a REAL terminal pane
    --     e.g.: Tmux or a native Kitty pane, NOT the integrated Neovim term
    --     I achieve this with `vim-gtfo`.
    --   * a way to unobtrusively fuzzy find and access the searched items
    --     I achieve this with 'telescope.nvim' and its extensions

    -- see: https://github.com/elihunter173/dirbuf.nvim/issues/3
    use "elihunter173/dirbuf.nvim"

    use {
      "justinmk/vim-gtfo",
      config = function()
        vim.g["gtfo#terminals"] = { unix = "kitty @ launch --type=window" }
      end,
    }

    -- Highly extendable fuzzy finder UI to select elements (files, grep results, open buffers...)
    -- Centered around modularity, allowing for easy customization.
    -- see: https://www.reddit.com/r/neovim/comments/ngt4dn/question_fuzzy_find_grep_search_results_in/
    use {
      "nvim-telescope/telescope.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = get_config "telescope",
    }

    -- Telescope sorter
    -- Replaces the default lua based filtering method of telescope with one mimicking fzf, written in C.
    -- It supports fzf syntax and substantially improves Telescope's performance and sorting quality.
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    -- Project management
    use {
      "ahmedkhalf/project.nvim",
      config = get_config "project-nvim",
    }

    --=======================================--
    --                Search                 --
    --=======================================--

    -- Select some text using Vim's visual mode, then hit *
    -- and # to search for it elsewhere in the file
    -- very useful for difficult to type escape patterns
    use "bronson/vim-visual-star-search"

    -- lightweight alternative to haya14busa/incsearch.vim automatic :nohlsearch option
    -- doesn't use mapping hacks as opposed to https://github.com/junegunn/vim-slash/issues/7
    -- so it works fine with google/vim-searchindex
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
      config = get_config "vimtex",
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
    use {
      "danymat/neogen",
      config = function()
        require("neogen").setup {
          enabled = true,
        }
      end,
      requires = "nvim-treesitter/nvim-treesitter",
    }

    -- Query RFC database and download RFCs from within Vim
    -- needs python3 support
    use "mhinz/vim-rfc"

    --=======================================--
    --            Writing prose              --
    --=======================================--

    if
      executable("perl" and "dict")
      and file_exists("/usr/share/dictd/wn.index", "/usr/share/dictd/moby-thesaurus.index")
    then
      -- perl: for cleaning
      -- dictd: main cli (dict is the executable)
      -- dict-wn: WordNet dictionary for dictd
      -- dict-moby-thesaurus: Moby Thesaurus dictionary for dictd
      use "https://code.sitosis.com/rudism/telescope-dict.nvim"
      -- require('telescope').extensions.dict.synonyms()
    end

    --=======================================--
    --               Testing                 --
    --=======================================--

    -- see:https://github.com/windwp/nvim-autopairs/wiki/Endwise
    use "RRethy/nvim-treesitter-endwise"

    use {
      "ahmedkhalf/project.nvim",
      config = function()
        require "plugins.settings.project-nvim"
      end,
    }

    use "tpope/vim-apathy"

    use "ludovicchabant/vim-gutentags"

      end,
    }

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
        require "plugins.settings.comment_nvim"
      end,
    }

    -- TODO: use nvim-lsp or lsp config from vim-go
    use "fatih/vim-go"

    -- use "m-pilia/vim-pkgbuild"

    -- emmet completion for vim
    -- use "mattn/emmet-vim" -- vim script plugin

    -- multi-language debugger
    -- use "puremourning/vimspector"

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

    --=======================================--
    --               Deprecating             --
    --=======================================--

    -- Distraction free code writing
    -- uses z-index option for floating windows which can be REALLY annoying
    -- use {
    --   "folke/zen-mode.nvim",
    --   config = function()
    --     require "plugins.settings.zenmode"
    --   end,
    -- }

    -- buffer complete the word before the cursor when in cmdline mode
    -- deprecated in favor of wilder.nvim or nvim-cmp cmdline completion
    -- use "vim-scripts/CmdlineComplete"

    -- use "ntpeters/vim-better-whitespace"

    -- Tmux integration,
    -- I wasn't using very much
    -- use "tpope/vim-tbone"

    -- use "markonm/traces.vim"

    -- TODO: do its tutorial
    -- TODO: read https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
    -- use "mg979/vim-visual-multi"

    --=======================================--
    --               Bootstrap               --
    --=======================================--

    if PACKER_BOOTSTRAP then
      packer.sync() -- run PackerSync for the first time
      -- TODO: try to source init.lua in the first install, so reopening Neovim isn't necessary
      -- For some reason this fails
      -- vim.cmd("source " .. vim.fn.stdpath "config" .. "/init.lua")
    end
  end,
  config = {
    -- Move packer_compiled.lua to lua/packer dir
    --
    -- Compiled file was moved because check plugin status tables
    -- such as packer_plugins["<plugin>"] and packer_plugins["<plugin>"].loaded
    -- are only available AFTER packer_compiled.lua is loaded.
    --
    -- That means default packer_compiled.lua is sourced AFTER init.lua because it is placed
    -- inside plugin/ folder, so that means that we wouldn't be able to use those tables
    -- at init.lua. They are currently used in `keymaps.lua` and `utils.lua`
    --
    -- see: https://github.com/wbthomason/packer.nvim#checking-plugin-statuses
    -- see: https://github.com/wbthomason/packer.nvim/discussions/196
    compile_path = vim.fn.stdpath "config" .. "/lua/packer/packer_compiled.lua",
  },
}

local packer_compiled_status_ok = pcall(require, "packer/packer_compiled")

if not packer_compiled_status_ok then
  -- first install, don't return packer yet
  return
else
  return M
end
