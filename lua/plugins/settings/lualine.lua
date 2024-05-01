-- TODO: see https://www.reddit.com/r/neovim/comments/u2uc4p/your_lualine_custom_features/
local lualine = require "lualine"

lualine.setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      { "FugitiveHead", icon = "" },
    },
    lualine_b = {
      "diff",
      "diagnostics",
    },
    lualine_c = {
      -- TODO: enhance filename display
      -- SEE: https://vi.stackexchange.com/questions/15046/get-directory-name-from-cwd-dirname-without-preceding-path
      -- display as {cwd_dirname_without_path}/{file_path_relative_to_cwd}
      {
        "filename",
        file_status = true, -- Displays file status (readonly status, modified status)
        path = 1, -- 0: Just the filename
        -- 1: Relative path
        -- 2: Absolute path

        shorting_target = 20, -- Shortens path to leave 40 spaces in the window
        symbols = {
          modified = "[+]", -- Text to show when the file is modified.
          readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
          unnamed = "[No Name]", -- Text to show for unnamed buffers.
        },
      },
      "searchcount",
    },
  },
  extensions = { "quickfix", "fugitive" },
}
