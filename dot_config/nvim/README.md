# Vim cheat sheet — Ta config personnalisée

> **Règle d'or** : `d` = détruire (jamais de registre) | `x` = couper | `y` = copier

---

## Niveau 1 — Survivre

| frappe | Ça fait quoi |
|---|---|
| `Esc` ou `Ctrl-C` | Sort du mode Insert, retour en Normal |
| `i` | insert **avant** le curseur |
| `a` | append = insert **après** le curseur |
| `o` | Insert dans une nouvelle ligne **en dessous** |
| `O` | Insert dans une nouvelle ligne **au-dessus** |
| `dd` | Détruire la ligne (via `d` → "hole noir" `"_")` |
| `yy` | Copier la ligne |
| `p` | Coller |
| `u` | **u**ndo, annule la dernière modif |
| `Ctrl-R` | **r**edo |
| `:w` | save (**write**) |
| `:q` | quit |

---

## Niveau 2 — Naviguer sans souris

| frappe | Ça fait quoi |
|---|---|
| `h j k l` | gauche, bas, haut, droite |
| `w` / `b` | mot suivant / mot précédent (**w**ord/**b**ack) |
| `25j` | Descend 25 lignes (avec tes **relativenumbers ±30**) |
| `gg` | Tout en **haut** du fichier |
| `G` | Tout en **bas** du fichier |
| `0` | Début de ligne |
| `$` | Fin de ligne |
| `%` | Saute sur l'autre **accolade correspondante** (`{` `(` `[`) |
| `/motif` | Cherche vers l'avant |
| `?motif` | Cherche vers l'arrière |
| `n` / `N` | Résultat suivant / précédent |

> **Ton hybrid** : Les 30 lignes **proches** du curseur sont en relatif → tu tapes juste `25j`  
> Les lignes **au-delà de 30** sont en absolu → tu tapes `:134` direct

---

## Niveau 3 — Opérateurs + motions (ta config perso)

> **La sentence Vim** : `{count}{opérateur}{motion}`  
> Ex: `2d3w` = détruis 2 mots × 3 = 6 mots

| frappe | Natif | **Ta config** |
|---|---|---|
| `x` | delete 1 char + copie | **`d` natif : couper (copie + supprime)** |
| `dd` | delete ligne + copie | **`"__dd` : détruit la ligne (pas de copie)** |
| `d{motion}` | delete + copie | **`"__d{motion}` : détruit, jamais de registre** |
| `xx` | `dd` natif (coupe ligne) | **coupe la ligne (couper)*** |
| `c{motion}` | delete + insert + copie | **`"__c{motion}` : change sans garder l'ancien** |
| `y{motion}` | copie | copie (inchangé) |
| `p` | colle | colle (visuel : `"_dP` = colle sans yank sélection) |

### Motions utiles avec `d`, `x`, `c`, `y`

| frappe | Ça fait quoi |
|---|---|
| `w` | un mot (**w**ord) |
| `W` | un WORD (include symboles) |
| `5j` | 5 lignes vers le bas |
| `%` | jusqu'à l'accolade correspondante |
| `$` | jusqu'à la fin de ligne |
| `0` | jusqu'au début de ligne |
| `gg` | tout en haut |
| `G` | tout en bas |
| `iw` | **i**nside **w**ord (mot sous curseur) |
| `ip` | **i**nside **p**aragraph (ligne de contexte) |
| `it` | **i**nside **t**ag (`<b>texte</b>`) |
| `i"` | **i**nside quotes `"texte"` |
| `i(` / `ib` | **i**nside (block), **i**nside bracket |
| `a"` | **a**round quotes (inclut les `"`) |
| `at` | around tag |
| `ab` | around block |

### Change vs Replace vs Substitute

| frappe | Ça fait quoi |
|---|---|
| `cc` | **C**hange **c**urrent line = detruit + Insert |
| `cw` | **C**hange **w**ord = detruit fin du mot + Insert |
| `ci"` | **C**hange **inside** quotes → Insert dans les `"..."` |
| `s` | **s**ubstitute 1 char = detruit char + Insert |
| `S` | **S**ubstitute line = detruit ligne entière + Insert |
| `r` | **r**eplace 1 char (pas d'Insert) |
| `R` | **R**eplace mode = écrase en avançant |
| `gu{motion}` | **g**o **u**pper → `guiw` = UPPERCASE inside word |
| `gU{motion}` | **g**o **U**PPER (mais shift = majuscul) |

### Jump & change lists

| frappe | Ça fait quoi |
|---|---|
| `Ctrl-O` | Retour à la position précédente (jump list) |
| `Ctrl-I` | Avance dans l'historique (jump list) |
| `:jumps` | Liste l'historique des sauts |
| `g;` | Position du dernier changement |
| `g,` | Position du prochain changement |
| `''` | Dernière ligne visitée |
| `` `` | Position exacte (ligne + colonne) |
| `'.` | Position de la dernière modif |

### Registres — ce que tu as simplifié

| registre | Ça contient |
|---|---|
| `""` (sans nom) | Par défaut (d/y/p sans nom) |
| `"0` | Dernier **y**ank propre (la copie) |
| `"1`..`"9` | Historique des anciennes suppressions (jetables) |
| `"a`..`"z` | Registres nommés (`"ayy` → copie dans `a`, `"ap` → colle) |
| `"_` | Trou noir poubelle. **Tout ton `d`, `c`, `x`, `p` en visuel y passe** |

---

## Règles d'or de ta config

1. **`d` ne paste pas** → détruire = jamais de surprise ✔
2. **`x` = nouveau `d` natif** → c'est ton couper par défaut ✔
3. **Tout est dans les motions** → `dw` > `dw` > `xd` (qui ne marchait pas)
4. **`p` en visuel ne detruit pas le registre** → sélectionne `v`, `p`, le trou noir mange l'ancien ✔
5. **Hardmode actif** → les flèches/`PageUp`/`PageDown` sont bloquées
6. **`x` sur 1 char** = couper 1 char (inversion « xp » devient « xp » native qui coupe? Non `xp` natif = cut+p ut. Tu joues avec `x` et `p`)

---

*Config source : `~/.config/nvim/lua/delete.lua` + `hardmode.lua` + `statuscol.nvim`*
