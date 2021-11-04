# Tested & Deprecated plugins

## vim-commentary

Deprecate in favor of Comment.nvim

```lua
-- comment stuff out based on commentstring
-- use "tpope/vim-commentary"
```

## rose-pine

```lua
  use "rose-pine/neovim"
```

## tokyonight

```lua
  -- Tokyonight color theme
 use "folke/tokyonight.nvim"
```

## atom-one

    -- -- atom one
    -- use "Th3Whit3Wolf/one-nvim"

## ayu theme

    -- use "Luxed/ayu-vim" -- ayu-theme/ayu-vim hard fork
    -- use {
    --   "Shatur/neovim-ayu",
    --   config = function()
    --     require("ayu").setup {
    --       mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
    --       overrides = {}, -- A dictionary with a group names associated with a dictionary with parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
    --     }
    --   end,
    -- }

## Gruvbox theme

    -- use "gruvbox-community/gruvbox"

## emmet-vim

Deprecated because I'm using [emmet language server](https://github.com/aca/emmet-ls) instead

```
-- emmet completion for vim
-- use "mattn/emmet-vim" -- vim script plugin

```

## move-less

TODO: include description of the plugin

```
use "anschnapp/move-less"
```

## Tokyonight theme

    -- Tokyonight color theme
    -- use "folke/tokyonight.nvim"

## CmdlineComplete

    ```
    -- CmdlineComplete:
    -- COMMAND mode tab like completion from words in the current file
    -- See: https://github.com/vim-scripts/CmdlineComplete
    -- See: http://www.vim.org/scripts/script.php?script_id=2222
    -- use "vim-scripts/CmdlineComplete" -- vim script plugin
    ```

## Dashboard nvim

    ```
      use {
          "glepnir/dashboard-nvim",
          config = function()
              vim.g.dashboard_default_executive = 'telescope'
          end
      }
    ```

## Quick Scope

Lightning fast left-right movement with 'f' ,'F', 't', 'T'
Deprecated in favor of clever-f

    ```lua
    -- use {
    --   "unblevable/quick-scope",
    --   config = function()
    --     require "plugins.settings.quick-scope"
    --   end,
    -- }
    ```

## spellsitter

Treesitter powered spellchecker

Deprecated because it's buggy in javascript files.

    ```lua
    -- Treesitter powered spellchecker
    -- TODO: make it work
    use {
        'lewis6991/spellsitter.nvim',
        config = function()
            require('spellsitter').setup {
              hl = 'SpellBad',
              captures = {'comment'},  -- set to {} to spellcheck everything
            }
        end
    }
    ```

## vim-colortuner

Deprecated because it I didn't use it often.

```lua
  -- Adjust vim colors using sliders
  use {
      "zefei/vim-colortuner",
      config = function() require("plugins.settings.colortuner") end,
  }
```

## crease.vim

Easy foldtext customization for [neo]vim.

```lua
-- use "scr1pt0r/crease.vim"
```

## vim-signature

Plugin to toggle, display and navigate marks

```lua
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
```

## Vim-lion

A simple alignment operator for Vim text editor

```lua
  use "tommcdo/vim-lion"
```

## Vimade

An eye friendly plugin that fades your inactive buffers and preserves your syntax highlighting!

```lua
  use "TaDaa/vimade"
```

## Sniprun

Run lines/blocks of code independently of the rest of the file. Supports multiples languages

Deprecated because I didn't use it very much.

````lua
  use {
      "michaelb/sniprun", -- lua plugin
      -- macOS MUST have the Rust toolchain
      -- to build and install the plugin
      run = "bash ./install.sh",
      -- cmd = {'SnipRun', 'SnipInfo'},
      config = function() require("plugins.sniprun") end
  }
  ```

## Nvim-compe

Auto completion Lua plugin for nvim.
Deprecated because coq_nvim is faster

## Nvim-autopairs

Deprecated because I've found it to be more annoying than helpful.

- Installation / configuration

``` lua
use {
    "windwp/nvim-autopairs", -- lua
    config = function() require("plugins.autopairs") end,
}
````

## CoC.nvim

Language server protocol adapter
Deprecated in favor of Neovim native language server protocol integration.

- Installation / configuration

  ```lua
  -- Use coc release branch (recommend)
  use {
      "neoclide/coc.nvim",
      branch = "release"
  }
  ```

## Clever-f

Deprecated because long motions are better handed by a plugin like hop.nvim

- Installation / configuration

  ```lua
  use "rhysd/clever-f.vim"
  ```

## EasyMotion

Deprecated in favor of hop.nvim

- Installation / configuration

  ```lua
  use "easymotion/vim-easymotion"  -- VimL

  ```

## vim-signify

Deprecated because it was the slowest git gutter plugin I've tested.

- Installation / configuration

  ```lua
  use "mhinz/vim-signify"
  ```

## vim-gitgutter

Shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.

Has integration with kshenoy/vim-signature.

Vim-gitgutter is slower than gitsigns.nvim and has poorer git hunk integration when compared to it.

- Installation / configuration

  ```lua
  use "airblade/vim-gitgutter"
  ```

## Ultisnips

Slow on neovim (neovim only problem). Snippets are separated from the engine:

- Installation / configuration

  ```lua
  use "SirVer/ultisnips" -- VimL
  ```

## vim-snippets (ultisnips companion)

Ultisnips companion

- Installation / configuration

  ```lua
  use "honza/vim-snippets" -- VimL
  ```

## nvim-bufferline

Buffer line with minimal tab integration, inspired by emacs centaur tabs plugin.

It lags when switching between buffers. Replaced by barbar.nvim, which is similar but worked better.

```lua
use {
    "akinsho/nvim-bufferline.lua", -- lua
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
        require('bufferline').setup{}
    end
}
```

## zen-mode

Distraction-free writing in Vim. Deprecated in favor of `folke/zen-mode.nvim`.

- Installation / configuration

  ```lua
  use "junegunn/goyo.vim"
  ```

## lexima.vim

Deprecated because I've found it to be more annoying than helpful.
Auto close parentheses and repeat by dot dot dot...

- Installation / configuration

  ```lua
  use 'cohama/lexima.vim' -- VimL
  ```

## vim-sneak

Jump to any location specified by two characters.

Deprecated in favor of hop.nvim which has similar functionality.

```lua
use {
    "justinmk/vim-sneak", -- VimL
    config = function()
        vim.g["sneak#label"] = 1  -- similar behavior to easymotion
    end
}
```

## vim-lineletters

Go to lines by typing corresponding letters. Deprecated in favor of hop.nvim.

- Installation / configuration

  ```lua
  use "skamsie/vim-lineletters"
  ```

## vim-startify

This plugin provides a start screen for Vim and Neovim. Deprecated in favor of dashboard-nvim.

- Installation / configuration

  ```lua
  use "mhinz/vim-startify" -- VimL
  ```

## ALE

Deprecated in favor of efm-langserver which is used in conjunction with nvim-lspconfig.

- Installation / configuration

  ```lua
  use "dense-analysis/ale"
  ```

## presence.nvim

Show Neovim status on Discord.

- Installation / configuration

  ```lua
  use "andweeb/presence.nvim"

  ```

## context.vim

Extremely slow on nvim, but could be useful to inspect a huge codebase.

Seems to interfere with other plugins or maybe it was a problem
with packer handling the plugin installation.

- Installation / configuration

  ```lua
  use "wellle/context.vim"
  ```

## vim-matchup

-- highlight, navigate, and operate on sets of matching text.
-- It extends vim's % key to language-specific words instead of just single characters.
-- NOTE: Can slow down neovim on weak pcs
-- TODO: configure colors and font for vim-matchup
-- use "andymass/vim-matchup"

Slow on nvim due to a Neovim core bug.

-- TODO: confirm

- See: https://github.com/andymass/vim-matchup/issues/100
- See: https://github.com/neovim/neovim/issues/12587

which is unfortunate because matchup provides great functionality.

vim-illuminate is being used instead.

- Installation / configuration

  ```lua
  use "andymass/vim-matchup"
  ```

## vim-move

Move lines and selections up and down using alt + h, j, k, l

- Installation / configuration

  ```lua
  use "matze/vim-move" -- vim script plugin
  ```

## ack.vim

Vim plugin for the Perl module / CLI script 'ack'

Run your favorite search tool from Vim, with an enhanced results list.

- Installation / configuration

  ```lua
  use {
      "mileszs/ack.vim",
      config = function()
          vim.g.ackprg = "rg --vimgrep --no-heading --hidden --smart-case"
      end
  }
  ```

  ```

  ```

  ```

  ```
