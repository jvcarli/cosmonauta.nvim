-- nvim-cmp setup
local lspkind = require "lspkind"
local cmp = require "cmp"
local cmp_autopairs = require "nvim-autopairs.completion.cmp"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- for vsnip snippet engine
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
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"]() == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, {
      "i",
      "s",
    }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, {
      "i",
      "s",
    }),
  },

  -- completion sources
  -- order matters here
  -- you can also define order using the priority attribute
  sources = {
    { name = "nvim_lua" }, -- nvim lua api
    { name = "nvim_lsp" }, -- nvim lsp
    { name = "vsnip" }, -- snippet engine
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
        vsnip = "[vsnip]",
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
