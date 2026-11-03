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
