require("bufferline").setup({
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    offsets = {
      {
        filetype = "NvimTree_1",
        text = "Explorer",
        highlight = "PanelHeading",
        padding = 1,
      },
    },
  },
})
