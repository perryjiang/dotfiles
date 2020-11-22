local treesitter = {}

function treesitter.setup()
  require("nvim-treesitter.configs").setup({
    ensure_installed = "maintained",
    highlight = {
      enable = true,
    },
  })
end

return treesitter
