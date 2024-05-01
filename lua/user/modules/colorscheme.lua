local M = {}

local neovim_synced_theme = vim.fn.expand(vim.env.HOME .. "/.config/kitty/neovim-synced-theme")
local current_colorscheme = vim.fn.readfile(neovim_synced_theme)[1]

M.set_colorscheme = function(name)
  -- this function is the only way we should be setting our colorscheme
  -- taken from: https://rrethy.github.io/book/colorscheme.html
  --             https://github.com/RRethy/dotfiles/blob/master/nvim/init.lua

  -- theme file, the single source of truth

  -- write our colorscheme back to our single source of truth
  vim.fn.writefile({ name }, neovim_synced_theme)

  -- TODO: this is hardcoded, do the proper logic
  vim.cmd "set background=light"

  -- set Neovim's colorscheme
  vim.cmd("colorscheme " .. name)

  -- execute `kitty @ set-colors -c <color>` to change terminal window's
  -- colors and newly created terminal windows colors
  vim.loop.spawn("kitty", {
    args = {
      "@",
      "set-colors",
      "-c",
      string.format(vim.env.HOME .. "/.config/kitty/themes/%s.conf", name),
    },
  }, nil)
end

M.telescope_color_picker = function()
  -- colorschemes names
  -- TODO: make it so it can be configurable, default to 1.
  -- options:
  --   1. user installed colors (user installed colorschemes + exclude /usr/share/nvim/runtime/colors/*)
  --   2. all (include all colors )
  --   3. table (lua table with color names, MUST be valid `:colorscheme`)

  local colors = { "zenbones", "catppuccin" }

  -- TODO: sort table function

  -- we're trying to mimic VSCode so we'll use dropdown theme
  local theme = require("telescope.themes").get_dropdown()

  -- telescope utils
  local telescope_actions = require "telescope.actions"
  local telescope_action_set = require "telescope.actions.set"
  local telescope_finders = require "telescope.finders"
  local action_state = require "telescope.actions.state"
  local telescope_pickers = require "telescope.pickers"
  local telescope_config = require "telescope.config"

  -- create our telescope picker
  telescope_pickers
    .new(theme, {
      prompt = "Change Your Colorscheme",
      finder = telescope_finders.new_table {
        results = colors,
      },
      sorter = telescope_config.values.generic_sorter(theme),
      attach_mappings = function(bufnr)
        -- change the colors upon selection
        telescope_actions.select_default:replace(function()
          M.set_colorscheme(action_state.get_selected_entry().value)
          telescope_actions.close(bufnr)
        end)
        telescope_action_set.shift_selection:enhance {
          -- change the colors upon scrolling
          post = function()
            M.set_colorscheme(action_state.get_selected_entry().value)
          end,
        }
        return true
      end,
    })
    :find()
end

M.set_colorscheme(current_colorscheme)

return M
