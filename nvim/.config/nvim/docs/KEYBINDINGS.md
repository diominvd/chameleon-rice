# Neovim Keybindings Cheat Sheet

`<leader>` = Space | `<C-x>` = Ctrl+x | `<S-x>` = Shift+x

---

## NAVIGATION

**Basic Movement**
- `gg` - Go to file start
- `G` - Go to file end
- `<C-u>` - Page up (centered)
- `<C-d>` - Page down (centered)
- `n` - Next search result
- `N` - Previous search result

**Windows**
- `<C-h>` - Left window
- `<C-j>` - Bottom window
- `<C-k>` - Top window
- `<C-l>` - Right window

**Insert Mode**
- `jk` / `kj` - Exit insert mode

---

## FILES & BUFFERS

**File Operations**
- `<leader>w` - Save file
- `<leader>wq` - Save all and exit
- `<leader>qq` - Exit without saving
- `<leader>er` - Reload file

**Buffers**
- `<Tab>` - Next buffer
- `<S-Tab>` - Previous buffer
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer
- `<leader>x` - Delete current buffer
- `<leader>bd` - Delete buffer
- `<leader>ba` - Delete all buffers

---

## WINDOWS

- `<leader>sv` - Split vertical
- `<leader>sh` - Split horizontal
- `<leader>se` - Equalize sizes
- `<leader>sx` - Close window
- `<C-Up>` - Increase height
- `<C-Down>` - Decrease height

---

## TEXT EDITING

**Lines**
- `<leader>d` - Delete line
- `<leader>y` - Yank (copy) line
- `Y` - Yank to end of line

**Visual Mode**
- `v<` - Decrease indent (keep selection)
- `v>` - Increase indent (keep selection)
- `vJ` - Move selection down
- `vK` - Move selection up

**Comments**
- `gcc` - Toggle line comment
- `gbc` - Toggle block comment
- `gc<motion>` - Comment with motion

---

## SEARCH (TELESCOPE)

**Files**
- `<leader>ff` - Find files
- `<leader>fgf` - Find git files
- `<leader>fo` - Recent files
- `<leader>fb` - Find buffers

**Content**
- `<leader>fg` - Live grep (search content)
- `<leader>fw` - Search word under cursor
- `<leader>fs` - Fuzzy search in file

**Other**
- `<leader>fk` - Find keybindings
- `<leader>fh` - Find help
- `<Esc>` - Clear search highlights

---

## FILE EXPLORER (NEO-TREE)

- `<leader>e` - Toggle explorer
- `<leader>o` - Focus explorer
- `l` (in explorer) - Open/expand
- `h` (in explorer) - Close folder

---

## LSP

**Navigation**
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - Go to references

**Documentation**
- `K` - Hover documentation
- `<leader>lh` - Signature help

**Actions**
- `<leader>ca` - Code action
- `<leader>rn` - Rename symbol
- `<leader>fm` - Format buffer
- `<leader>fmt` - Format buffer

**Diagnostics**
- `[d` - Previous diagnostic
- `]d` - Next diagnostic
- `<leader>ld` - Line diagnostics
- `<leader>ll` - Location list

---

## COMPLETION

- `<C-Space>` - Trigger completion
- `<Tab>` - Next item / expand snippet
- `<S-Tab>` - Previous item
- `<C-b>` - Scroll docs up
- `<C-f>` - Scroll docs down
- `<CR>` - Confirm
- `<C-e>` - Abort

---

## GIT

**Navigation**
- `]c` - Next change
- `[c` - Previous change

**Actions**
- `<leader>hb` - Blame line
- `<leader>hp` - Preview hunk
- `<leader>hr` - Reset hunk

---

## TERMINAL

- `<C-t>` - Toggle terminal
- `<Esc>` (in terminal) - Exit terminal mode
- `<C-h/j/k/l>` (in terminal) - Navigate windows

---

## MOTION (FLASH)

- `s` - Flash jump
- `S` - Flash treesitter
- `r` - Remote flash
- `R` - Treesitter search

---

## AI

- `<leader>ai` - Toggle OpenCode window
- `<leader>af` - Focus OpenCode window

---

## WHICH-KEY

- `<Space>` - Show keybindings menu

---

## ESSENTIAL (LEARN FIRST)

- `<leader>ff` - Find files
- `<leader>fg` - Search content
- `<C-h/j/k/l>` - Window navigation
- `<leader>w` - Save
- `<leader>e` - File explorer
- `gd` - Go to definition
- `K` - Documentation
- `<leader>rn` - Rename
- `<leader>ca` - Code action
- `<C-t>` - Terminal

