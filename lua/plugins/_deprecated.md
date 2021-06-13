# Tested & Deprecated plugins

## Nvim-autopairs

Deprecated because I've found it to be more annoying than helpful.

- Installation / configuration

  ``` lua
  use {
      "windwp/nvim-autopairs", -- lua
      config = function() require("plugins.autopairs") end,
  }
  ```

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

Slow on neovim (neovim only problem). Snippets are separeted from the engine:

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

Distraction-free writting in Vim. Deprecated in favor of `folke/zen-mode.nvim`.

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

  ``` lua
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

## vim-smoothie

UI goodie, I've found it to be unnecessary.

- Installation / configuration

  ```lua
  use "psliwka/vim-smoothie"
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

Slow on nvim due to a Neovim core bug.

- See: https://github.com/andymass/vim-matchup/issues/100
- See: https://github.com/neovim/neovim/issues/12587

which is unfortunate because matchup provides great functionality.

vim-illuminate is being used instead.

- Installation / configuration

  ```lua
  use "andymass/vim-matchup"
  ```
