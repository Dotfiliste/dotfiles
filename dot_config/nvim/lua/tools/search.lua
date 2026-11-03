-- État « recherche mise de côté » :
--   1er <Esc> sur une recherche active → masquée (colonne hybride),
--     mais pattern @/ et highlight conservés.
--   2e <Esc> → effacement complet (côté keymap).
--
-- Ce module ne dépend de rien : la keymap l'écrit, la statuscolumn le lit.

local M = {}

-- Pattern mis de côté par <Esc> (nil = aucun).
-- On stocke le pattern (et non un booléen) : toute recherche différente
-- (`*`, `#`, `:g/`, pattern modifié…) réarme le mécanisme automatiquement.
M.dismissed = nil

-- Toute recherche saisie via `/` ou `?` réarme explicitement le mécanisme,
-- même si c'est exactement le même pattern qu'avant (le cas limite).
-- Note : une recherche avortée (Esc / C-c dans la cmdline) réarme aussi.
vim.api.nvim_create_autocmd('CmdlineLeave', {
  pattern = { '/', '?' },
  callback = function() M.dismissed = nil end,
})

return M
