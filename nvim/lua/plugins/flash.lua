require("flash").setup({
    labels = "asdfghjklqwertyuiopzxcvbnm",
    search = {
        mode = "fuzzy",
    },
})

vim.keymap.set("n", "/", function()
    require("flash").jump()
end, { noremap = true })
