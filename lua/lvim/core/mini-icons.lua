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

  return {
    icon = '',
    color = color,
  }
end

M.config = function()
  lvim.builtin.mini_icons = {
    active = true,
    on_config_done = nil,
    setup = {}
  }

end

function M.setup()
  local status_ok, mini_icons = pcall(require, "mini.icons")
  if not status_ok then
    return
  end

  mini_icons.setup(lvim.builtin.mini_icons)

  if lvim.builtin.mini_icons.on_config_done then
    lvim.builtin.mini_icons.on_config_done(mini_icons)
  end
end

return M
