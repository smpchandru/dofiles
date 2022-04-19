local M = {}
local home_dir = vim.loop.os_homedir()

local   dashboard = {
    active = false,
    on_config_done = nil,
    search_handler = "telescope",
    disable_at_vim_enter = 0,
    session_directory = home_dir .. "/.cache/nvim/sessions",
	custom_header = {
		' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
		' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
		' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
		' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
		' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
		' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
	},
    custom_section = {
      a = {
        description = { "  Find File          " },
        command = "Telescope find_files",
      },
     b = {
        description = { "  Recent Projects    " },
        command = "Telescope projects",
      },
      c = {
        description = { "  Recently Used Files" },
        command = "Telescope oldfiles",
      },
      d = {
        description = { "  Find Word          " },
        command = "Telescope live_grep",
      },
      e = {
        description = { "  Configuration      " },
        command = ":e " .. '~/.config/nvim/ch-config.lua',
      },
    },

    footer = { "Chandrappa" },
  }

M.setup = function()
  vim.g.dashboard_disable_at_vimenter = dashboard.disable_at_vim_enter

  vim.g.dashboard_custom_header = dashboard.custom_header

  vim.g.dashboard_default_executive = dashboard.search_handler

  vim.g.dashboard_custom_section = dashboard.custom_section

  -- n.which_key.mappings[";"] = { "<cmd>Dashboard<CR>", "Dashboard" }

  vim.g.dashboard_session_directory = dashboard.session_directory

  vim.cmd "let packages = len(globpath('~/.local/share/nvim/site/pack/packer/start', '*', 0, 1))"

  vim.api.nvim_exec(
    [[
    let g:dashboard_custom_footer = ['Neovim loaded '..packages..' plugins  ']
]],
    false
  )

  Aucom.define_augroups {
    _dashboard = {
      -- seems to be nobuflisted that makes my stuff disappear will do more testing
      {
        "FileType",
        "dashboard",
        "setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell  nolist  nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs= ",
      },
      {
        "FileType",
        "dashboard",
        "set showtabline=0 | autocmd BufLeave <buffer> set showtabline=" .. vim.opt.showtabline._value,
      },
      { "FileType", "dashboard", "nnoremap <silent> <buffer> q :q<CR>" },
    },
  }

  if dashboard.on_config_done then
    dashboard.on_config_done()
  end
end

return M 
