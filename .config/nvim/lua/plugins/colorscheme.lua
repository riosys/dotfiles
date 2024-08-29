return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
          transparent_background = true,
          flavour = "mocha",
        },
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            notify = false,
            mini = {
                enabled = true,
                indentscope_color = "",
            },
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
        config = function ()
            vim.cmd.colorscheme"catppuccin-mocha"
        end,
    },
    {
        "rebelot/kanagawa.nvim",
	    name = "kanagawa",
	    priority = 1000,
    },
}
