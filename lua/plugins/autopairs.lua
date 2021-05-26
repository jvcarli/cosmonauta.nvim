local npairs = require("nvim-autopairs")

npairs.setup({
    check_ts = true,
    ignored_next_char = "[%w%.]",
    ts_config = {
        lua = {'string'},-- it will not add pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})
