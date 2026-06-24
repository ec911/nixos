local lspconfig = require("lspconfig")

-- 1. Create hotkeys that ONLY activate when an LSP is actively running in a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP Actions',
  callback = function(event)
    local opts = { buffer = event.buf, remap = false }

    -- Essential Minimal Mappings
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)      -- Go to definition
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)            -- Show documentation
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)  -- Smart Rename
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code Actions/Fixes
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)   -- Show line diagnostic
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)    -- Prev error/warning
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)    -- Next error/warning
  end,
})

-- 2. Activate the servers (Nix handles placing these binaries in your PATH)
lspconfig.nil_ls.setup({}) -- Nix LSP

lspconfig.lua_ls.setup({   -- Lua LSP
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }, -- Suppresses annoying "undefined global 'vim'" warnings
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true), -- Makes LSP aware of Neovim runtime files
        checkThirdParty = false,
      },
    },
  },
})
