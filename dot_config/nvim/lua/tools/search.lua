-- État partagé : la keymap <Esc> et les scrolls l'écrivent, la statuscolumn le lit.
--
--   dismissed     : pattern mis de côté par le 1er <Esc> (nil = aucun).
--                   On stocke le pattern (et non un booléen) : toute recherche
--                   différente (`*`, `#`, `:g/`, pattern modifié…) réarme le mécanisme.
--   is_navigating : true après un scroll, remis à false par <Esc>.
--
-- Ce module ne dépend de rien.

local M = {}

M.dismissed = nil
M.is_navigating = false

-- Réévalue la statuscolumn. Différé : un redraw demandé pendant un event
-- ou une keymap <expr> serait ignoré.
function M.redraw()
  vim.schedule(function()
    vim.api.nvim__redraw({ statuscolumn = true, flush = true })
  end)
end

-- Toute recherche saisie via `/` ou `?` réarme le mécanisme, même sur un
-- pattern identique. Note : une recherche avortée (Esc / C-c) réarme aussi.
vim.api.nvim_create_autocmd('CmdlineLeave', {
  group = vim.api.nvim_create_augroup('tools.search', { clear = true }),
  pattern = { '/', '?' },
  callback = function() M.dismissed = nil end,
})

return M
