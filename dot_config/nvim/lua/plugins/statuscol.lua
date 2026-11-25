-- Numérotation pilotée par l'écran :
--   ligne courante                   → absolu, CursorLineNr
--   EDGE lignes en haut et en bas    → absolu, LineNr
--   tout le reste                    → relatif, Special
-- Tout absolu (sauf la couleur de la ligne courante) quand :
--   cmdline ouverte (`:` `/` `?`), recherche active non mise de côté,
--   ou après un scroll (<C-d> <C-u> <C-f> <C-b>) jusqu'au prochain <Esc>.

local search = require('tools.search')

local EDGE = 3 -- lignes absolues collées à chaque bord de l'écran

-- Une cellule : alignée à droite (`%=`), couleur `hl`, texte `num`.
local function cell(hl, num)
  return ('%%=%%#%s#%d %%*'):format(hl, num)
end

-- La ligne fait-elle partie des EDGE lignes les plus proches d'un bord visible ?
local function near_screen_edge(args)
  local first = vim.fn.line('w0', args.win)
  local last  = vim.fn.line('w$', args.win)
  return args.lnum - first < EDGE or last - args.lnum < EDGE
end

local function absolute_only()
  if search.is_navigating or vim.fn.getcmdtype() ~= '' then return true end
  local pattern = vim.fn.getreg('/')
  return pattern ~= '' and pattern ~= search.dismissed
end

local function hybrid_lnum(args)
  -- Lignes virtuelles (virtnum < 0) ou suites de ligne wrappée (> 0) : pas de numéro.
  if args.virtnum ~= 0 then return ' ' end

  if args.relnum == 0 then
    return cell('CursorLineNr', args.lnum)
  end
  if absolute_only() or near_screen_edge(args) then
    return cell('LineNr', args.lnum)
  end
  return cell('Special', args.relnum)
end

return {
  'luukvbaal/statuscol.nvim',
  lazy = false,
  config = function()
    require('statuscol').setup({
      segments = {
        { text = { '%s' },        click = 'v:lua.ScSa' },
        { text = { hybrid_lnum }, click = 'v:lua.ScLa' },
      },
    })

    -- La cmdline ne redessine pas les fenêtres à l'entrée ni à la sortie.
    vim.api.nvim_create_autocmd({ 'CmdlineEnter', 'CmdlineLeave' }, {
      group = vim.api.nvim_create_augroup('plugins.statuscol', { clear = true }),
      pattern = { ':', '/', '?' },
      callback = function() search.redraw() end,
    })
  end,
}
