local M = {}

M.config = function()
  lvim.builtin.snacks = {
    active = true,
    on_config_done = nil,
    setup = {},
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      dashboard = require("lvim.core.snacks.snacks-dashboard"),
      bigfile = { enabled = true },
      indent = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      input = { enabled = false },
      explorer = { enabled = false },
      picker = { enabled = false },
      scroll = { enabled = false },
    }
  }
end

M.setup = function()
  local status_ok, snacks = pcall(require, "snacks")
  if not status_ok then
    return
  end
  snacks.setup(lvim.builtin.snacks.opts)
  local notify = vim.notify
  -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
  -- this is needed to have early notifications show up in noice history
  vim.notify = notify
  if lvim.builtin.snacks.on_config_done then
    lvim.builtin.snacks.on_config_done(snacks)
  end
end

return M
