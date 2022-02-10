-- TODO: test telescope worktree integration

local patterns_to_ignore = {
  "node_modules", -- js and ts dev in general
  "resources/_gen", -- gohugo dev
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
  extensions = {
    -- telescope-fzf-native.nvim
    fzf = { -- These are the default options
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension "fzf"
