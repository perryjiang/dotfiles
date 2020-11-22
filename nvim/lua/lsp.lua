local lsp = {}

local function set_local_mappings(mappings)
  for lhs, rhs in pairs(mappings) do
    vim.api.nvim_buf_set_keymap(0, "n", lhs, rhs, { noremap = true, nowait = true })
  end
end

local function on_attach(client)
  local function command(fn)
    return "<Cmd>lua vim.lsp.buf." .. fn .. "()<CR>"
  end

  set_local_mappings({
    ["<C-]>"] = command("definition"),
    gr = command("references"),
    K = command("hover"),
    ["<Leader>="] = command("formatting"),
  })

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
    }
  )

  require("completion").on_attach(client)
end

local servers = {
  clangd = {
    on_attach = function(client)
      set_local_mappings({
        ["<Leader>ae"] = "<Cmd>ClangdSwitchSourceHeader<CR>",
        ["<Leader>as"] = "<Cmd>split +ClangdSwitchSourceHeader<CR>",
        ["<Leader>av"] = "<Cmd>vsplit +ClangdSwitchSourceHeader<CR>",
      })

      on_attach(client)
    end,
  },
  cmake = {
    on_attach = on_attach,
  },
  jsonls = {
    on_attach = on_attach,
  },
  vimls = {
    on_attach = on_attach,
  },
  yamlls = {
    on_attach = on_attach,
  },
}

function lsp.setup()
  for server, config in pairs(servers) do
    require("lspconfig")[server].setup(config)
  end
end

return lsp
