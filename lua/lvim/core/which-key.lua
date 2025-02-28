local M = {}

local prefix = "<leader>"
-- local keymap = vim.keymap
-- local Log = require "lvim.core.log"

-- Function to remove duplicates from tableToClean based on valueArray
local function removeDuplicatedKeys(tableToClean, userKeysArray)
  -- Create a set from valueArray for quick lookup
  local valueSet = {}
  for _, value in ipairs(userKeysArray) do
    valueSet[value] = true
  end

  -- Iterate through tableToClean and remove items found in valueSet
  local cleanedTable = {}
  for _, tbl in ipairs(tableToClean) do
    if not valueSet[tbl[1]] then
      table.insert(cleanedTable, tbl)
    end
  end

  return cleanedTable
end

M.config = function()
  lvim.builtin.which_key = {
    ---@usage disable which-key completely [not recommended]
    active = true,
    on_config_done = nil,
    setup = {},
    opts = {
      preset = "helix",
      plugins = {
        marks = false, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true,
          suggestions = 20,
        }, -- use which-key for spelling hints
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = false, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = false, -- default bindings on <c-w>
          nav = false, -- misc bindings to work with windows
          z = false, -- bindings for folds, spelling and others prefixed with z
          g = false, -- bindings for prefixed with g
        },
      },
      -- add operators that will trigger motion and text object completion
      -- to enable all native operators, set the preset / operators plugin above
      operators = { gc = "Comments" },
      key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
      },
      icons = {
        breadcrumb = lvim.icons.ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
        separator = lvim.icons.ui.BoldArrowRight, -- symbol used between a key and it's label
        group = lvim.icons.ui.Plus, -- symbol prepended to a group
      },
      popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },
      window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
      },
      ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
      show_help = true, -- show help message on the command line when the popup is visible
      show_keys = true, -- show the currently pressed key and its label as a message in the command line
      triggers = "auto", -- automatically setup triggers
      -- triggers = {"<leader>"} -- or specify a list manually
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
      },
      -- disable the WhichKey popup for certain buf types and file types.
      -- Disabled by default for Telescope
      disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
      },
      spec = {
      },
    },
    vopts = {},
    user = {},
    vmappings = {},
    mappings = {},
    defaults = {
      { mode = { "n" },
        --- Groupless
        { prefix .. "/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment toggle current line", nowait = true, remap = false },
        { prefix .. ";", ":Alpha<CR>", desc = "Dashboard", nowait = true, remap = false },
        { prefix .. "e", ":NvimTreeToggle<CR>", desc = "Explorer", nowait = true, remap = false },
        { prefix .. "h", ":nohlsearch<CR>", desc = "No Highlight", nowait = true, remap = false },
        { prefix .. "q", ":confirm q<CR>", desc = "Quit", nowait = true, remap = false },
        --- LunarVim
        { prefix .. "L", group = "LunarVim", nowait = true, remap = false },
        { prefix .. "LI", ":lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>", desc = "View LunarVim's changelog", nowait = true, remap = false },
        { prefix .. "Lc", ":edit /Users/reisnobre/.config/lvim/config.lua<cr>", desc = "Edit config.lua", nowait = true, remap = false },
        { prefix .. "Ld", ":LvimDocs<cr>", desc = "View LunarVim's docs", nowait = true, remap = false },
        { prefix .. "Lf", ":lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>", desc = "Find LunarVim files", nowait = true, remap = false },
        { prefix .. "Lg", ":lua require('lvim.core.telescope.custom-finders').grep_lunarvim_files()<cr>", desc = "Grep LunarVim files", nowait = true, remap = false },
        { prefix .. "Li", ":lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>", desc = "Toggle LunarVim Info", nowait = true, remap = false },
        { prefix .. "Lk", ":Telescope keymaps<cr>", desc = "View LunarVim's keymappings", nowait = true, remap = false },
        { prefix .. "Lr", ":LvimReload<cr>", desc = "Reload LunarVim's configuration", nowait = true, remap = false },
        { prefix .. "Lu", ":LvimUpdate<cr>", desc = "Update LunarVim", nowait = true, remap = false },
        --- LunarVim Logs
        { prefix .. "Ll", group = "logs", nowait = true, remap = false },
        { prefix .. "LlD", ":lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>", desc = "Open the default logfile", nowait = true, remap = false },
        { prefix .. "LlL", ":lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", desc = "Open the LSP logfile", nowait = true, remap = false },
        { prefix .. "LlN", ":edit $NVIM_LOG_FILE<cr>", desc = "Open the Neovim logfile", nowait = true, remap = false },
        { prefix .. "Lld", ":lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>", desc = "view default log", nowait = true, remap = false },
        { prefix .. "Lll", ":lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>", desc = "view lsp log", nowait = true, remap = false },
        { prefix .. "Lln", ":lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>", desc = "view neovim log", nowait = true, remap = false },
        --- Treesitter
        { prefix .. "T", group = "Treesitter", nowait = true, remap = false },
        { prefix .. "Ti", ":TSConfigInfo<cr>", desc = "Info", nowait = true, remap = false },

        --- Buffers
        { prefix .. "b", group = "Buffers", nowait = true, remap = false },
        { prefix .. "c", ":BufferKill<CR>", desc = "Close Buffer", nowait = true, remap = false },
        { prefix .. "bD", ":BufferLineSortByDirectory<cr>", desc = "Sort by directory", nowait = true, remap = false },
        { prefix .. "bL", ":BufferLineSortByExtension<cr>", desc = "Sort by language", nowait = true, remap = false },
        { prefix .. "bW", ":noautocmd w<cr>", desc = "Save without formatting (noautocmd)", nowait = true, remap = false },
        { prefix .. "bb", ":BufferLineCyclePrev<cr>", desc = "Previous", nowait = true, remap = false },
        { prefix .. "be", ":BufferLinePickClose<cr>", desc = "Pick which buffer to close", nowait = true, remap = false },
        { prefix .. "bf", ":Telescope buffers previewer=false<cr>", desc = "Find", nowait = true, remap = false },
        { prefix .. "bh", ":BufferLineCloseLeft<cr>", desc = "Close all to the left", nowait = true, remap = false },
        { prefix .. "bj", ":BufferLinePick<cr>", desc = "Jump", nowait = true, remap = false },
        { prefix .. "bl", ":BufferLineCloseRight<cr>", desc = "Close all to the right", nowait = true, remap = false },
        { prefix .. "bn", ":BufferLineCycleNext<cr>", desc = "Next", nowait = true, remap = false },
        --- Debug
        { prefix .. "d", group = "Debug", nowait = true, remap = false },
        { prefix .. "dC", ":lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor", nowait = true, remap = false },
        { prefix .. "dU", ":lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI", nowait = true, remap = false },
        { prefix .. "db", ":lua require'dap'.step_back()<cr>", desc = "Step Back", nowait = true, remap = false },
        { prefix .. "dc", ":lua require'dap'.continue()<cr>", desc = "Continue", nowait = true, remap = false },
        { prefix .. "dd", ":lua require'dap'.disconnect()<cr>", desc = "Disconnect", nowait = true, remap = false },
        { prefix .. "dg", ":lua require'dap'.session()<cr>", desc = "Get Session", nowait = true, remap = false },
        { prefix .. "di", ":lua require'dap'.step_into()<cr>", desc = "Step Into", nowait = true, remap = false },
        { prefix .. "do", ":lua require'dap'.step_over()<cr>", desc = "Step Over", nowait = true, remap = false },
        { prefix .. "dp", ":lua require'dap'.pause()<cr>", desc = "Pause", nowait = true, remap = false },
        { prefix .. "dq", ":lua require'dap'.close()<cr>", desc = "Quit", nowait = true, remap = false },
        { prefix .. "dr", ":lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl", nowait = true, remap = false },
        { prefix .. "ds", ":lua require'dap'.continue()<cr>", desc = "Start", nowait = true, remap = false },
        { prefix .. "dt", ":lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint", nowait = true, remap = false },
        { prefix .. "du", ":lua require'dap'.step_out()<cr>", desc = "Step Out", nowait = true, remap = false },
        { prefix .. "g", group = "Git", nowait = true, remap = false },
        { prefix .. "gL", ":lua require 'gitsigns'.blame_line({full=true})<cr>", desc = "Blame Line (full)", nowait = true, remap = false },
        { prefix .. "gR", ":lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", nowait = true, remap = false },
        { prefix .. "gb", ":Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
        { prefix .. "gc", ":Telescope git_commits<cr>", desc = "Checkout commit", nowait = true, remap = false },
        { prefix .. "gd", ":Gitsigns diffthis HEAD<cr>", desc = "Git Diff", nowait = true, remap = false },
        { prefix .. "gg", ":lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", desc = "Lazygit", nowait = true, remap = false },
        { prefix .. "gj", ":lua require 'gitsigns'.nav_hunk('next', {navigation_message = false})<cr>", desc = "Next Hunk", nowait = true, remap = false },
        { prefix .. "gk", ":lua require 'gitsigns'.nav_hunk('prev', {navigation_message = false})<cr>", desc = "Prev Hunk", nowait = true, remap = false },
        { prefix .. "gl", ":lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = true, remap = false },
        { prefix .. "go", ":Telescope git_status<cr>", desc = "Open changed file", nowait = true, remap = false },
        { prefix .. "gp", ":lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", nowait = true, remap = false },
        { prefix .. "gr", ":lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", nowait = true, remap = false },
        { prefix .. "gs", ":lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk", nowait = true, remap = false },
        { prefix .. "gu", ":lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk", nowait = true, remap = false },
        --- LSP
        { prefix .. "l", group = "LSP", nowait = true, remap = false },
        { prefix .. "lI", ":Mason<cr>", desc = "Mason Info", nowait = true, remap = false },
        { prefix .. "lS", ":Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", nowait = true, remap = false },
        { prefix .. "la", ":lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
        { prefix .. "ld", ":Telescope diagnostics bufnr=0 theme=get_ivy<cr>", desc = "Buffer Diagnostics", nowait = true, remap = false },
        { prefix .. "le", ":Telescope quickfix<cr>", desc = "Telescope Quickfix", nowait = true, remap = false },
        { prefix .. "lf", ":lua require('lvim.lsp.utils').format()<cr>", desc = "Format", nowait = true, remap = false },
        { prefix .. "li", ":LspInfo<cr>", desc = "Info", nowait = true, remap = false },
        { prefix .. "lj", ":lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic", nowait = true, remap = false },
        { prefix .. "lk", ":lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic", nowait = true, remap = false },
        { prefix .. "ll", ":lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action", nowait = true, remap = false },
        { prefix .. "lq", ":lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix", nowait = true, remap = false },
        { prefix .. "lr", ":lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
        { prefix .. "ls", ":Telescope lsp_document_symbols<cr>", desc = "Document Symbols", nowait = true, remap = false },
        { prefix .. "lw", ":Telescope diagnostics<cr>", desc = "Diagnostics", nowait = true, remap = false },
        --- Plugins
        { prefix .. "p", group = "Plugins", nowait = true, remap = false },
        { prefix .. "pS", ":Lazy clear<cr>", desc = "Status", nowait = true, remap = false },
        { prefix .. "pc", ":Lazy clean<cr>", desc = "Clean", nowait = true, remap = false },
        { prefix .. "pd", ":Lazy debug<cr>", desc = "Debug", nowait = true, remap = false },
        { prefix .. "pi", ":Lazy install<cr>", desc = "Install", nowait = true, remap = false },
        { prefix .. "pl", ":Lazy log<cr>", desc = "Log", nowait = true, remap = false },
        { prefix .. "pp", ":Lazy profile<cr>", desc = "Profile", nowait = true, remap = false },
        { prefix .. "ps", ":Lazy sync<cr>", desc = "Sync", nowait = true, remap = false },
        { prefix .. "pu", ":Lazy update<cr>", desc = "Update", nowait = true, remap = false },
        --- Search
        { prefix .. "s", group = "Search", nowait = true, remap = false },
        { prefix .. "sC", ":Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
        { prefix .. "sH", ":Telescope highlights<cr>", desc = "Find highlight groups", nowait = true, remap = false },
        { prefix .. "sM", ":Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
        { prefix .. "sR", ":Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
        { prefix .. "sb", ":Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
        { prefix .. "sc", ":Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
        { prefix .. "sf", ":Telescope find_files<cr>", desc = "Find File", nowait = true, remap = false },
        { prefix .. "sh", ":Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
        { prefix .. "sk", ":Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
        { prefix .. "sl", ":Telescope resume<cr>", desc = "Resume last search", nowait = true, remap = false },
        { prefix .. "sp", ":lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", desc = "Colorscheme with Preview", nowait = true, remap = false },
        { prefix .. "sr", ":Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
        { prefix .. "st", ":Telescope live_grep<cr>", desc = "Text", nowait = true, remap = false },
      },
    }
  }
end

M.setup = function()
  local which_key = require "which-key"
  local defaults =  lvim.builtin.which_key.defaults[1]
  -- Log:error('before '.. #defaults)

  if not vim.tbl_isempty(lvim.builtin.which_key.user) then
    userKeys = lvim.builtin.which_key.user

    local userKeysArray = {}
    -- Loop through the table of tables
    for _, tbl in ipairs(userKeys) do
      -- Capture the first value from the table
      table.insert(userKeysArray, tbl[1])
    end

    which_key.add(userKeys)
    --- Remove duplicated keys from defaults
    defaults = removeDuplicatedKeys(defaults, userKeysArray)
  end

  --- assign remaining defaults
  lvim.builtin.which_key.opts.spec = defaults

  --- setup
  which_key.setup(lvim.builtin.which_key.opts)

  if lvim.builtin.which_key.on_config_done then
    lvim.builtin.which_key.on_config_done(which_key)
  end
end

return M
