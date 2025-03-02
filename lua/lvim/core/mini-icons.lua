local M = {}

local icons = lvim.icons

M.get_icon = function(name, opts)
  category = opts.category or "filetype"
  color = opts.color or "blue"

  if icons[category] then
    if icons[category][name] then
      return {
        icon = icons[category][name],
        color = color,
      }
    end
  end

  local status_ok, mini_icons = pcall(require, "mini.icons")

  if not status_ok then
    return {
      icon = '?',
      color = color,
    }
  end

  return {
    icon = require("mini.icons").get(category, name),
    color = color,
  }
end

M.config = function()
  lvim.builtin.mini_icons = {
    active = true,
    on_config_done = nil,
    setup = {},
    opts = {}
  }

end

function M.setup()
  local status_ok, mini_icons = pcall(require, "mini.icons")
  if not status_ok then
    return
  end

  mini_icons.setup(lvim.builtin.mini_icons.opts)

  if lvim.builtin.mini_icons.on_config_done then
    lvim.builtin.mini_icons.on_config_done(mini_icons)
  end
end

return M
