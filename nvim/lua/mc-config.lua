local mc = require("multicursor-nvim")
mc.setup()

local set = vim.keymap.set

-- 'gl' and 'gL' came from zed editor's way of doing multi cursors in its vim mode
set({"n", "x"}, "gl", function() mc.matchAddCursor(1) end)
set({"n", "x"}, "gL", function() mc.matchAddCursor(-1) end)
set({"n", "x"}, "<leader>s", function() mc.matchSkipCursor(1) end)
set({"n", "x"}, "<leader>S", function() mc.matchSkipCursor(-1) end)

-- Add and remove cursors with control + left click.
set("n", "<c-leftmouse>", mc.handleMouse)
set("n", "<c-leftdrag>", mc.handleMouseDrag)
set("n", "<c-leftrelease>", mc.handleMouseRelease)

-- Disable and enable cursors.
set({"n", "x"}, "<c-q>", mc.toggleCursor)

mc.addKeymapLayer(function(layerSet)
    -- Select a different cursor as the main one.
    layerSet({"n", "x"}, "<left>", mc.prevCursor)
    layerSet({"n", "x"}, "<right>", mc.nextCursor)

    -- Delete the main cursor.
    layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

    -- Enable and clear cursors using escape.
    layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        else
            mc.clearCursors()
        end
    end)
end)
