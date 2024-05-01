--=======================================--
--               leader key              --
--=======================================--

-- Remap <Space> to be the leader key
-- SEE: taken from defaults.nvim: https://github.com/nvim-lua/kickstart.nvim
-- NOTE: <Space> "\" char (default (N)vim leader) works independently
-- WARN: [lazy.nvim](https://github.com/folke/lazy.nvim) tells to make sure to set `mapleader` before lazy so your mappings are correct
--       but as a far as I tested, it doesn't seem to affect my setup. I'm keeping it here just to make sure.

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--=======================================--
--           lazy.nvim bootstrap         --
--=======================================--

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath }
    vim.fn.system { "git", "-C", lazypath, "checkout", "tags/stable" } -- last stable release
  end
end
vim.opt.rtp:prepend(lazypath)

--=======================================--
--                Utils                  --
--=======================================--

local executable = require("user.modules.utils").executable
local file_exists = require("user.modules.utils").file_exists
local is_mac = require("user.modules.utils").is_mac

-- expects the name of a plugin config file placed inside plugins/settings
-- taken from: https://github.com/Allaman/nvim/blob/main/lua/plugins.lua#L6-L10
local get_config = function(plugin_config_file)
  -- local actual_require = "require ('plugins.settings." .. plugin_config_file .. "')"
  plugin_config_file = "plugins.settings." .. plugin_config_file
  require(plugin_config_file)

  -- require("plugins.settings." .. plugin_config_file)

  -- TODO: make it work with lazy nvim
end

-- Every plugin I use besides the ones that live
-- in nvim/plugin and nvim/scratch lives in this file.
-- I don't like to keep them separated because it is harder to see which
-- plugins belong to the same categories
--
-- WARN: lua language server has a limitation and
-- accuses a false error on the first table item
--       SEE: https://github.com/folke/lazy.nvim/issues/20
--=======================================--
--        lazy.nvim managed plugins      --
--=======================================--

require("lazy").setup({

  --=======================================--
  --              Utilities                --
  --=======================================--

  -- Activity Watch open source time tracker vim extension
  -- TODO: doesn't work with awesome wm, why?
  -- TODO: include condition to be triggered: aw-watcher process must be running
  -- "ActivityWatch/aw-watcher-vim",

  -- TODO: write conditions for installing it
  -- cond = file_exists "/Applications/ActivityWatch.app/Contents/MacOS/aw-server",

  -- Better profiling output for startup.
  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  --=======================================--
  --               Developing              --
  --=======================================--

  -- inspired by
  -- use "roxma/vim-tmux-clipboard"
  -- use {
  --   "~/2022/tmux-clipboard.nvim",
  --   config = function()
  --     require("tmux-clipboard").setup()
  --   end,
  -- },

  -- use "~/Projects/Github/Personal/Original/NvimPlugins/vim-projectionist-webdev"

  -- use "~/Projects/Github/Personal/Original/telescope-project-references.git/main/"
  -- use {
  --   "~/Projects/Github/Personal/Original/smart_append.nvim",
  --   config = function()
  --     require("smart_append").setup {
  --       respect_indent_from = "smart",
  --     }
  --   end,
  -- }

  --=======================================--
  --        Movement and edit              --
  --=======================================--

  -- Small plugin to make blockwise Visual mode more useful with I and A operators
  "kana/vim-niceblock",

  -- Pairs of handy bracket mappings
  "tpope/vim-unimpaired",

  -- More useful word motions for Vim
  -- CamelCase, acronyms, UPPERCASE, lowercase, hex colors, hex and binary literals...
  "chaoren/vim-wordmotion",

  "ggandor/leap.nvim",

  {
    "ggandor/leap-spooky.nvim",
    config = function()
      require("leap-spooky").setup {
        affixes = {
          -- These will generate mappings for all native text objects, like:
          -- (ir|ar|iR|aR|im|am|iM|aM){obj}.
          -- Special line objects will also be added, by repeating the affixes.
          -- E.g. `yrr<leap>` and `ymm<leap>` will yank a line in the current
          -- window.
          -- You can also use 'rest' & 'move' as mnemonics.
          remote = { window = "r", cross_window = "R" },
          magnetic = { window = "m", cross_window = "M" },
        },
        -- If this option is set to true, the yanked text will automatically be pasted
        -- at the cursor position if the unnamed register is in use.
        paste_on_remote_yank = false,
      }
    end,
  },

  {
    "tpope/vim-rsi",
    config = function()
      vim.g.rsi_no_meta = 1 -- disable meta maps
    end,
  },

  -- enable repeating supported plugins maps with "." motion
  -- TODO: list plugins that depends on vim-repeat
  "tpope/vim-repeat",

  -- Text alignment
  "junegunn/vim-easy-align",

  -- Change word casing (camelCase, snake_case, ...)
  "arthurxavierx/vim-caser",

  -- use xsel instead of xclip, -- TODO: search more about xsel, xclip and its differences
  -- so "clipboard: error: Error: target STRING not available" doesn't happen
  -- SEE: https://github.com/neovim/neovim/issues/2642#issuecomment-170271675
  -- NOTE: vim-exchange must be using named clipboards under the hood, which is neat <3
  "tommcdo/vim-exchange",

  {
    -- Provides better visualization for f and t motions
    -- and clears `;` and `,` keys for more useful mappings
    -- Better than lightspeed f and t motions IMO
    "rhysd/clever-f.vim",
    config = function()
      vim.g.clever_f_mark_direct = 1 -- chars that can be moved directly are highlighted
      -- vim.g.clever_f_fix_key_direction = 1 -- f: onwards, F: backwards for `F` search
      vim.g.clever_f_timeout_ms = 900 -- ms
      vim.g.clever_f_highlight_timeout_ms = 900 -- ms, should follow clever_f_timeout_ms
      vim.g.clever_f_across_no_line = 1 -- cursorline only
    end,
  },

  -- vim surround powerful alternative
  {
    "machakann/vim-sandwich",
    -- TODO: read vim-sandwich help
    config = function()
      -- load vim-surround alternate keymaps
      vim.cmd "runtime macros/sandwich/keymap/surround.vim"
    end,
  },

  -- Intelligently reopen files at your last edit position
  -- also SEE: https://www.reddit.com/r/neovim/comments/p5is1h/how_to_open_a_file_in_the_last_place_you_editied/
  "farmergreg/vim-lastplace",

  -- provides additional text objects
  "wellle/targets.vim",

  -- "AndrewRadev/splitjoin.vim",

  {
    "numToStr/Comment.nvim",
    config = function()
      require "plugins.settings.comment_nvim"
    end,
  },

  --=======================================--
  --          Syntax - Treesitter          --
  --=======================================--

  -- Neovim tree-sitter interface,
  -- provides better highlighting and other goodies
  {
    "nvim-treesitter/nvim-treesitter", -- lua plugin
    build = ":TSUpdate",
    -- WARN: setup with lazy nvim
    config = function()
      require "plugins.settings.treesitter"
    end,
  },

  {
    "nvim-treesitter/playground",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  -- Autoclose and autorename html tags using nvim-treesitter
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
  -- used in conjunction with t-pope/vim-commentary plugin
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  -- Additional textobjects for treesitter
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  {
    "RRethy/nvim-treesitter-textsubjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  {
    "nvim-treesitter/nvim-treesitter-refactor",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  -- SEE:https://github.com/windwp/nvim-autopairs/wiki/Endwise
  {
    "RRethy/nvim-treesitter-endwise",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  --=======================================--
  --             Syntax - Other            --
  --=======================================--

  -- Vim editing support for kmonad config files
  -- TODO: make this condition only for linux because kmonad on macos is a litte cumbersome
  "kmonad/kmonad-vim",

  -- Syntax highlighting for Kitty terminal config files
  "fladson/vim-kitty",

  "zdharma-continuum/zinit-vim-syntax",

  --=======================================--
  --              Keymaps                  --
  --=======================================--

  -- which-key.nvim
  -- Key bindings displayer and organizer
  -- this plugin makes junegunn/vim-peekaboo, nvim-peekup and registers.nvim obsolete
  -- although some features overlap, see if any of the above has something to add
  {
    "folke/which-key.nvim",
    -- WARN: setup with lazy nvim
    config = function()
      require "plugins.settings.which-key"
    end,
  },

  -- open-browser.vim
  -- open URI with your favorite browser from vim/neovim editor
  "tyru/open-browser.vim", -- vim script plugin

  -- Relevant issue, SEE: https://github.com/folke/todo-comments.nvim/issues/6
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    -- WARN: setup with lazy nvim
    config = function()
      require "plugins.settings.todo-comments"
    end,
  },

  --=======================================--
  --      Git, file history and diffs      --
  --=======================================--

  -- Undo history visualizer for vim
  -- Works like a commit history without messing with it
  -- Has persistant-undo support
  {
    "mbbill/undotree", -- vim script plugin
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_ShortIndicators = 1
    end,
  },

  -- Vim/Neovim plugin to reveal the commit messages under the cursor
  {
    "rhysd/git-messenger.vim",
    config = function()
      vim.g.git_messenger_floating_win_opts = { border = "single" }
    end,
  },

  -- Awesome git wrapper
  {
    "tpope/vim-fugitive",
    dependencies = "tpope/vim-rhubarb", -- GitHub extension for fugitive.vim
  },

  -- Fast git commit browser
  {
    "junegunn/gv.vim",
    dependencies = {
      "tpope/vim-fugitive",
      "tpope/vim-rhubarb", -- GitHub extension for fugitive.vim
    },
  },

  -- Fast gitsigns with yadm support
  -- TODO: find a way to integrate gitsigns with vim-signature due
  {
    "lewis6991/gitsigns.nvim", -- lua plugin
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require "plugins.settings.gitsigns"
    end,
  },

  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require "plugins.settings.diffview_nvim"
    end,
  },

  "andrewradev/linediff.vim",

  --=======================================--
  --                  DAP                  --
  --=======================================--

  -- nvim-dap: debug adapter protocol client implementation for Neovim
  -- TODO: see https://www.reddit.com/r/neovim/comments/szajig/nvimdap_with_typescript_and_react_native/
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      dap.adapters.python = {
        type = "executable",
        command = "/home/development/.local/share/nvim/nvim-debug-adapters/venv/bin/python",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          -- The first three options are required by nvim-dap
          type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
          request = "launch",
          name = "Launch file",

          -- Options below are for debugpy, SEE https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

          program = "${file}", -- This configuration will launch the current file if used.
          pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` directory in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local venv = os.getenv "VIRTUAL_ENV"
            local command = vim.fn.getcwd() .. string.format("%s/bin/python", venv)
            return command
          end,
        },
      }
    end,
  },

  -- use {
  --   "rcarriga/nvim-dap-ui",
  --   config = function()
  --     require("dapui").setup()
  --   end,
  -- }

  --=======================================--
  --                  LSP                  --
  --=======================================--

  -- Quickstart configurations for the Nvim LSP client
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.settings.lsp"
    end,
  },

  -- Null-ls was deprecated :(
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   config = function()
  --     require "plugins.settings.null-ls"
  --   end,
  -- },

  -- Utilities to improve the TypeScript development experience
  -- for Neovim's built-in LSP client.
  -- TODO: replace with its successor: https://github.com/jose-elias-alvarez/typescript.nvim
  {
    "jose-elias-alvarez/nvim-lsp-ts-utils", -- lua plugin
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },

  --=======================================--
  --               Completion              --
  --=======================================--

  -- TODO: configure it properly so it become usefull instead of annoying
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    -- config = function()
    --   require "plugins.settings.nvim_autopairs"
    -- end,
  },

  {
    "L3MON4D3/LuaSnip",
    config = function()
      require "plugins.settings.luasnip"
    end,
  },

  -- TODO: here we go again, make this shit work
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require "plugins.settings.nvim_cmp"
    end,
  },

  -- Cmp sources
  "hrsh7th/cmp-nvim-lsp", -- nvim-lsp completion engine
  "hrsh7th/cmp-nvim-lua", -- nvim lua api (vim.*)
  "hrsh7th/cmp-buffer", -- buffer words
  "hrsh7th/cmp-path", -- path completion
  "hrsh7th/cmp-cmdline", -- cmd line completion
  "saadparwaiz1/cmp_luasnip", -- luasnip completion source for nvim-cmp
  "lukas-reineke/cmp-rg", -- ripgrep source

  -- NOTE: curl suficies cmp-git dependencies but it can use github and gitlab cli too.
  {
    "petertriho/cmp-git", -- Github and Gitlab source (issues, mentions and pull requests)
    config = function()
      require("cmp_git").setup()
    end,
    dependencies = "nvim-lua/plenary.nvim",
    cond = executable "git" and executable "curl",
  },
  -- end

  -- cmp-spell
  -- SEE: https://github.com/hrsh7th/nvim-cmp/issues/69

  -- Cmp comparators
  "lukas-reineke/cmp-under-comparator", --  comparator function for completion items that start with one or more underlines

  -- lsp signature help, similar to ray-x/lsp_signature.nvim, but much better integrated with nvim_cmp
  "hrsh7th/cmp-nvim-lsp-signature-help",

  "onsails/lspkind-nvim", -- vscode like symbols

  --=======================================--
  --               Spelling                --
  --=======================================--

  -- These plugins enchange vim native spell function

  -- use "tweekmonster/spellrotate.vim" -- doesn't work

  -- TODO: improve this plugin (by converting to lua, adding treesitter integration, etc.)
  -- per project spellfile
  -- BUG: "dbmrq/vim-dialect" plugin conflicts with fugitive
  -- use "dbmrq/vim-dialect"

  --=======================================--
  --       UI - colorschemes / icons       --
  --=======================================--

  -- Zenbones color theme
  {
    -- has a great light theme: zenbones
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    dependencies = "rktjmp/lush.nvim",
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup {
        -- your personal icons can go here (to override)
        -- you can specify color or cterm_color instead of specifying both of them
        -- DevIcon will be appended to `name`
        override = {
          tags = {
            icon = "",
            color = "#428850", -- TODO: define it
            cterm_color = "65", -- TODO: define it
            name = "tags",
          },
          Makefile = {
            icon = "",
            color = "#428850", -- TODO: define it
            cterm_color = "65", -- TODO: define it
            name = "Makefile",
          },
        },
      }
    end,
  },

  -- dims inactive portions of the code you're editing using TreeSitter.
  {
    "folke/twilight.nvim",
    config = function()
      require "plugins.settings.twilight"
    end,
  },

  "aktersnurra/no-clown-fiesta.nvim",
  "wuelnerdotexe/vim-enfocado",
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      -- setup must be called before loading the colorscheme
      require("gruvbox").setup {
        undercurl = true,
        underline = true,
        bold = true,
        -- italic = true,
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {
          SignColumn = { bg = "#282828" },
          CursorLineNr = {
            bg = "#282828",
            bold = true,
          },
          GitSignsDelete = { fg = "#fb4934", bg = "#282828" },
          GitSignsChange = { fg = "#8ec07c", bg = "#282828" },
          GitSignsAdd = { fg = "#b8bb26", bg = "#282828" },
        },
        dim_inactive = false,
        transparent_mode = false,
      }
    end,
  },

  --=======================================--
  --           UI - extra elements         --
  --=======================================--

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "plugins.settings.lualine"
    end,
  },

  -- Add indentation guides even on blank lines
  -- WARN: can cause serious lag, in my macbookpro without the good battery
  -- use {
  --   "lukas-reineke/indent-blankline.nvim",
  --   config = get_config "indent_blankline",
  -- }

  -- vim-hexokinase:
  -- asynchronously display the colours in the file
  -- (#rrggbb, #rgb, rgb(a)? functions, hsl(a)? functions, web colours, custom patterns)
  -- TODO: macos: add custom hex color pattern from yabai, that is not being recognized
  -- TODO: find alternative to vim-hexokinase?
  -- golang MUST be installed
  -- use {
  --   "RRethy/vim-hexokinase", -- vim script plugin
  --   run = "make hexokinase",
  --   config = function()
  --     vim.g.Hexokinase_ftDisabled = { "dirbuf", "dirvish" }
  --     -- TODO: include more info
  --     vim.g.Hexokinase_optInPatterns = "full_hex,rgb,rgba,hsl,hsla"
  --   end,
  -- }

  -- Diagnostics interface
  {
    "folke/trouble.nvim", -- lua plugin
    -- config = function()
    --   require "plugins.settings.trouble-nvim"
    -- end,
  },

  -- WARN: has perfomance impact
  -- TODO: test it again
  -- use {
  --   "kosayoda/nvim-lightbulb",
  --   config = get_config "nvim-lightbulb",
  -- }

  -- Vim plugin for automatically highlighting
  -- other uses of the word under the cursor. Integrates with Neovim's LSP client for intelligent highlighting.
  -- faster when compared to vim-matchup
  {
    "RRethy/vim-illuminate",
    config = function()
      require "plugins.settings.vim-illuminate"
    end,
  },

  -- Distraction free code writing
  -- uses z-index option for floating windows which can be REALLY annoying
  -- better than TrueZen.nvim IMO
  {
    "folke/zen-mode.nvim",
    config = function()
      require "plugins.settings.zenmode"
    end,
  },

  --=======================================--
  --               Documentation           --
  --=======================================--

  -- Doc generator
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup {
        enabled = true,
        snippet_engine = "luasnip",
        languages = {
          lua = { template = { annotation_convention = "emmylua" } },
        },
      }
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  -- Query RFC database and download RFCs from within Vim
  -- needs python3 support
  "mhinz/vim-rfc",

  --=======================================--
  --       File and project management     --
  --                   &                   --
  --     Terminals and Tmux integration    --
  --=======================================--

  -- Basically what I need from file management, terminal and tmux integration is:
  --   * A split explorer (SEE: http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/)
  --     so I can view and understand the project tree structure better.
  --     This is great to change between files that are near the current file you're working on.
  --     Good for projects that YOU ARE familiar with.
  --
  --   * A project drawer (SEE: http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/)
  --     so I can view and understand the project tree structure better.
  --     This is good for when you need to share your screen and not make people confused
  --
  --   * A tree style explorer (NOTE: vim-dirvish unfortunately doesn't support this, fern.vim do)
  --     NOTE: this isn't tied to `split explorer` vs `project drawer` file manager style as both can have a tree
  --     style exploring.
  --
  --   * A way to get QUICKLY to a real terminal pane
  --     e.g.: Tmux or native Kitty pane
  --     I achieve this with `justinmk/vim-gtfo` plugin.
  --     TODO: configure it to support Neovim integrated terminal
  --
  --   * A way to unobtrusively fuzzy find and access the searched items
  --     I achieve this with 'telescope.nvim' and its extensions
  --     and using `:Grep` command , SEE: grep.vim plugin
  --
  --   * A way to quickly add, delete, copy and manipulate files from within vim

  {
    "justinmk/vim-gtfo",
    config = function()
      -- if vim.env.TERM == "alacritty" then
      --   -- doesn't work , SEE: https://github.com/justinmk/vim-gtfo/issues/50
      --   vim.g["gtfo#terminals"] = { mac = "alacritty --working-directory $(pwd -P) &" }
      -- end
      if vim.env.TERM == "xterm-kitty" then
        -- WARN: relies on kitty remote feature
        vim.g["gtfo#terminals"] = { unix = "kitty @ launch --type=window" }
      end
    end,
  },

  -- THE best split explorer
  -- NOTE: it has a right jumplist and alternate file behavior
  --       SEE: https://superuser.com/questions/674187/vim-why-does-ctrlo-jump-to-the-previous-file-instead-of-to-the-previous-direc
  -- {
  --   "justinmk/vim-dirvish",
  --   config = function()
  --     -- SEE: https://vi.stackexchange.com/questions/15959/how-to-setup-vim-for-working-in-a-very-large-directory
  --     -- Sort first folders that start with dot than other folders than files that start with dot than other files
  --     -- SEE: https://github.com/justinmk/vim-dirvish/issues/89
  --     vim.g.dirvish_mode = ":sort | sort ,^.*/,"
  --     -- taken from: https://github.com/justinmk/vim-dirvish/issues/204
  --     --
  --     -- BUG: using nvim-web-devicons with dirvish cause massive slowness in a directory with lots of files or
  --     -- subdirectoires, e.g. node_modules directory.
  --     -- vim.cmd [[call dirvish#add_icon_fn({p -> luaeval("require('nvim-web-devicons').get_icon(vim.fn.fnamemodify('" .. p .. "', ':e')) or ''")})]]
  --   end,
  -- },
  -- "fsharpasharp/vim-dirvinist",

  {
    "nvim-tree/nvim-tree.lua",
    version = "nightly", -- optional, updated every week. (see issue #1193)
    config = function()
      require("nvim-tree").setup {
        view = {
          -- mappings = {
          --   list = {
          --     { key = "<CR>", action = "edit_in_place" }, -- vinegar
          --   },
          -- },
        },
        hijack_netrw = false,
        hijack_directories = {
          enable = false,
        },
        diagnostics = {
          enable = false,
        },
        sync_root_with_cwd = true,
      }
    end,
  },

  "tpope/vim-eunuch",

  "tpope/vim-projectionist",

  -- Highly extendable fuzzy finder UI to select elements (files, grep results, open buffers...)
  -- Centered around modularity, allowing for easy customization.
  -- SEE: https://www.reddit.com/r/neovim/comments/ngt4dn/question_fuzzy_find_grep_search_results_in/
  {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require "plugins.settings.telescope"
    end,
  },

  -- Telescope sorter
  -- Replaces the default lua based filtering method of telescope with one mimicking fzf, written in C.
  -- It supports fzf syntax and substantially improves Telescope's performance and sorting quality.
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- A simple wrapper around git worktree operations, create, switch, and delete.
  -- There is some assumed workflow within this plugin (i.e. using bare git repos)
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require "plugins.settings.git_worktree"
    end,
  },

  -- cd, tcd and lcd for careless typers
  "nanotee/zoxide.vim",

  --=======================================--
  --                Search                 --
  --=======================================--

  -- Select some text using Vim's visual mode, then hit *
  -- and # to search for it elsewhere in the file
  -- very useful for difficult to type escape patterns
  -- "bronson/vim-visual-star-search",

  -- lightweight alternative to haya14busa/incsearch.vim automatic :nohlsearch option
  -- doesn't use mapping hacks as opposed to https://github.com/junegunn/vim-slash/issues/7
  -- SEE: https://github.com/neovim/neovim/issues/5581
  -- TODO: translate this small plugin to lua and make g:cool_total_matches work
  --       This will make google/vim-searchindex obsolete
  -- SEE: https://vi.stackexchange.com/questions/26293/show-exact-number-of-matches-even-for-large-99-numbers
  -- SEE: https://github.com/osyo-manga/vim-anzu/
  -- SEE: https://github.com/henrik/vim-indexed-search
  "romainl/vim-cool", -- let g:cool_total_matches = 1 doesn't work with neovim

  --=======================================--
  --          Language specifics           --
  --=======================================--

  "aklt/plantuml-syntax",

  "rust-lang/rust.vim",

  -- VimTeX: A modern Vim and neovim filetype plugin for LaTeX files.
  {
    "lervag/vimtex",
    config = function()
      require "plugins.settings.vimtex"
    end,
  },

  -- Show js package information using virtual text in package.json files
  -- use {
  --   "vuki656/package-info.nvim",
  --   requires = "MunifTanjim/nui.nvim",
  --   config = function()
  --     require("package-info").setup()
  --   end,
  -- }

  -- Python folding
  -- NOTE: Python treesitter folding is really bad, this plugin is better.
  -- use {
  --   "tmhedberg/SimpylFold",
  --   config = function()
  --     vim.g.SimpylFold_docstring_preview = 1
  --     vim.g.SimpylFold_fold_docstring = 1
  --     vim.b.SimpylFold_fold_docstring = 1
  --     vim.g.SimpylFold_fold_import = 1
  --     vim.b.SimpylFold_fold_import = 1
  --     vim.g.SimpylFold_fold_blank = 0
  --     vim.b.SimpylFold_fold_blank = 0
  --   end,
  -- }
  --

  -- TODO: include motiviation
  -- "Konfekt/FastFold",

  -- TODO: setup nvim-ufo plugin properly

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
  },

  --=======================================--
  --            Writing prose              --
  --=======================================--

  -- TODO: change Ditto file location
  -- TODO: only use it when you find a way to change Ditto dir
  --       and dittofile
  -- use {
  --   "dbmrq/vim-ditto",
  --   config = function()
  --     vim.cmd "autocmd Filetype markdown,text,tex DittoOn"
  --   end,
  -- }

  -- WARN: setup for lazy nvim
  -- if vim.loop.os_uname().sysname ~= "Darwin" then
  --   -- TODO: find out if the below only works on Linux
  --   if
  --     executable("perl" and "dict")
  --     and file_exists("/usr/share/dictd/wn.index", "/usr/share/dictd/moby-thesaurus.index")
  --   then
  --     -- perl: for cleaning
  --     -- dictd: main cli (dict is the executable)
  --     -- dict-wn: WordNet dictionary for dictd
  --     -- dict-moby-thesaurus: Moby Thesaurus dictionary for dictd
  --     use "https://code.sitosis.com/rudism/telescope-dict.nvim"
  --
  --     -- require('telescope').extensions.dict.synonyms()
  --   end
  -- end

  --=======================================--
  --               Testing                 --
  --=======================================--

  "p00f/alabaster.nvim",

  "Shatur/neovim-ayu",

  "ton/vim-bufsurf",

  -- {
  --   "stevearc/oil.nvim",
  --   config = function()
  --     require("oil").setup()
  --   end,
  -- },

  -- WARN: it doesn't work :(
  {
    "romgrk/todoist.nvim",
    build = ":TodoistInstall",
  },

  -- use "cohama/lexima.vim" -- instead of nvim-autopairs

  -- seems to be great and works with treesitter
  -- {
  --   "wookayin/semshi",--[[ , build = "UpdateRemotePlugins" ]]
  -- },

  -- seems buggy
  -- Lua
  -- use {
  --   "abecodes/tabout.nvim",
  --   config = function()
  --     require("tabout").setup {
  --       tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
  --       backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
  --       act_as_tab = true, -- shift content if tab out is not possible
  --       act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
  --       default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
  --       default_shift_tab = "<C-d>", -- reverse shift default action,
  --       enable_backwards = true, -- well ...
  --       completion = true, -- if the tabkey is used in a completion pum
  --       tabouts = {
  --         { open = "'", close = "'" },
  --         { open = '"', close = '"' },
  --         { open = "`", close = "`" },
  --         { open = "(", close = ")" },
  --         { open = "[", close = "]" },
  --         { open = "{", close = "}" },
  --       },
  --       ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
  --       exclude = {}, -- tabout will ignore these filetypes
  --     }
  --   end,
  --   wants = { "nvim-treesitter" }, -- or require if not used so far
  --   after = { "nvim-cmp" }, -- if a completion plugin is using tabs load it before
  -- }

  -- TODO: find a lua alternative for taboo.vim
  {
    "gcmt/taboo.vim",
    config = function()
      vim.g.taboo_tab_format = " %N:  %P "
      vim.g.taboo_renamed_tab_format = " %N:  %P {%l} "
    end,
  },

  -- NOTE: this is a gem
  "kien/tabman.vim",

  -- NOTE: the motivation for this plugins is that
  -- tree-sitter-comment parser is unusable on larger files
  -- use {
  --   "folke/paint.nvim",
  --   config = function()
  --     require("paint").setup {
  --       ---@type PaintHighlight[]
  --       highlights = {
  --         {
  --           -- filter can be a table of buffer options that should match,
  --           -- or a function called with buf as param that should return true.
  --           -- The example below will paint @something in comments with Constant
  --           filter = { filetype = "lua" },
  --           -- NOTE: you can't use it for NonText chars such as showbreak
  --           pattern = "%s*%-%-%-%s*(@%w+)",
  --           hl = "Constant",
  --         },
  --       },
  --     }
  --   end,
  -- }
  -- TODO: test https://github.com/X3eRo0/dired.nvim (similar to dired emacs workflow, and related to dirbuf.nvim)

  -- alt - {h,j,k,l} on steroids
  -- NOTE: better than t pope/vim-unimpaired [e and ]e mappings, replace then by using vim-move
  "matze/vim-move",

  -- -- NOTE: testing
  -- {
  --   "martineausimon/nvim-lilypond-suite",
  --   dependencies = "MunifTanjim/nui.nvim",
  -- },

  "gauteh/vim-cppman",

  -- SEE: https://github.com/vim-test/vim-test/issues/272
  "vim-test/vim-test",

  {
    "nvim-telescope/telescope-project.nvim",
    config = function()
      require("telescope").load_extension "project"
    end,
  },

  "tpope/vim-dadbod",

  "kristijanhusak/vim-dadbod-ui",

  -- ctags viewer (universal-ctags)
  -- use "https://github.com/preservim/tagbar"

  -- use "wincent/vcs-jump"

  -- TODO: do its tutorial
  -- TODO: read https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
  "mg979/vim-visual-multi",

  -- finding a dispatcher / taskrunner
  "tpope/vim-dispatch",
  "radenling/vim-dispatch-neovim",

  -- use "skywind3000/asyncrun.vim"

  -- yarn berry workarounds
  -- use "https://github.com/lbrayner/vim-rzip"

  -- Yank without moving cursor.
  -- It is REALLY annoying that the cursor moves by default when yanking.
  -- This plugin changes this behavior.
  "svban/YankAssassin.vim",

  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.trailspace").setup {
        -- Highlight only in normal buffers (ones with empty 'buftype'). This is
        -- useful to not show trailing whitespace where it usually doesn't matter.
        only_in_normal_buffers = true,
      }
    end,
  },

  -- nvim-neoclip.lua records EVERYTHING that gets yanked in your vim session.
  -- SEE: https://github.com/AckslD/nvim-neoclip.lua/issues/87
  -- All your yanks are part of a single history which you can search through using the telescope picker,
  -- it is not grouped by which register was used.
  -- The register argument to the command is instead for deciding which register you want to populate with an entry from the history.
  -- No matter the register everything goes to a shared saved

  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      "kkharji/sqlite.lua", -- for persistent sessions
    },
    config = function()
      require("neoclip").setup {
        history = 1000,
        enable_persistent_history = false,
        content_spec_column = true,

        -- WARN: if the database gets too big it can make neovim really slow to start
        --       Why this happens? Because there are too many items or because one of the items is too large?
        --       It seems to be the latter, because when I had this problem,
        --       there were only 300 items in neoclip.sqlite3 database.
        db_path = vim.fn.stdpath "data" .. "/databases/neoclip.sqlite3",
      }
      require("telescope").load_extension "neoclip"
    end,
  },

  -- use {
  --   "akinsho/toggleterm.nvim",
  --   config = function()
  --     require("toggleterm").setup {
  --       -- size can be a number or function which is passed the current terminal
  --       size = 20,
  --       open_mapping = [[<c-\>]],
  --       hide_numbers = true, -- hide the number column in toggleterm buffers
  --       shade_filetypes = {},
  --       shade_terminals = true,
  --       shading_factor = "<number>", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  --       start_in_insert = true,
  --       insert_mappings = true, -- whether or not the open mapping applies in insert mode
  --       terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  --       persist_size = true,
  --       direction = "vertical",
  --       close_on_exit = true, -- close the terminal window when the process exits
  --       shell = vim.o.shell, -- change the default shell
  --       -- This field is only relevant if direction is set to 'float'
  --       float_opts = {
  --         -- The border key is *almost* the same as 'nvim_open_win'
  --         -- SEE :h nvim_open_win for details on borders however
  --         -- the 'curved' border is a custom border type
  --         -- not natively supported but implemented in this plugin.
  --         border = "single",
  --         winblend = 3,
  --         highlights = {
  --           border = "Normal",
  --           background = "Normal",
  --         },
  --       },
  --     }
  --   end,
  -- }

  -- terminal syntax file
  -- i was hopping to use it with kitty scrollback pager
  -- {
  --   "norcalli/nvim-terminal.lua",
  --   config = function()
  --     require("terminal").setup()
  --   end,
  -- },

  -- great for who likes to work using dir trees
  -- use "https://github.com/nvim-neo-tree/neo-tree.nvim"

  {
    "ThePrimeagen/harpoon",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("harpoon").setup {
        global_settings = {
          -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
          save_on_toggle = false,

          -- saves the harpoon file upon every change. disabling is unrecommended.
          save_on_change = true,

          -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
          enter_on_sendcmd = true,

          -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
          tmux_autoclose_windows = false,

          -- filetypes that you want to prevent from adding to the harpoon list menu.
          excluded_filetypes = { "harpoon" },

          -- set marks specific to each git branch inside git repository
          mark_branch = false,
        },
      }
      require("telescope").load_extension "harpoon"
    end,
  },

  -- also SEE: https://github.com/zegervdv/nrpattern.nvim
  {
    "monaqa/dial.nvim",
    config = function()
      local augend = require "dial.augend"
      require("dial.config").augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
        },
        typescript = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.constant.new { elements = { "let", "const" } },
        },
        typescriptreact = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.constant.new { elements = { "let", "const" } },
        },
        visual = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
        },
      }
    end,
  },

  -- testing nvim-ufo instead
  -- SEE: https://github.com/neovim/neovim/issues/12153
  -- use {
  --   "lewis6991/foldsigns.nvim",
  --   config = function()
  --     require("foldsigns").setup()
  --   end,
  -- }

  -- a little buggy
  -- use {
  --   "gelguy/wilder.nvim",
  --   requires = { "romgrk/fzy-lua-native" },
  -- }
  --
  -- -- wilder.nvim dependency
  -- use {
  --   "nixprime/cpsm",
  --   run = "bash ./install.sh",
  -- }

  -- TODO: include explanation
  -- REALLY useful
  {
    "notomo/cmdbuf.nvim",
    -- config = function()
    --   require "plugins.settings.cmdbuf"
    -- end,
  },

  "bluz71/vim-moonfly-colors",

  -- TODO: explore it more because it usefull
  -- "AndrewRadev/whitespaste.vim",

  -- Very useful but a little bit difficult to grasp how it works when you haven't use it
  -- SEE: https://www.reddit.com/r/vim/comments/hz1543/help_need_a_better_copy_and_paste_flow_replace/
  -- TODO: replace with a better plugin
  {
    "inkarkat/vim-ReplaceWithRegister",
    dependencies = {
      "inkarkat/vim-ingo-library", -- optional
      "tpope/vim-repeat", -- to support repetition with a register other than the default one
      -- "inkarkat/vim-visualrepeat", -- optional, TODO: explore it
    },
  },

  {
    "inkarkat/vim-UnconditionalPaste",
    -- init = function()
    --   -- TODO: add proper mappings in keymaps.lua
    --   vim.g.UnconditionalPaste_no_mappings = 1
    -- end,
  },

  -- Markdown live preview in browser
  -- this works great! but I'd like a pandoc based solution
  -- SEE: https://www.reddit.com/r/neovim/comments/tfa9hy/what_plugins_to_use_for_markdown/
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && yarn install",
  },

  -- use "vim-pandoc/vim-pandoc"

  -- Syntax highlighting for generic log files in VIM
  "MTDL9/vim-log-highlighting",

  -- SEE: https://technotales.wordpress.com/2007/10/03/like-slime-for-vim/
  {
    "jpalardy/vim-slime",
    config = function()
      if vim.env.TMUX == nil then
        if vim.env.TERM == "xterm-kitty" then
          vim.g.slime_target = "kitty"
        else
          vim.g.slime_target = "neovim" -- neovim bultin terminal emulator
        end
      else
        vim.g.slime_target = "tmux"
      end
    end,
  },

  -- json schemas for json language server
  "b0o/SchemaStore.nvim",

  -- WARN: CHECK for the error
  -- Error detected while processing vim-mark/plugin/mark.vim:
  -- line  293:
  -- E227: mapping already exists for  ?
  -- {
  --   "inkarkat/vim-mark",
  --   dependencies = "inkarkat/vim-ingo-library",
  --   config = function()
  --     -- disable all plugin mappings
  --     vim.g.mw_no_mappings = 1
  --   end,
  -- },

  -- Don't mess with projects indentation, specially the ones that I don't maintain
  -- It has support for editorconfig, making editorconfig/editorconfig-vim plugin redudant
  -- eventually check NMAC427/guess-indent.nvim plugin and see if it is worth replacing vim-sleuth
  -- SEE: https://stackoverflow.com/questions/13849368/can-vim-display-two-spaces-for-indentation-while-keeping-four-spaces-in-the-fil
  "tpope/vim-sleuth",

  -- Tmux integration,
  -- I wasn't using very much
  "tpope/vim-tbone",

  {
    "christoomey/vim-tmux-navigator",
    cond = vim.env.TMUX ~= nil,
  },

  {
    "knubie/vim-kitty-navigator",
    build = "cp ./*.py ~/.config/kitty/",
    cond = vim.env.TMUX == nil and vim.env.TERM == "xterm-kitty",
  },

  "folke/neodev.nvim",

  "inkarkat/vim-EnhancedJumps",
  "inkarkat/vim-ingo-library",
  --
  -- toggle comceal, uses native vim regex (instead of nvim-treesitter)
  -- doesn't work well but it can stay as an idea of future plugin development
  -- SEE: https://github.com/folke/todo-comments.nvim/issues/6
  -- requires additional_vim_regex_highlighting = true marked in treeisitter config
  -- use "vim-scripts/Comceal"

  "kana/vim-operator-user", -- needed for quikchl
  -- use "t9md/vim-quickhl"
  --

  -- {
  --   "j-hui/fidget.nvim",
  --   tag = "legacy",
  --   event = "LspAttach",
  --   opts = {
  --     -- options
  --   },
  -- },

  -- GREAT for working in a multi language project, that uses FFI functions, such as wasm ones
  {
    "pechorin/any-jump.vim",
    config = function()
      vim.g.any_jump_ignored_files = { "*.tmp", "*.temp", ".yarn/*", "yarn.lock" }
    end,
  },

  -- use {
  --   "anuvyklack/pretty-fold.nvim",
  --   config = function()
  --     require("pretty-fold").setup {
  --       keep_indentation = false,
  --       fill_char = "━",
  --       sections = {
  --         left = {
  --           "━ ",
  --           function()
  --             return string.rep("*", vim.v.foldlevel)
  --           end,
  --           " ━┫",
  --           "content",
  --           "┣",
  --         },
  --         right = {
  --           "┫ ",
  --           "number_of_folded_lines",
  --           ": ",
  --           "percentage",
  --           " ┣━━",
  --         },
  --       },
  --     }
  --     require("pretty-fold.preview").setup()
  --   end,
  -- }

  -- use {
  --   "m-demare/hlargs.nvim",
  --   config = function()
  --     require("hlargs").setup()
  --     require("hlargs").enable()
  --   end,
  -- }

  -- use "https://github.com/tjdevries/vim-inyoface"
  -- use "https://github.com/tweekmonster/colorpal.vim"

  --
  -- use {
  --   "hoschi/yode-nvim",
  --   config = function()
  --     require("yode-nvim").setup {}
  --   end,
  -- }
  --

  {
    "chrisbra/NrrwRgn",
    config = function()
      vim.g.nrrw_rgn_vert = 1
      vim.g.nrrw_rgn_rel_min = 50
      vim.g.nrrw_rgn_resize_window = "relative"
      -- vim.g.nrrw_rgn_wdth = 50 -- height or the nr of columns
      vim.b.nrrw_aucmd_create = "set splitright"
    end,
  },

  {
    "voldikss/vim-translator",
    config = function()
      vim.g.translator_target_lang = "pt"
    end,
  },

  "stefandtw/quickfix-reflector.vim",
  "romainl/vim-qf",

  -- use {
  --   "kevinhwang91/nvim-bqf",
  --   config = get_config("nvim-bqf")
  -- }

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("refactoring").setup {}
    end,
  },

  "tpope/vim-apathy",

  -- NOTE: alternative that relies on git hooks https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
  {
    "ludovicchabant/vim-gutentags",
    config = function()
      -- `tags` file placement inside current working directory was annoying me
      -- so I changed it to be under ~/.cache/nvim/gutentags
      -- TODO: automate ~/.cache/nvim/gutentags directory when it's not present
      vim.g.gutentags_cache_dir = vim.fn.stdpath "cache" .. "/gutentags"

      -- TODO: include glob for excluding the root directory of bare git repositories
    end,
  },

  "tpope/vim-characterize",

  -- defines a new text object representing
  -- lines of code at the same indent level.
  -- Useful for python/vim scripts, etc.
  -- SEE: https://www.seanh.cc/2020/08/08/vim-indent-object/
  "michaeljsmith/vim-indent-object",

  -- TODO: use nvim-lsp or lsp config from vim-go
  "fatih/vim-go",

  -- use "m-pilia/vim-pkgbuild"

  -- multi-language debugger
  -- use "puremourning/vimspector"

  -- nvim-dap-python: python interface for dap
  -- nvim-dap extension, providing default configurations
  -- for python and methods to debug individual test methods
  -- or classes.
  -- use "mfussenegger/nvim-dap-python" -- lua plugin

  -- WARN: do not confuse with native vim marks feature, it works independently
  -- TODO: replace with marks.nvim when Neovim shada implementation works correctly.
  "MattesGroeger/vim-bookmarks",

  "will133/vim-dirdiff",

  "creativenull/efmls-configs-nvim",

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  "chrisbra/csv.vim",

  {
    "epwalsh/obsidian.nvim",
    lazy = false,
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
    event = { "BufReadPre " .. vim.fn.expand "~" .. "/obsidian-vaults/main-vault/**.md" },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
    },
    config = function()
      require("obsidian").setup {
        dir = "~/obsidian-vaults/main-vault", -- no need to call 'vim.fn.expand' here
        mappings = {
          -- TODO: fix this
          -- WARN: FOR NOW I SET THIS TO STOP THE FUCKING ANNOYING ERROR MESSAGE,
          ["Q"] = require("obsidian.mapping").gf_passthrough(),
        },
        -- Optional, nvim-cmp completion.
        completion = {
          -- If using nvim-cmp, otherwise is set to false
          nvim_cmp = true,
          -- Trigger completion at 2 chars
          min_chars = 0, -- NOTE: always show my notes
          -- Where to put new notes created from completion. Valid options are
          --  * "current_dir" - put new notes in same directory as the current buffer.
          --  * "notes_subdir" - put new notes in the default notes subdirectory.
          new_notes_location = "current_dir",

          -- Whether to add the output of the node_id_func to new notes in autocompletion.
          -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
          prepend_note_id = true,
        },
      }
    end,
  },

  -- TODO:account for git
  --     SEE: https://www.reddit.com/r/neovim/comments/163wylw/how_to_use_nvimfundo/
  -- NOTE: works really nice but doesn't upate mbbill/undotree save indicator,
  --    this is only visual, doesnt' affect functionallity
  {
    "kevinhwang91/nvim-fundo",
    requires = "kevinhwang91/promise-async",
    build = function()
      require("fundo").install()
    end,
    config = function()
      require("fundo").setup()
    end,
  },

  -- kshenoy/vim-signature alternative written in lua
  -- great plugin but Neovim shada implementation is buggy as hell
  -- and marks can't be deleted properly. This is not this plugin fault
  -- TODO: start using it when shada bugs are fixed.
  -- SEE `h: shada`
  -- use {
  --   "chentau/marks.nvim",
  --   config = function()
  --     require("marks").setup {
  --       -- whether to map keybindings or not. default true
  --       default_mappings = true,
  --
  --       -- which builtin marks to show. default {}
  --       -- builtin_marks = { ".", "<", ">", "^" },
  --       builtin_marks = {},
  --
  --       -- whether movements cycle back to the beginning/end of buffer. default true
  --       cyclic = true,
  --
  --       -- whether the shada file is updated after modifying uppercase marks. default false
  --       -- SEE: https://github.com/chentau/marks.nvim/issues/15
  --       force_write_shada = false,
  --       -- how often (in ms) to redraw signs/recompute mark positions.
  --       -- higher values will have better performance but may cause visual lag,
  --       -- while lower values may cause performance penalties. default 150.
  --       -- PERF: can be a performance problem, test it
  --       refresh_interval = 150,
  --
  --       -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  --       -- marks, and bookmarks.
  --       -- can be either a table with all/none of the keys, or a single number, in which case
  --       -- the priority applies to all marks.
  --       -- default 10.
  --       sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  --       excluded_filetypes = {},
  --       -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  --       -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  --       -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  --       -- default virt_text is "".
  --       bookmark_0 = {
  --         sign = "⚑",
  --         virt_text = "hello world",
  --       },
  --       bookmark_1 = {
  --         sign = "⚑",
  --         virt_text = "hello world",
  --       },
  --       mappings = {},
  --     }
  --   end,
  -- }
}, {
  defaults = {
    lazy = false, -- should plugins be lazy-loaded?
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
  performance = {
    rtp = {
      paths = {
        vim.fn.stdpath "config" .. "/scratch",
      },
    },
  },
})
