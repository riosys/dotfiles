return {
    "xiyaowong/transparent.nvim",
    name = "transparent",
    priority = 1000,
    config = function()
        vim.cmd("TransparentEnable")
    end
}
