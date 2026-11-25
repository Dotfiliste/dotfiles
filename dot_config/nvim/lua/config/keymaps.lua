local search = require('tools.search')

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
    vim.cmd.nohlsearch()          -- 2e <Esc> : effacement complet
    vim.fn.setreg('/', '')
    search.dismissed = nil
  end
  search.redraw()
  return '<Esc>' -- la touche garde son comportement natif en plus
end, { expr = true, desc = "Esc : met la recherche de côté · Esc Esc : l'efface" })

-- Scroll + recentrage. En <expr>, le count tapé avant (5<C-d>, 2<C-f>) est conservé.
--   <C-d>/<C-u> : demi-page, puis zz recentre l'écran sur le curseur.
--   <C-f>/<C-b> : page entière, puis M amène le curseur au milieu de l'écran
--                 (zz ferait reculer l'écran d'une demi-page).
local scrolls = { ['<C-d>'] = 'zz', ['<C-u>'] = 'zz', ['<C-f>'] = 'M', ['<C-b>'] = 'M' }

for key, center in pairs(scrolls) do
  vim.keymap.set('n', key, function()
    search.is_navigating = true
    return key .. center
  end, { expr = true, desc = 'Scroll centré' })
end
