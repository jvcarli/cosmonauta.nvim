# Deprecated plugins

Each plugin has a **description** of why I thought it was a good solution for a problem I've have/had and the **reason** of deprecation.
They are organized alphabetically by `<author>/<plugin-name>`.

## [4513ECHO/vim-readme-viewer](https://github.com/4513ECHO/vim-readme-viewer)

**Reason**: [nvim-telescope/telescope-packer.nvim](https://github.com/nvim-telescope/telescope-packer.nvim) does the same thing,
but it's better because you can fuzzy find the search

```lua
use {
  "4513ECHO/vim-readme-viewer",
  opt = true,
  cmd = "PackerReadme",
  config = function()
    vim.g["readme_viewer#plugin_manager"] = "packer.nvim"
  end,
}
```

## [ahmedkhalf/project.nvim](https://github.com/ahmedkhalf/project.nvim)

```lua
-- Project management, basically an airblade/vim-rooter plugin clone
-- NOTE: to many cases for wanting to change root, is better to use
--       something like nvim-telescope/telescope-project.nvim to manually define the projects
--       and change directory base on your needs using mappings or better,
--       to define a function that loads on VimEnter only to go into the project root
--       and after DOING NOTHING to disturb the working directory,
--       letting me changing everything manually.
use {
  "ahmedkhalf/project.nvim",
  config = get_config "project-nvim",
}
```

## [airblade/vim-gitgutter](https://github.com/airblade/vim-gitgutter)

Shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.

Has integration with kshenoy/vim-signature.

Vim-gitgutter is slower than gitsigns.nvim and has poorer git hunk integration when compared to it.

```lua
use "airblade/vim-gitgutter"
```

## [airblade/vim-highline](https://github.com/airblade/vim-highline)

works only on vim :(

```lua
use "airblade/vim-highline"
```

## [airblade/vim-rooter](https://github.com/airblade/vim-rooter)

```lua
use {
  "airblade/vim-rooter",
  config = function()
    -- by default vim-rooter uses cd to change the directory
    -- lcd only sets the current directory for the current window.
    -- The current directory for other
    -- windows or tabs is not changed.
    vim.g.rooter_cd_cmd = "lcd"
    -- vim.g.rooter_patterns = { ".bare" }
  end,
}
```

## [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)

Buffer line with minimal tab integration, inspired by emacs centaur tabs plugin.

It lags when switching between buffers. Replaced by barbar.nvim, which is similar but worked better.

**Reason**: I still don't get the appeal for bufferlines.

```lua
use {
  "akinsho/bufferline.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("bufferline").setup {
      options = {
        mode = "tabs",
      },
    }
  end,
}
```

## [alvarosevilla95/luatab.nvim](https://github.com/alvarosevilla95/luatab.nvim)

```lua
use {
  "alvarosevilla95/luatab.nvim",
  config = function()
    require("luatab").setup {}
  end,
}
```

## [AndrewRadev/switch.vim](https://github.com/AndrewRadev/switch.vim)

**Reason**: replaced by dial.nvim

```lua
use {
  "AndrewRadev/switch.vim",
  config = function()
    vim.g.speeddating_no_mappings = 1 -- Disable default mappings for tpope's speedating
    vim.g.switch_mapping = "" -- Disable default switch.vim `gs` mapping
  end,
}
```

## [andweeb/presence.nvim](https://github.com/andweeb/presence.nvim)

Show Neovim status on Discord.

```lua
use "andweeb/presence.nvim"

```

## [andymass/vim-matchup](https://github.com/andymass/vim-matchup)

highlight, navigate, and operate on sets of matching text.
It extends vim's % key to language-specific words instead of just single characters.
NOTE: Can slow down neovim on weak pcs
TODO: configure colors and font for vim-matchup

Slow on nvim due to a Neovim core bug.

-- TODO: confirm

- SEE: https://github.com/andymass/vim-matchup/issues/100
- SEE: https://github.com/neovim/neovim/issues/12587

which is unfortunate because matchup provides great functionality.

Using vim-illuminate instead

```lua
-- WARN: endended up not using it because it slows things down a lot
-- highlight, navigate, and operate on sets of matching text.
-- It extends vim's % key to () language-specific words instead of just single characters.
-- NOTE: Can slow down neovim on weak pcs
--       and when using g:matchup_matchparen_hi_surround_always = 1 (noticed only on comments)
use {
  "andymass/vim-matchup",
  setup = function()
    -- Deferred highlighting improves cursor movement performance
    -- by delaying highlighting for a short time and waiting to see if
    -- the cursor continues moving.
    -- Using it to improve performance and because
    -- g:matchup_matchparen_deferred_show_delay requires it
    -- vim.g.matchup_matchparen_deferred = 1 -- default 0 (disabled)

    -- how time to wait before displaying matchup highlights
    -- using the same amount of delay as vim-illuminate (200ms)
    -- vim.g.matchup_matchparen_deferred_show_delay = 300 -- default 50
    --                                                    400 works fine

    -- always show highligths
    -- It is updated each time the cursor moves.
    -- This requires deferred matching (g:matchup_matchparen_deferred = 1)
    -- Can cause horrific slowness on comments
    -- vim.g.matchup_matchparen_hi_surround_always = 1

    -- This option controls whether matching is done within strings and comments.
    -- If set to 2, nothing will be matched within strings and comments.
    -- BUG: if g:matchup_matchparen_hi_surround_always = 1
    --      paren and brackets highlights will still appear but they shouldn't
    -- TODO: report it to upstream
    -- vim.g.matchup_delim_noskips = 2

    vim.g.matchup_transmute_enabled = 0 -- TODO: test IT!!, default is 0, seems to be buggy

    -- WARN: testing using no popup
    vim.g.matchup_matchparen_offscreen = { "" }
    --vim.g.matchup_matchparen_offscreen = {
    --  method = "status_manual",
    --  fullwidth = 1,
    --  -- highlight = "OffscreenPopup",
    --  -- blends matchup highlight bg with current colorscheme bg,
    --  -- docs says that apply to vim only but it applies to Neovim too!
    --}
  end,
}

```

## [anschnapp/move-less](https://github.com/anschnapp/move-less)

TODO: include description of the plugin

```
use "anschnapp/move-less"
```

## [cohama/lexima.vim](https://github.com/cohama/lexima.vim)

Deprecated because I've found it to be more annoying than helpful.
Auto close parentheses and repeat by dot dot dot...

```lua
use "cohama/lexima.vim" -- VimL
```

## [dense-analysis/ale](https://github.com/dense-analysis/ale)

Deprecated in favor of efm-langserver which is used in conjunction with nvim-lspconfig.

```lua
use "dense-analysis/ale"
```

## [dhruvasagar/vim-buffer-history](https://github.com/https://github.com/dhruvasagar/vim-buffer-history)

```lua
use "dhruvasagar/vim-buffer-history"
```

## [drzel/vim-scrolloff-fraction](https://github.com/drzel/vim-scrolloff-fraction)

```lua
-- replaced by vim default scroll commands
-- set scrolloff as a fraction of window height
use {
  "drzel/vim-scrolloff-fraction",
  config = function()
    vim.g.scrolloff_fraction = 0.15 -- 25% of active window height (default)
  end,
}
```

## [easymotion/vim-easymotion](https://github.com/easymotion/vim-easymotion)

Deprecated in favor of hop.nvim

```lua
use "easymotion/vim-easymotion" -- VimL

```

## [elihunter173/dirbuf.nvim](https://github.com/elihunter173/dirbuf.nvim)

```lua
-- SEE: nested directories creation: https://github.com/elihunter173/dirbuf.nvim/issues/3
use "elihunter173/dirbuf.nvim"
```

## [f3fora/cmp-spell](https://github.com/f3fora/cmp-spell)

```lua
use "f3fora/cmp-spell"
```

## [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)

```lua
use "folke/tokyonight.nvim"
```

## [ggandor/lightspeed.nvim](https://github.com/ggandor/lightspeed.nvim)

```lua
-- in favor of using leap.nvim (from the same author)
-- substitutes: easymotion, vim-sneak, vim-line-letters, hop.nvim
use "ggandor/lightspeed.nvim"
```

## [michaelb/sniprun](https://github.com/michaelb/sniprun)

Run lines/blocks of code (independently of the rest of the file),
supporting multiples languages.
Deprecated because I wasn't using it.

<!-- TODO: try it one more time -->

```lua
use {
  "michaelb/sniprun",
  config = function()
    require("sniprun").setup {

      repl_enable = { "Python3_fifo" }, --" enable REPL-like behavior for the given interpreters
      display = { "TerminalWithCode" },
    }
  end,
  run = "bash ./install.sh",
}
```

## [tommcdo/vim-ninja-feet](https://github.com/tommcdo/vim-ninja-feet)

Operations and jumping (when in insert mode) from the cursor to the beginning or end of a text object.
Deprecated because it feels unnatural to think in ninja motions.

```lua
use "tommcdo/vim-ninja-feet"
```
