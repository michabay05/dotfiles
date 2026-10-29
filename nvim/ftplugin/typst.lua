local remap = vim.keymap.set
remap("n", "j", "gj")
remap("n", "k", "gk")
remap("n", "0", "g0")
remap("n", "$", "g$")

vim.lsp.config["tinymist"] = {
    cmd = {"tinymist"},
    filetypes = { "typst" },
}
vim.lsp.enable("tinymist")

require("typst-preview").setup({
    -- Custom format string to open the output link provided with %s
    -- Example: open_cmd = "firefox %s -P typst-preview --class typst-preview"
    open_cmd = nil,

    -- Custom port to open the preview server. Default is random.
    -- Example: port = 8000
    port = 0,

    -- Custom host to bind the preview server to.
    -- Note that "0.0.0.0" is not supported and [won"t be](https://github.com/Myriad-Dreamin/tinymist/issues/2105)
    -- Example: host = "192.168.0.10"
    host = "127.0.0.1",

    -- Setting this to "always" will invert black and white in the preview
    -- Setting this to "auto" will invert depending if the browser has enable
    -- dark mode
    -- Setting this to "{"rest": "<option>","image": "<option>"}" will apply
    -- your choice of color inversion to images and everything else
    -- separately.
    invert_colors = "auto",

    -- Only render the visible portion of the document.
    -- Improves performance significantly for large documents.
    -- Disable if you experience rendering issues.
    partial_rendering = true,

    -- Whether the preview will follow the cursor in the source file
    follow_cursor = true,

    -- Provide the path to binaries for dependencies.
    -- Setting this will skip the download of the binary by the plugin.
    -- Warning: Be aware that your version might be older than the one
    -- required.
    dependencies_bin = {
        tinymist = "/home/mabayneh/opt/symbins/tinymist",
        websocat = nil
    },

    -- A list of extra arguments (or nil) to be passed to previewer.
    -- For example, extra_args = { "--input=ver=draft", "--ignore-system-fonts" }
    extra_args = nil,
})
