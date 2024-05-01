-- load Telescope extension
require("telescope").load_extension "projects"

-- project_nvim
require("project_nvim").setup {
  -- Manual mode doesn't automatically change your root directory, so you have
  -- the option to manually do so using `:ProjectRoot` command.
  manual_mode = false,

  -- Methods of detecting the root directory. **"lsp"** uses the native neovim
  -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
  -- order matters: if one is not detected, the other is used as fallback. You
  -- can also delete or rearangne the detection methods.
  detection_methods = {
    -- "lsp",
    "pattern",
  },

  -- All the patterns used to detect root dir, when **"pattern"** is in
  -- detection_methods
  -- for understading how to define patterns:

  -- The reason !=.git/worktrees doesn't work is that
  -- = compares a directory name rather than a path or glob.
  -- NOTE: i think this is true for ^ and > too.
  --       SEE: https://github.com/airblade/vim-rooter/issues/110
  patterns = {
    -- SEE: https://github.com/airblade/vim-rooter/pull/101
    --
    -- BUG: This works but I stopped using it because it interfere with git-worktrees.nvim plugin
    -- "!^branches", -- ignore everything BELOW branches directory (that is: inside it)
    "!^worktrees", -- ignore everything BELOW worktrees directory (that is: inside it)
    -- "!^_resources", -- ignore everything BELOW _resources directory (that is: inside it)

    --            "!^*.git", -- DOESN'T WORK!!
    --            I think this is related to the note above
    --            TODO: make similar logic work: ignore every directory that starts with branch-*
    --            I want to ignore any git dir inside: <project>.git/ dir
    --            That way my git bare directory organization when using worktrees could be:
    --
    --
    --            <project>.git (Root project)            <project>.git (Root project)
    --            ├── .bare/                                ├── .bare
    --            ├── .git                                  ├── .git
    --            ├── branch-dev-feat1/                     ├── branches
    --            │   └── .git                              │   └── dev-feat-1/
    --            │   └── ...                               │       └── .git
    --            ├── branch-hot-fix/        INSTEAD OF     │       └── ...
    --            │   └── .git                              │   └── dev-hot-fix/
    --            │   └── ...                               │       └── .git
    --            └── resources                             │       └── ...
    --                └── foo.txt                           └── resources
    --                └── foo.jpg                               └── foo.txt
    --                                                          └── foo.jpg
    --
    --            NOTE: only the root project is managed by project.nvim!
    --                  Other .git repos inside it don't get tracked so
    --                  we don't have false projects distrubing the telescope picker.
    --                  TODO: Both ways have its value and I want be able to choose between them!

    -- for non bare git worktrees:
    -- "!.git/worktrees",

    -- TODO: make similar logic to work
    -- "!Exploring/**", -- Use project.nvim only for MY projects! (work and personal)
    --               TODO: for other types manage it differently (maybe using telescope-project.nvim)
    --                     or a custom telescope picker.

    ".git",
    "_darcs",
    ".hg",
    ".bzr",
    ".svn",
  },

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

  -- What scope to change the directory, valid options are
  -- * global (default)
  -- * tab
  -- * win
  scope_chdir = "win",

  -- Path where project.nvim will store the project history for use in
  -- telescope
  datapath = vim.fn.stdpath "data",
}
