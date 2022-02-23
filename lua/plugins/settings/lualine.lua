local lualine = require "lualine"
-- local gps = require "nvim-gps"

lualine.setup {
  sections = {
    lualine_a = {},
    lualine_b = { "FugitiveHead", "diff", "diagnostics" },
    lualine_c = {
      {
        "filename",
        file_status = true, -- Displays file status (readonly status, modified status)
        path = 1, -- 0: Just the filename
        -- 1: Relative path
        -- 2: Absolute path

        shorting_target = 40, -- Shortens path to leave 40 spaces in the window
        symbols = {
          modified = "[+]", -- Text to show when the file is modified.
          readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
          unnamed = "[No Name]", -- Text to show for unnamed buffers.
        },
      },
      -- { gps.get_location, cond = gps.is_available }, -- it is not being particularly useful
    },
  },
  -- tabline = {
  --   lualine_a = {},
  --   -- lualine_c = { require("tabline").tabline_buffers },
  --   -- lualine_x = { require("tabline").tabline_tabs },
  --   lualine_y = {},
  --   lualine_z = {},
  -- },
  extensions = { "fugitive", "nvim-tree", "quickfix" },
}
