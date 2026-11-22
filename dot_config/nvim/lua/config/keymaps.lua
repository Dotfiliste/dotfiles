local search = require('tools.search')

-- Réévalue la statuscolumn après l'event (le redraw serait ignoré durant).
local function redraw_statuscolumn()
  vim.schedule(function()
    vim.api.nvim__redraw({ statuscolumn = true, flush = true })
  end)
end

-- Recherche active → 1er <Esc> : met de côté (highlight conservé, colonne hybride)
--                  → 2e <Esc>  : efface (highlight retiré, pattern vidé)
-- Aucune recherche → <Esc> purement natif.
vim.keymap.set('n', '<Esc>', function()
  search.is_navigating = false
  local pattern = vim.fn.getreg('/')
  if pattern == '' then
    search.dismissed = nil        -- rien à mettre de côté
  elseif pattern ~= search.dismissed then
    search.dismissed = pattern    -- 1er <Esc> sur cette recherche
  else
    vim.cmd('nohlsearch')         -- 2e <Esc> : effacement complet
    vim.fn.setreg('/', '')
    search.dismissed = nil
  end
  redraw_statuscolumn()
  return '<Esc>' -- la touche garde son comportement natif en plus
end, { expr = true, desc = "Esc : met la recherche de côté · Esc Esc : l'efface" })

local function center_scroll()
    -- On utilise pcall pour éviter les erreurs si on est en haut/bas du fichier
    pcall(vim.cmd.zz)
end

local function jump_and_center(key)
    search.is_navigating = true
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key .. "zz", true, false, true), "n", false)
end

vim.keymap.set('n', '<C-f>', function() jump_and_center('<C-f>') end)
vim.keymap.set('n', '<C-b>', function() jump_and_center('<C-b>') end)
vim.keymap.set('n', '<C-d>', function() jump_and_center('<C-d>') end)
vim.keymap.set('n', '<C-u>', function() jump_and_center('<C-u>') end)
