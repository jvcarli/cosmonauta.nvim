-- SEE: https://www.reddit.com/r/neovim/comments/uq5ldw/how_do_i_convert_my_old_filetype_vimscript_to_the/

-- Is not usual but sometimes it happens
vim.filetype.add({
  pattern = {
    [".-/requirements/.-%.txt$"] = "requirements",
  },
})
