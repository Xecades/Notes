# Vim Cheatsheet

Note that this cheatsheet is almost completely based on my [lunarvim](https://www.lunarvim.org/) configuration and **may only be intended for my personal use**.

---

## Navigation

 - `h` `j` `k` `l`: **left / down / up / right**
 - `w` `b`: **next / previous** word
 - `gg` `G`: **top / bottom** of file
 - `0` `$`: **beginning / end** of line
 - `^`: first non-blank character of line
 - `<C-d>` `<C-u>`: half page **down / up**
 - `<C-f>` `<C-b>`: full page **down / up**
 - `zt` `zz` `zb`: scroll cursor to **top / middle / bottom** of screen
 - `%`: jump to matching bracket

---

## Editing

 - `i` `a`: insert **before / after** cursor
 - `I` `A`: insert at **beginning / end** of line
 - `o` `O`: insert new line **below / above**
 - `x`: delete character under cursor
 - `rW`: replace character under cursor with `W`
 - `R`: start replace mode
 - `cw`: change word
 - `c$`: change to end of line
 - `cc`: change line
 - `dd`: delete line
 - `u` `<C-r>`: **undo / redo**
 - `~`: switch case of character under cursor
 - `y`: copy text
 - `p`: paste after cursor

---

## Search

 - `/`: search forward
 - `?`: search backward
 - `n` `N`: **next / previous** match
 - `*` `#`: search for word under cursor **forward / backward**
 - `gd`: go to definition of word under cursor
 - `gi`: go to last insert position

---

## Visual

 - `v`: start visual mode
 - `V`: start visual line mode
 - `<C-v>`: start visual block mode
 - `gv`: re-select last visual selection
 - `o`: move to other end of highlighted text
 - `a"` `a'` `a(` `a[` `a{`: select matching block
 - `i"` `i'` `i(` `i[` `i{`: select inner matching block

---

## Substitution

 - `:s/foo/bar/`: replace first `foo` with `bar` in current line
 - `:%s/foo/bar/`: replace first `foo` with `bar` in file

Flags:

 - No flag: replace first occurrence
 - `g`: replace all occurrences
 - `c`: confirm before replace
 - `i`: case-insensitive
 - `I`: case-sensitive

