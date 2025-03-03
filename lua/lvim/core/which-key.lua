local M = {}

local prefix = "<leader>"
local get_icon = require("lvim.core.mini.mini-icons").get_icon
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
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
          operators = true, -- adds help for operators like d, y, ...
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      -- add operators that will trigger motion and text object completion
      -- to enable all native operators, set the preset / operators plugin above
      operators = { gc = "Comments" },
      icons = {
        -- lvim.icons.ui.DoubleChevronRight
        breadcrumb = get_icon('DoubleChevronRight', { category = 'ui' }).icon, -- symbol used in the command line area that shows your active key combo
        separator = get_icon('BoldArrowRight', { category = 'ui' }).icon, -- symbol used between a key and it's label
        group = get_icon('Plus', { category = 'ui' }).icon, -- symbol prepended to a group
      },
      popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
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
      spec = {},
    },
    vopts = {},
    user = {},
    vmappings = {},
    mappings = {},
    defaults = {
      {
        mode = { "n" },
        --- Groupless
        { prefix .. "e", ":NvimTreeToggle<CR>", desc = "Explorer" }, { prefix .. "h", ":nohlsearch<CR>", desc = "No Highlight" },
        { prefix .. "q", ":confirm q<CR>", desc = "Quit" },
        --- LunarVim
        { prefix .. "L", group = "LunarVim", icon = get_icon("moonscript", { color = "blue" }) },
        { prefix .. "LI", ":lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>", desc = "View LunarVim's changelog" },
        { prefix .. "Lc", ":edit /Users/reisnobre/.config/lvim/config.lua<cr>", desc = "Edit config.lua" },
        { prefix .. "Ld", ":LvimDocs<cr>", desc = "View LunarVim's docs" },
        { prefix .. "Lf", ":lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>", desc = "Find LunarVim files" },
        { prefix .. "Lg", ":lua require('lvim.core.telescope.custom-finders').grep_lunarvim_files()<cr>", desc = "Grep LunarVim files" },
        { prefix .. "Li", ":lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>", desc = "Toggle LunarVim Info" },
        { prefix .. "Lk", ":Telescope keymaps<cr>", desc = "View LunarVim's keymappings" },
        { prefix .. "Lr", ":LvimReload<cr>", desc = "Reload LunarVim's configuration" },
        { prefix .. "Lu", ":LvimUpdate<cr>", desc = "Update LunarVim" },
        --- LunarVim Logs
        { prefix .. "Ll", group = "logs" },
        { prefix .. "LlD", ":lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>", desc = "Open the default logfile" },
        { prefix .. "LlL", ":lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", desc = "Open the LSP logfile" },
        { prefix .. "LlN", ":edit $NVIM_LOG_FILE<cr>", desc = "Open the Neovim logfile" },
        { prefix .. "Lld", ":lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>", desc = "view default log" },
        { prefix .. "Lll", ":lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>", desc = "view lsp log" },
        { prefix .. "Lln", ":lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>", desc = "view neovim log" },
        --- Treesitter
        { prefix .. "T", group = "Treesitter", icon = get_icon('Tree', { category = 'ui', color = 'green' }) },
        { prefix .. "Tq", ":TSPlaygroundToggle<cr>", desc = "Query" },
        { prefix .. "Tr", ":TSPlaygroundToggle<cr>", desc = "Replace" },
        { prefix .. "Tt", ":TSHighlightCapturesUnderCursor<cr>", desc = "Highlight" },
        { prefix .. "Ti", ":TSConfigInfo<cr>", desc = "Info" },

        --- Buffers
        { prefix .. "b", group = "Buffers" },
        { prefix .. "c", ":BufferKill<CR>", desc = "Close Buffer" },
        { prefix .. "bD", ":BufferLineSortByDirectory<cr>", desc = "Sort by directory" },
        { prefix .. "bL", ":BufferLineSortByExtension<cr>", desc = "Sort by language" },
        { prefix .. "bW", ":noautocmd w<cr>", desc = "Save without formatting (noautocmd)" },
        { prefix .. "bb", ":BufferLineCyclePrev<cr>", desc = "Previous" },
        { prefix .. "be", ":BufferLinePickClose<cr>", desc = "Pick which buffer to close" },
        { prefix .. "bf", ":Telescope buffers previewer=false<cr>", desc = "Find" },
        { prefix .. "bh", ":BufferLineCloseLeft<cr>", desc = "Close all to the left" },
        { prefix .. "bj", ":BufferLinePick<cr>", desc = "Jump" },
        { prefix .. "bl", ":BufferLineCloseRight<cr>", desc = "Close all to the right" },
        { prefix .. "bn", ":BufferLineCycleNext<cr>", desc = "Next" },
        --- Debug
        { prefix .. "d", group = "Debug" },
        { prefix .. "dC", ":lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor" },
        { prefix .. "dU", ":lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI" },
        { prefix .. "db", ":lua require'dap'.step_back()<cr>", desc = "Step Back" },
        { prefix .. "dc", ":lua require'dap'.continue()<cr>", desc = "Continue" },
        { prefix .. "dd", ":lua require'dap'.disconnect()<cr>", desc = "Disconnect" },
        { prefix .. "dg", ":lua require'dap'.session()<cr>", desc = "Get Session" },
        { prefix .. "di", ":lua require'dap'.step_into()<cr>", desc = "Step Into" },
        { prefix .. "do", ":lua require'dap'.step_over()<cr>", desc = "Step Over" },
        { prefix .. "dp", ":lua require'dap'.pause()<cr>", desc = "Pause" },
        { prefix .. "dq", ":lua require'dap'.close()<cr>", desc = "Quit" },
        { prefix .. "dr", ":lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl" },
        { prefix .. "ds", ":lua require'dap'.continue()<cr>", desc = "Start" },
        { prefix .. "dt", ":lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
        { prefix .. "du", ":lua require'dap'.step_out()<cr>", desc = "Step Out" },
        --- Git
        { prefix .. "g", group = "Git" },
        { prefix .. "gL", ":lua require 'gitsigns'.blame_line({full=true})<cr>", desc = "Blame Line (full)" },
        { prefix .. "gR", ":lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
        { prefix .. "gb", ":Telescope git_branches<cr>", desc = "Checkout branch" },
        { prefix .. "gc", ":Telescope git_commits<cr>", desc = "Checkout commit" },
        { prefix .. "gd", ":Gitsigns diffthis HEAD<cr>", desc = "Git Diff" },
        { prefix .. "gg", ":lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", desc = "Lazygit" },
        {
          prefix .. "gj",
          ":lua require 'gitsigns'.nav_hunk('next', {navigation_message = false})<cr>",
          desc = "Next Hunk",
        },
        {
          prefix .. "gk",
          ":lua require 'gitsigns'.nav_hunk('prev', {navigation_message = false})<cr>",
          desc = "Prev Hunk",
        },
        { prefix .. "gl", ":lua require 'gitsigns'.blame_line()<cr>", desc = "Blame" },
        { prefix .. "go", ":Telescope git_status<cr>", desc = "Open changed file" },
        { prefix .. "gp", ":lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk" },
        { prefix .. "gr", ":lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk" },
        { prefix .. "gs", ":lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk" },
        { prefix .. "gu", ":lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },
        --- LSP
        { prefix .. "l", group = "LSP", icon = get_icon('BoldHint', { category = 'diagnostics', color = 'purple' }) },
        { prefix .. "lI", ":Mason<cr>", desc = "Mason Info" },
        { prefix .. "lS", ":Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
        { prefix .. "la", ":lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
        { prefix .. "ld", ":Telescope diagnostics bufnr=0 theme=get_ivy<cr>", desc = "Buffer Diagnostics" },
        { prefix .. "le", ":Telescope quickfix<cr>", desc = "Telescope Quickfix" },
        { prefix .. "lf", ":lua require('lvim.lsp.utils').format()<cr>", desc = "Format" },
        { prefix .. "li", ":LspInfo<cr>", desc = "Info" },
        { prefix .. "lj", ":lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
        { prefix .. "lk", ":lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
        { prefix .. "ll", ":lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
        { prefix .. "lq", ":lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
        { prefix .. "lr", ":lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
        { prefix .. "ls", ":Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
        { prefix .. "lw", ":Telescope diagnostics<cr>", desc = "Diagnostics" },
        --- Plugins
        { prefix .. "p", group = "lazy" },
        { prefix .. "pS", ":Lazy clear<cr>", desc = "Status" },
        { prefix .. "pc", ":Lazy clean<cr>", desc = "Clean" },
        { prefix .. "pd", ":Lazy debug<cr>", desc = "Debug" },
        { prefix .. "pi", ":Lazy install<cr>", desc = "Install" },
        { prefix .. "pl", ":Lazy log<cr>", desc = "Log" },
        { prefix .. "pp", ":Lazy profile<cr>", desc = "Profile" },
        { prefix .. "ps", ":Lazy sync<cr>", desc = "Sync" },
        { prefix .. "pu", ":Lazy update<cr>", desc = "Update" },
        --- Search
        { prefix .. "S", group = "Search" },
        { prefix .. "SC", ":Telescope commands<cr>", desc = "Commands" },
        { prefix .. "SH", ":Telescope highlights<cr>", desc = "Find highlight groups" },
        { prefix .. "Sm", ":Telescope man_pages<cr>", desc = "Man Pages" },
        { prefix .. "SR", ":Telescope registers<cr>", desc = "Registers" },
        { prefix .. "Sb", ":Telescope git_branches<cr>", desc = "Checkout branch" },
        { prefix .. "Sc", ":Telescope colorscheme<cr>", desc = "Colorscheme" },
        { prefix .. "Sf", ":Telescope find_files<cr>", desc = "Find File" },
        { prefix .. "Sh", ":Telescope help_tags<cr>", desc = "Find Help" },
        { prefix .. "Sk", ":Telescope keymaps<cr>", desc = "Keymaps" },
        { prefix .. "Sl", ":Telescope resume<cr>", desc = "Resume last search" },
        { prefix .. "Sp", ":lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", desc = "Colorscheme with Preview" },
        { prefix .. "Sr", ":Telescope oldfiles<cr>", desc = "Open Recent File" },
        { prefix .. "St", ":Telescope live_grep<cr>", desc = "Text" },
      },
    },
  }
end

M.setup = function()
  local which_key = require "which-key"
  local defaults = lvim.builtin.which_key.defaults[1]
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
