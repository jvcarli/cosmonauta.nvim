-- nvim-cmp setup
local cmp = require "cmp"

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local lspkind = require "lspkind"
local luasnip = require "luasnip"

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
    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
    ["<C-j>"] = cmp.mapping.scroll_docs(4),
    -- ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-q>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,

      -- Accept current selected completion item.
      -- If you didn't select any items and specified the `{ select = true }`
      -- for this, nvim-cmp will automatically select the first item, which I find annoying,
      -- so I use `{ select = false }` instead.
      select = false,
    },

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
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
      if cmp.visible() then
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
    { name = "luasnip" }, -- luasnip completion source for nvim-cmp (saadparwaiz1/cmp_luasnip)
    { name = "nvim_lua" }, -- nvim lua api
    { name = "nvim_lsp" }, -- nvim lsp
    { name = "nvim_lsp_signature_help" }, -- lsp signature help, similar to ray-x/lsp_signature.nvim, but much better integrated with nvim_cmp
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

  -- HACK: vscode like icons and which LSP is responsible for the current completion menu item (not guaranteed to be stable)
  formatting = {
    -- see: https://www.reddit.com/r/neovim/comments/smtrpm/is_it_possible_to_show_which_lsp_is_responsible/
    -- taken from: https://github.com/rebelot/dotfiles/blob/master/nvim/lua/plugins/cmp.lua#L128-L151
    format = function(entry, vim_item)
      -- vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
      vim_item = lspkind.cmp_format()(entry, vim_item)

      local alias = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Nvim Lua]",
        rg = "[Ripgrep]",

        -- latex_symbols = "[Latex]",
      }

      if entry.source.name == "nvim_lsp" then
        vim_item.menu = "[" .. entry.source.source.client.name .. "]"
      else
        vim_item.menu = alias[entry.source.name] or entry.source.name
      end
      return vim_item
    end,
  },

  -- vscode like icons (stable)
  -- formatting = {
  --   format = lspkind.cmp_format {
  --     with_text = true,
  --     menu = {
  --       buffer = "[Buffer]",
  --       nvim_lsp = "[LSP]",
  --       luasnip = "[LuaSnip]",
  --       nvim_lua = "[Nvim Lua]",
  --       rg = "[Ripgrep]",
  --
  --       -- latex_symbols = "[Latex]",
  --     },
  --   },
  -- },

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
  sources = {
    {
      name = "cmdline",
      keyword_length = 3,
    },
  },
})

-- nvim-autopairs cmp setup
-- MUST (? in the older setup yes, but the new one i don't know) be after cmp.setup()
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
