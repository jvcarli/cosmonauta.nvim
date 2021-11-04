-- TODO: configure it

local wk = require "which-key"

wk.setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

-- names for the mappings defined in keymaps.lua
-- even thought is possible DO NOT define mappings here
wk.register {
  -- vim-caser
  ["gsc"] = { name = "Choose Word Casing" },

  -- telescope
  ["<leader>s"] = { name = "Telescope" },
  ["<leader><space>"] = { name = "Find Opened Buffers" },
  ["<leader>sf"] = { name = "Find File" },
  ["<leader>sF"] = { name = "File Browser" },
  ["<leader>sb"] = { name = "Fuzzy Find Current Buffer" },
  ["<leader>sh"] = { name = "Find All Help Tags" },
  ["<leader>st"] = { name = "Find All Tags" },
  ["<leader>sw"] = { name = "Grep String" },
  ["<leader>sg"] = { name = "Live Grep" },
  ["<leader>so"] = { name = "Find Current Buffer Tags" },
  ["<leader>sp"] = { name = "Find Project" },
  ["<leader>?"] = { name = "Find Old Files" },

  -- NvimTree
  ["<leader>n"] = { name = "NvimTree Toggle" },

  -- Git
  ["<leader>g"] = { name = "Git" },
  ["<leader>gm"] = { name = "Reveal Commit message" }, -- git messenger

  -- Zzzzzzzzzz
  ["<leader>zm"] = { name = "Zen Mode" }, -- zen-mode.nvim
}

-- TODO: what is this for?
-- wk.register({
--   f = {
--     name = "file", -- optional group name
--     f = { "<cmd>Telescope find_files<cr>", "Fifafand File" }, -- create a binding with label
--                     },
--   }, { prefix = "<leader>" },
--     {
--   mode = "n", -- NORMAL mode
--   -- prefix: use "<leader>f" for example for mapping everything related to finding files
--   -- the prefix is prepended to every mapping part of `mappings`
--   prefix = "",
--   buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = false, -- use `nowait` when creating keymaps
-- })
