local remap = vim.keymap.set
local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules", "build", "dist", "yarn.lock",
            ".git"
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden"
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        file_browser = {
            hijack_netrw = true,
        }
    },
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")

-- Helper function to gather CWD + any extra configured folders
local function get_search_dirs()
    local dirs = { vim.fn.getcwd() }
    if vim.g.extra_search_dirs then
        for _, dir in ipairs(vim.g.extra_search_dirs) do
            print(dir)
            table.insert(dirs, vim.fn.expand(dir))
        end
    end
    return dirs
end

remap("n", "<leader>f", function()
    -- Expands full path of the current buffer and gets its head directory
    local buffer_dir = vim.fn.expand("%:p:h")

    -- Fallback to global cwd if the buffer has no file on disk
    if buffer_dir == "" then
        buffer_dir = vim.fn.getcwd()
    end

    builtin.find_files({
        prompt_title = "Find files in buffer dir",
        cwd = buffer_dir,
        hidden = true, noignore = true,
    })
end, { desc = "Find files in current working directory" })

remap("n", "<leader>g", function()
    local buffer_dir = vim.fn.expand("%:p:h")

    -- Fallback to global cwd if the buffer has no file on disk
    if buffer_dir == "" then
        buffer_dir = vim.fn.getcwd()
    end

    builtin.live_grep({
        prompt_title = "Grep in buffer dir",
        cwd = buffer_dir,
    })
end, { desc = "Live grep" })

remap("n", "<leader>h", builtin.help_tags)
remap("n", "<leader><leader>", builtin.buffers)
remap("n", "<leader>sn", function()
    builtin.find_files({ cwd = vim.fn.stdpath("config") })
end)
remap("n", "<leader>e", function()
    telescope.extensions.file_browser.file_browser()
end)

