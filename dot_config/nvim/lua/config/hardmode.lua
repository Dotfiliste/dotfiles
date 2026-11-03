local hardmode = true
if hardmode then
  local function warn()
    vim.notify('KEY DISABLED', vim.log.levels.ERROR, { title = 'Hardmode' })
  end

  local keys = { '<Up>', '<Down>', '<Left>', '<Right>', '<PageUp>', '<PageDown>' }
  local modes = { 'n', 'i', 'v' }

  for _, mode in ipairs(modes) do
    for _, key in ipairs(keys) do
      vim.keymap.set(mode, key, warn, { desc = 'Disabled in hardmode' })
    end
  end
end
