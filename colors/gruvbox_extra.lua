local gruvbox_status_ok = pcall(require, "gruvbox")

if not gruvbox_status_ok then
  vim.print("Gruvbox plugin is not installed yet!")
  return
else
  -- Setup Gruvbox preferences and extra highlight groups

  -- Gruvbox preferences
  require("gruvbox").setup({
    undercurl = true,
    underline = true,
    bold = true,
    -- italic = true,
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {
      SignColumn = { bg = "#282828" },
      CursorLineNr = {
        bg = "#282828",
        bold = true,
      },
      GitSignsDelete = { fg = "#fb4934", bg = "#282828" },
      GitSignsChange = { fg = "#8ec07c", bg = "#282828" },
      GitSignsAdd = { fg = "#b8bb26", bg = "#282828" },
    },
    dim_inactive = false,
    transparent_mode = false,
  })

  vim.cmd("set background=dark")
  vim.cmd("runtime colors/gruvbox.lua") -- necessary!

  -- Clear annoying todo highlights on non treesitter highlighted files, see: `:help highlights`
  -- SEE: taken from https://vi.stackexchange.com/questions/14996/turn-off-syntax-hilighting-for-todo-items
  -- SEE: taken from https://www.reddit.com/r/neovim/comments/106ia0r/need_help_in_fixing_signcolumns_grey/
  -- This command should be executed before loading first color scheme to have effect on it.
  vim.cmd("autocmd ColorScheme * highlight clear Todo") -- It must come before linking!
  vim.cmd("autocmd ColorScheme * highlight link Todo Comment") -- usually Todo keywords are tied to comments!
end
