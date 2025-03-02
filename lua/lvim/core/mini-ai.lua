local M = {}

M.config = function()
  lvim.builtin.mini_ai = {
    active = true,
    on_config_done = nil,
    opts = {}
  }
end

function M.setup()
  local status_ok, mini_ai = pcall(require, "mini.ai")
  if not status_ok then
    return
  end

  mini_ai.setup(lvim.builtin.mini_ai.opts)

  if lvim.builtin.mini_ai.on_config_done then
    lvim.builtin.mini_ai.on_config_done(mini_ai)
  end
end

return M
