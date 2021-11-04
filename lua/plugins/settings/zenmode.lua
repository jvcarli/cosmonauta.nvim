require("zen-mode").setup {
  window = {
    backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 95, -- width of the Zen window
    height = 0.90, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      signcolumn = "yes", -- disable signcolumn
      number = false, -- disable number column
      relativenumber = false, -- disable relative numbers
      cursorline = false, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = true }, -- disables the tmux statusline
    -- this will change the font size on kitty when in zen mode
    -- to make this work, you need to set the following kitty options:
    -- - allow_remote_control socket-only
    -- - listen_on unix:/tmp/kitty
    kitty = { -- increase kitty font size via socket
      enabled = false,
      font = "+2", -- font size increment
    },
  },

  -- callback where you can add custom code when the Zen window opens

  on_open = function(win)
    vim.cmd [[set nowrap]]
    -- vim.cmd [[MarksToggleSigns]]
    vim.cmd [[IndentBlanklineDisable]]
    if vim.bo.filetype == "python" then
      vim.cmd "setlocal colorcolumn="
    end
  end,

  -- callback where you can add custom code when the Zen window closes

  on_close = function()
    vim.cmd [[IndentBlanklineEnable]]
    -- vim.cmd [[MarksToggleSigns]]
    if vim.bo.filetype == "python" then
      vim.cmd "setlocal colorcolumn=80,89"
    end
  end,
}
