-- TODO: test telescope worktree integration

local themes = require("telescope").themes

-- Relevant PRs:
--     feat: Add ability to choose window to edit
--     SEE: https://github.com/nvim-telescope/telescope.nvim/pull/745

-- NOTE: some Telescope builtins RESPECTS .gitignore by default,
--       so in most cases setting this options shouldn't be needed.
--       Of course you can disable this if you want to.
local patterns_to_ignore = {
  -- "resources/_gen", -- TODO: is this line necessary? (hugo frontend framework)

  -- SEE: https://github.com/nvim-telescope/telescope.nvim/issues/1402
  ".git$", -- ignore .git FILE (submodules / worktrees)
  "%.git/", -- ignore .git DIRECTORY (and all its files),
  "%.bare/", -- bare repos stored under .bare directory

  "%.yarn/", -- .yarn directory (yarn berry)
  "%node_modules/",
}

require("telescope").setup {
  defaults = {
    mappings = {
      i = { -- 'i' for insert mode mappings
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
    file_ignore_patterns = patterns_to_ignore,
  },
  pickers = {
    find_files = {
      hidden = true, -- show hidden files
      sorting_strategy = "ascending",

      layout_strategy = "bottom_pane",
      layout_config = {
        height = 12,
      },

      border = true,
      borderchars = {
        prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
        results = { " " },
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
    },
    buffers = {
      sorting_strategy = "ascending",

      layout_strategy = "bottom_pane",
      layout_config = {
        -- TODO: set a custom function for height that displays the exact number of current opened buffers
        --       and limits it to a max value
        --       SEE: https://www.reddit.com/r/neovim/comments/q05oo8/getting_the_telescope_dialog_to_span_the_more_of/
        height = 10,
      },
      border = true,
      borderchars = {
        prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
        results = { " " },
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
      previewer = false,
    },
  },
  extensions = {
    -- telescope-fzf-native.nvim
    fzf = { -- These are the default options
      fuzzy = true, -- false will only do exact matching
      -- TODO: is there any reason for me to turning generic_sorter off???
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },

    -- BUG: this directories didn't exist in macOS, it was causing a bug, maybe do a check function
    -- project = {
    --   base_dirs = {
    --     { "~/Projects/Exploring", max_depth = 1 },
    --     { "~/Projects/Github/Personal/Original", max_depth = 1 },
    --   },
    --   hidden_files = false, -- default: false
    -- },
  },
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension "fzf"

-- custom pickers
-- TODO: make a custom picker for project references

local M = {}

function M.sourcegraph_find()
  require("telescope.builtin").find_files {
    prompt_title = "~ sourcegraph ~",
    shorten_path = false,
    cwd = "~/sourcegraph/",

    layout_strategy = "horizontal",
    layout_config = {
      width = 0.25,
      preview_width = 0.65,
    },
  }
end

return M
