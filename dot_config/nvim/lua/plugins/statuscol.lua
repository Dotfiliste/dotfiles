-- Numérotation pilotée par l'écran :
--   ligne courante                   → absolu, CursorLineNr
--   EDGE lignes en haut et en bas    → absolu, LineNr
--   tout le reste                    → relatif, Special
-- Cmdline ouverte (`:` `/` `?`) ou recherche active (n/N) non mise de côté :
-- tout absolu, sauf la ligne courante qui garde sa couleur.

local search = require('tools.search')

local EDGE = 3 -- lignes absolues collées à chaque bord de l'écran

-- Une cellule : alignée à droite (`%=`), couleur `hl`, texte `num`.
local function cell(hl, num)
  return '%=' .. ('%%#%s#%d %%*'):format(hl, num)
end

-- `lnum` fait-elle partie des EDGE lignes les plus proches d'un bord visible ?
-- w0 / w$ = première / dernière ligne de buffer visibles ; pendant
-- l'évaluation de la statuscolumn, la fenêtre dessinée est la courante.
local function near_screen_edge(lnum)
  local first = vim.fn.line('w0')
  local last  = vim.fn.line('w$')
  return lnum - first < EDGE or last - lnum < EDGE
end

-- Cmdline ouverte, ou recherche active et non mise de côté → absolu partout.
local function absolute_only()
  if vim.fn.getcmdtype() ~= '' then return true end
  local pattern = vim.fn.getreg('/')
  return pattern ~= '' and pattern ~= search.dismissed
end

local function hybrid_lnum(args)
  -- Lignes virtuelles (wrap, folds…) : pas de numéro.
  if args.virtnum ~= 0 then return ' ' end

  -- Ligne courante : toujours absolue et mise en évidence.
  if args.relnum == 0 then
    return cell('CursorLineNr', args.lnum)
  end

  -- Absolu forcé (cmdline/recherche), ou bord d'écran.
  if absolute_only() or near_screen_edge(args.lnum) then
    return cell('LineNr', args.lnum)
  end

  -- Tout le reste : relatif.
  return cell('Special', args.relnum)
end

-- La cmdline ne redessine pas les fenêtres à l'entrée ni à la sortie :
-- on force la réévaluation, différée car ignorée pendant l'event.
vim.api.nvim_create_autocmd({ 'CmdlineEnter', 'CmdlineLeave' }, {
  pattern = { ':', '/', '?' },
  callback = function()
    vim.schedule(function()
      vim.api.nvim__redraw({ statuscolumn = true, flush = true })
    end)
  end,
})

return {
  'luukvbaal/statuscol.nvim',
  lazy = false,
  config = function()
    require('statuscol').setup({
      relculright = true,
      segments = {
        { text = { '%s' },        click = 'v:lua.ScSa' },
        { text = { hybrid_lnum }, click = 'v:lua.ScLa' },
      },
    })
  end,
}
