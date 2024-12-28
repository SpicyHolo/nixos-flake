-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

-- Config autocomplete (nvim-cmp)
local cmp = require('cmp')
cmp.setup({
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),          -- Trigger completion manually
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection (with Enter)
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item() -- Navigate to the next item
      else
        fallback() -- Use default <Tab> behavior
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item() -- Navigate to the previous item
      else
        fallback() -- Use default <Shift-Tab> behavior
      end
    end, { 'i', 's' }),

    ['<C-e>'] = cmp.mapping.abort(),                -- Close the completion menu
    ['<C-n>'] = cmp.mapping.select_next_item(),     -- Navigate down in the completion menu
    ['<C-p>'] = cmp.mapping.select_prev_item(),     -- Navigate up in the completion menu
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },  -- LSP completions
    { name = 'luasnip' },   -- Snippet completions
  }, {
    { name = 'buffer' },    -- Buffer completions
    { name = 'path' },      -- Path completions
  }),

  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For snippet support
    end,
  },

  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        buffer = "[Buf]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
})

-- Add language servers supports
require('lspconfig').gopls.setup({})
require('lspconfig').nil_ls.setup({})
require('lspconfig').pyright.setup({})
require('lspconfig').lua_ls.setup{
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT"
      },

      diagnostics = {
        globals = { "vim" },
      },
    }
  }
}
