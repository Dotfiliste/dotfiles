local hardmode = true
if not hardmode then return end

local keys = { '<Up>', '<Down>', '<Left>', '<Right>', '<PageUp>', '<PageDown>' }

for _, key in ipairs(keys) do
  vim.keymap.set({ 'n', 'i', 'v' }, key, function()
    vim.notify('KEY DISABLED', vim.log.levels.WARN)
  end, { desc = 'Disabled in hardmode' })
end
