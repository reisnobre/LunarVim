local M = {}

M.config = function()
  lvim.builtin.mini_surround = {
    active = true,
    on_config_done = nil,
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    }
  }
end

function M.setup()
  local status_ok, mini_surround = pcall(require, "mini.surround")
  if not status_ok then
    return
  end

  local which_key = require "which-key"

  local keys = {
    mode = { "n" },
    { "gs", group = "Surround" },
  }

  which_key.add(keys)

  mini_surround.setup(lvim.builtin.mini_surround.opts)

  if lvim.builtin.mini_surround.on_config_done then
    lvim.builtin.mini_surround.on_config_done(mini_surround)
  end
end


return M
