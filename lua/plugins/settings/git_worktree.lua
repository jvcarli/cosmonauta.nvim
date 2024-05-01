local gw = require "git-worktree"
local Job = require "plenary.job"
local kitty_desktop_notify = require("user.modules.utils").kitty_send_desktop_notification
local util = require "lspconfig.util"
local current_path = vim.fn.getcwd()
local bare_git_root_dir = require("user.modules.utils").bare_git_root_dir

-- load telescope extension
require("telescope").load_extension "git_worktree"

local root_has_pattern = function(fname, pattern)
  return util.root_pattern(pattern)(fname)
end

gw.setup {

  -- SEE: https://github.com/ThePrimeagen/git-worktree.nvim#options
  change_directory_command = "cd", -- <str> | default: "cd"
  update_on_change = true, -- <boolean> | default: true,
  update_on_change_command = "e .", -- <str> | default: "e .",
  clearjumps_on_change = true, -- <boolean> | default: true,
  autopush = false, -- <boolean> | default: false,
}

-- op = Operations.Switch, Operations.Create, Operations.Delete
-- metadata = table of useful values (structure dependent on op)
--      Switch
--          path = path you switched to
--          prev_path = previous worktree path
--      Create
--          path = path where worktree created
--          branch = branch name
--          upstream = upstream remote name
--      Delete
--          path = path where worktree deleted
--
-- TODO: explore `kitty_desktop_notify` more, it can be useful as on_tree_change post hook
--       and as a plenary Job on_stdout, on_stderr or on_exit
-- SEE: https://www.reddit.com/r/neovim/comments/ulx17m/using_nvim_buf_set_text_without_running_into/
-- WARN: currently desktop notification is implement only for Kitty
--       It won't work with Tmux because Tmux can't handle the escape codes that Kitty emits for desktop
--       notifications
gw.on_tree_change(function(op, metadata)
  if op == gw.Operations.Switch then
    local prev_path = metadata.prev_path:gsub(os.getenv "HOME", "~")
    local path = metadata.path:gsub(os.getenv "HOME", "~")

    print("cd: from " .. prev_path .. " to " .. path)
  end

  if op == gw.Operations.Create then
    -- Find .gitmodules files, if it exists it means that the project uses git submodules,
    -- so we must update it to import the submodules, otherwise builds can fail, tests won't run, etc.
    if root_has_pattern(metadata.path, ".gitmodules") ~= nil then
      Job:new({
        command = "git",
        args = { "submodule", "update", "--init" }, -- TODO: is it always necessary when it has a custom location on .gitmodules
        cwd = metadata.path,
        on_exit = function()
          vim.schedule(function()
            kitty_desktop_notify("Git Worktrees", "Git submodules are initialized and updated!")
          end)
        end,
      }):start()
    end

    if root_has_pattern(metadata.path, "package-lock.json") ~= nil then
      -- TODO: guard pkg_name because it can be nil if package.json file doesn't exist!
      local pkg_name = vim.fn.json_decode(vim.fn.readfile(metadata.path .. "/package.json")).name
      -- We are in a npm managed js package
      Job:new({
        command = "npm",
        args = { "install" },
        cwd = metadata.path,
        on_exit = function()
          vim.schedule(function()
            kitty_desktop_notify(pkg_name, "Npm install is done!\nnode_modules directory is ready!")
          end)
        end,
      }):start()
    end

    if root_has_pattern(metadata.path, "yarn.lock") ~= nil then
      -- TODO: guard pkg_name because it can be nil if package.json file doesn't exist!
      local pkg_name = vim.fn.json_decode(vim.fn.readfile(metadata.path .. "/package.json")).name
      -- We are in a Yarn managed js package
      Job:new({
        command = "yarn",
        args = { "install" },
        cwd = metadata.path,
        on_exit = function()
          vim.schedule(function()
            -- TODO: call package name by reading package.json file
            kitty_desktop_notify(pkg_name, "Yarn install is done!\nnode_modules directory is ready!")
          end)
        end,
      }):start()
    end

    -- TODO: if python project then use plenary Job to create virtualenvs based on
    -- the python package manager, e.g.: pip, pipenv, poetry
    -- This one involves more work
  end
end)

-- SEE: https://www.reddit.com/r/neovim/comments/xjbzts/is_there_a_way_to_partially_keymap_a_command_and/
-- NOTE: See nargs options too.
--   vim.api.nvim_add_user_command("WorktreeAdd", function(opts)
--     require("git-worktree").create_worktree(opts.args, "development", "origin")
--   end, { nargs = 1 })
--
-- WARN: this doesn't deal with git remotes yet!
local git_worktrees_input_info = function()
  local worktree_path
  local worktree_branch_name
  vim.ui.input({ prompt = "Worktree directory name: " }, function(input)
    worktree_path = input
  end)
  vim.ui.input({ prompt = "Worktree branch name: ", default = worktree_path }, function(input)
    worktree_branch_name = input
  end)

  -- SEE: https://stackoverflow.com/questions/11271547/does-lua-have-or-comparisons
  -- if worktree_path or worktree_branch_name == nil then
  --   vim.notify "Aborting new worktree creation!"
  --   do
  --     return
  --   end
  -- end

  local worktrees_root_dir = bare_git_root_dir(current_path) .. "/worktrees/"
  local new_worktree_dir = worktrees_root_dir .. worktree_path
  return require("git-worktree").create_worktree(new_worktree_dir, worktree_branch_name)
end

vim.keymap.set("n", "<leader>cw", function()
  git_worktrees_input_info()
end, { desc = "Worktrees I love you" })

vim.keymap.set("n", ",g", require("telescope").extensions.git_worktree.git_worktrees)

-- SEE: https://www.reddit.com/r/neovim/comments/tjb91g/whats_the_correct_way_to_open_file_using_lua/
-- SEE: https://stackoverflow.com/questions/41545293/branch-is-already-checked-out-at-other-location-in-git-worktrees
-- SEE: https://stackoverflow.com/questions/3336995/git-will-not-init-sync-update-new-submodules
