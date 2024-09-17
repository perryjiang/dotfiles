local mini_path = vim.fn.stdpath("data") .. "/site/pack/deps/start/mini.nvim"
if not vim.uv.fs_stat(mini_path) then
  vim.system({ "git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.nvim", mini_path }):wait()
  vim.cmd("packadd mini.nvim | helptags ALL")
end
require("mini.deps").setup()

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  require("mini.basics").setup({
    autocommands = {
      relnum_in_visual_mode = true,
    },
  })
end)
now(function()
  add("sainnhe/gruvbox-material")
  vim.cmd.colorscheme("gruvbox-material")
end)
now(function()
  require("mini.icons").setup()
end)
now(function()
  require("mini.notify").setup()
  vim.notify = MiniNotify.make_notify()
end)
now(function()
  require("mini.starter").setup()
end)
now(function()
  require("mini.statusline").setup()
end)

later(function()
  require("mini.ai").setup()
end)
later(function()
  require("mini.bracketed").setup()
end)
later(function()
  require("mini.completion").setup()
end)
later(function()
  require("mini.cursorword").setup()
end)
later(function()
  require("mini.diff").setup()
end)
later(function()
  require("mini.git").setup()
end)
later(function()
  require("mini.indentscope").setup()
end)
later(function()
  require("mini.pairs").setup()
end)
later(function()
  require("mini.surround").setup()
end)

later(function()
  add("ibhagwan/fzf-lua")
  local fzf = require("fzf-lua")
  fzf.setup()
  vim.keymap.set("n", "<Leader>fb", fzf.buffers)
  vim.keymap.set("n", "<Leader>ff", fzf.files)
  vim.keymap.set("n", "<Leader>fg", fzf.live_grep_glob)
  vim.keymap.set("n", "<Leader>fh", fzf.help_tags)
end)

later(function()
  add("stevearc/oil.nvim")
  require("oil").setup()
  vim.keymap.set("n", "-", "<Cmd>Oil<CR>")
end)

later(function()
  add("williamboman/mason.nvim")
  require("mason").setup()
end)

later(function()
  add({
    source = "stevearc/conform.nvim",
    depends = {
      "zapling/mason-conform.nvim",
    },
  })
  require("conform").setup({
    format_on_save = {},
    formatters_by_ft = {
      _ = {
        "trim_newlines",
        "trim_whitespace",
      },
      c = {
        "clang-format",
      },
      cpp = {
        "clang-format",
      },
      json = {
        "jq",
      },
      lua = {
        "stylua",
      },
    },
  })
  require("mason-conform").setup()
end)

later(function()
  add({
    source = "neovim/nvim-lspconfig",
    depends = {
      "williamboman/mason-lspconfig.nvim",
    },
  })
  require("mason-lspconfig").setup({
    automatic_installation = true,
  })
  local lspconfig = require("lspconfig")
  lspconfig.clangd.setup({})
  lspconfig.jsonls.setup({})
  lspconfig.lua_ls.setup({})
end)

later(function()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    hooks = {
      post_checkout = function()
        vim.cmd("TSUpdate")
      end,
    },
  })
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "comment",
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
  })
end)
