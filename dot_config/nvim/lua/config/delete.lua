-- PHILOSOPHIE : d = détruire (jamais de registre) | x = couper | y = copier

-- d = DÉTRUIRE, dans tous les cas : dd, dw, dG, d5j, di(, sélection visuelle...
-- (Le mapping en mode 'n' intercepte le d avant la motion : c'est lui qui
-- fait que dG → "_dG automatiquement.)
vim.keymap.set({ 'n', 'x' }, 'd', '"_d', { desc = "Détruire (sans yank)" })
vim.keymap.set({ 'n', 'x' }, 'D', '"_D', { desc = "Détruire jusqu'à fin de ligne" })

-- x = COUPER, dans tous les cas : xw, xG, x5j, xi(, sélection visuelle...
vim.keymap.set({ 'n', 'o', 'x' }, 'x', 'd', { desc = "Couper (cut)" })
-- Le mode 'o' (operator-pending) est indispensable : c'est lui qui permet
-- que « xx » fonctionne (= dd : couper la ligne entière)

-- X : détruire le caractère avant le curseur (sans yank)
vim.keymap.set('n', 'X', '"_X', { desc = "Détruire caractère avant curseur" })

-- c/C : changer sans garder l'ancien texte dans le registre
vim.keymap.set({ 'n', 'x' }, 'c', '"_c')
vim.keymap.set({ 'n', 'x' }, 'C', '"_C')

-- p en visuel : coller sans que la sélection écrasée pollue le registre
vim.keymap.set('x', 'p', '"_dP', { desc = "Coller sans yanker la sélection" })
