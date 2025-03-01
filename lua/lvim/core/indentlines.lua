local M = {}

local get_icon = require("lvim.core.mini-icons").get_icon

M.config = function()
  lvim.builtin.indentlines = {
    active = true,
    on_config_done = nil,
    opts = {
      enabled = true,
      whitespace = { highlight = { "Whitespace", "NonText" } },
      indent = {
        char = get_icon("LineLeft", { category = "ui" }).icon,
      },  -- Change indentation character
      scope = {
        enabled = true,
        char = get_icon("LineLeft", { category = "ui" }).icon,
      },  -- Highlight current scope
      exclude = {
        filetypes = { "help", "dashboard", "lazy", "mason" },  -- Exclude certain filetypes
        buftypes = { "terminal", "nofile" },
      }
    }
  }
end

M.setup = function()
  local status_ok, indent_blankline = pcall(require, "ibl")
  if not status_ok then
    return
  end

  indent_blankline.setup(lvim.builtin.indentlines.opts)

  if lvim.builtin.indentlines.on_config_done then
    lvim.builtin.indentlines.on_config_done()
  end
end

return M
