-- nvim-cmp setup
local cmp = require "cmp"

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local lspkind = require "lspkind"
local luasnip = require "luasnip"
local neogen = require "neogen"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

cmp.setup {
  snippet = {
    -- REQUIRED - you MUST specify a snippet engine
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    ["<Tab>"] = cmp.mapping(function(fallback)
      if neogen.jumpable() then
        neogen.jump_next()
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if neogen.jumpable(true) then
        neogen.jump_prev()
      elseif cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  -- completion sources
  -- order matters here
  -- you can also define order using the priority attribute
  sources = {
    { name = "nvim_lua" }, -- nvim lua api
    { name = "nvim_lsp" }, -- nvim lsp
    { name = "luasnip" }, -- snippet engine
    {
      name = "rg",
      keyword_length = 4,
    },
    {
      name = "buffer", -- buffer completion
      keyword_length = 5, -- only shows buffer completion after a 5 letters word
    },
    { name = "path" },
  },

  -- vscode like icons
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Nvim Lua]",
        rg = "[Ripgrep]",

        -- latex_symbols = "[Latex]",
      },
    },
  },

  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require("cmp-under-comparator").under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  experimental = {
    -- testing the non native menu
    native_menu = false, -- default

    ghost_text = false, -- default, it's annoying
  },
}

-- Use buffer source for `/`. Won't work with the `native_menu`.
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':'. Won't work with the `native_menu`.
cmp.setup.cmdline(":", {
  view = {
    -- see: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
    entries = { name = "wildmenu", separator = " | " },
  },
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    {
      name = "cmdline",
      -- keyword_length = 3,
    },
  }),
})

-- nvim-autopairs cmp setup
-- MUST (? in the older setup yes, but the new one i don't know) be after cmp.setup()
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
