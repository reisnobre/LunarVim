local M = {}

local get_icon = require("lvim.core.mini-icons").get_icon

M.config = function()
  lvim.builtin.gitsigns = {
    active = true,
    on_config_done = nil,
    opts = {
      signs = {
        add          = { text = get_icon("BoldLineLeft", { category = "ui" }).icon },
        change       = { text = get_icon("BoldLineLeft", { category = "ui" }).icon },
        delete       = { text = get_icon("Triangle", { category = "ui" }).icon },
        topdelete    = { text = get_icon("Triangle", { category = "ui" }).icon },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signs_staged = {
        add          = { text = get_icon("BoldLineLeft", { category = "ui" }).icon },
        change       = { text = get_icon("BoldLineLeft", { category = "ui" }).icon },
        delete       = { text = get_icon("Triangle", { category = "ui" }).icon },
        topdelete    = { text = get_icon("Triangle", { category = "ui" }).icon },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signs_staged_enable = true,
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      status_formatter = nil, -- Use default
      update_debounce = 200,
      max_file_length = 40000,
      preview_config = {
        -- Options passed to nvim_open_win
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      }
    },
  }
end

M.setup = function()
  local gitsigns = reload "gitsigns"

  gitsigns.setup(lvim.builtin.gitsigns.opts)
  if lvim.builtin.gitsigns.on_config_done then
    lvim.builtin.gitsigns.on_config_done(gitsigns)
  end
end

return M
