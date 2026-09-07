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
        }
    },
})
require("telescope").load_extension("fzf")

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
    builtin.find_files({
        search_dirs = get_search_dirs(),
        hidden = true, noignore = true
    })
end, { desc = "Find files" })

remap("n", "<leader>g", function()
    builtin.live_grep({ search_dirs = get_search_dirs() })
end, { desc = "Live grep" })
remap("n", "<leader>th", builtin.help_tags)
remap("n", "<leader><leader>", builtin.buffers)
remap("n", "<leader>sn", function()
    builtin.find_files({ cwd = vim.fn.stdpath("config") })
end)

