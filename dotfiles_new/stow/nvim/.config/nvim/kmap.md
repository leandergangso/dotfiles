# Keymaps suggestion from AI

Most Common Keymaps (Typically used with Plugins and Custom Configurations)

These keymaps are commonly set up in Neovim configurations or are used with popular plugins like telescope.nvim, lualine.nvim, or which-key.nvim:
File Navigation

    <leader>ff: Find a file (commonly with telescope.nvim).
    <leader>fg: Live grep search (commonly with telescope.nvim).
    <leader>fb: Find a buffer (commonly with telescope.nvim).
    <leader>fr: Find recent files (commonly with telescope.nvim).

Buffer and Window Navigation

    <leader>bd: Delete the current buffer (close file).
    <leader>bo: Close all other buffers.
    <leader>w: Save the current file.
    <leader>q: Quit Neovim.
    Ctrl + w + h/j/k/l: Move between split windows (left, down, up, right).
    <leader>s: Split window horizontally or vertically (common with plugins like vim-splitter).
    <leader>ww: Switch between windows (e.g., vim-windows).

Search and Replace

    /: Search forward.
    ?: Search backward.
    n: Go to the next match.
    N: Go to the previous match.
    :%s/old/new/g: Replace all occurrences of old with new in the file.

Undo/Redo and History

    u: Undo last change.
    Ctrl + r: Redo last undone change.
    <leader>u: Undo changes (in some custom setups).
    <leader>r: Redo changes (in some custom setups).

Clipboard Operations

    "+y: Yank to system clipboard (copy).
    "+p: Paste from system clipboard (paste).
    "+d: Delete and copy to system clipboard.

Code Editing

    <leader>c: Comment or uncomment a line (depending on plugins like Comment.nvim).
    <leader>f: Format the code (with formatters like black, prettier, or clang-format).
    <leader>a: Auto-pairing brackets, parentheses, etc. (with plugins like nvim-autopairs).
    <leader>r: Rename symbol (using LSP or telescope).

LSP and Diagnostics

    gd: Go to definition (with LSP).
    gr: Go to references (with LSP).
    <leader>ca: Code action (with LSP).
    <leader>rn: Rename symbol (with LSP).
    <leader>v: Show diagnostics (using nvim-lspconfig).
    [d / ]d: Previous/next diagnostic.

Which Key

    <leader>: Open the which-key.nvim popup menu (shows available key mappings).

Summary of Common Leader Key

In many Neovim configurations, the leader key is often mapped to the spacebar (<leader> = <space>). This allows you to create custom keymaps, such as:

    <leader>f: Find files.
    <leader>b: Switch buffers.
    <leader>w: Save the file.
    <leader>q: Quit Neovim.

This gives you a centralized, easy-to-remember set of keybindings for various tasks.
You said:
what about for buffer navigation/move etc
ChatGPT said:

Here are the default and most common keymaps for buffer navigation and movement in Neovim, including both built-in commands and common configurations often used in setups with plugins:
Default Neovim Keymaps for Buffer Navigation
Buffer Switching

    :bnext or :bn: Go to the next buffer.
    :bprev or :bp: Go to the previous buffer.
    :bfirst: Go to the first buffer.
    :blast: Go to the last buffer.
    :b <number>: Switch to a buffer by number (e.g., :b 2 to switch to buffer 2).

Buffer Deletion (Close Buffer)

    :bd: Delete the current buffer (close the file).
    :bw: Delete the current buffer and close its window.
    <leader>bd (with custom configuration): Close the current buffer (often mapped in custom setups).

Navigating Between Buffers

    Ctrl + w + w: Switch between windows (buffers) in a round-robin fashion.
    Ctrl + w + h/j/k/l: Navigate between split windows (left, down, up, right).

Most Common Buffer Navigation Keymaps

These keymaps are often found in custom configurations or with popular plugins like bufferline.nvim, barbar.nvim, or vim-buffet:
Buffer Switching (Common with bufferline.nvim or barbar.nvim)

    <leader>1 to <leader>9: Switch to the respective buffer by number (e.g., <leader>1 for the first buffer, <leader>2 for the second, etc.).
    <Tab>: Go to the next buffer.
    <S-Tab>: Go to the previous buffer.
    <leader>bb: Open the buffer list (common with plugins like bufferline.nvim or barbar.nvim).

Buffer Deletion

    <leader>bd: Close the current buffer (common with which-key.nvim or other custom setups).
    <leader>bw: Close the current buffer and window (common in certain custom setups).
    :bd!: Forcefully delete the current buffer without saving (warning: this can lose unsaved changes).

Buffer Navigation via Ctrl-w

    Ctrl-w h/j/k/l: Navigate between split windows (left, down, up, right).
    Ctrl-w w: Switch to the next window.
    Ctrl-w H/J/K/L: Move the current window to the far left, down, up, or right (useful for reordering splits).
    Ctrl-w s: Split the current window horizontally.
    Ctrl-w v: Split the current window vertically.

Switching Between Buffers

    <leader>bb: Show buffer list and switch buffers.
    <leader>bp: Switch to the previous buffer (using telescope.nvim or custom mappings).
    <leader>bn: Switch to the next buffer (using telescope.nvim or custom mappings).

Other Common Keymaps for Buffer Navigation

    <leader>ba: Switch to the alternate buffer (i.e., the last used buffer).
    <leader>bl: List open buffers.
    <leader>bf: Find a buffer (commonly with telescope.nvim).
    <leader>bq: Quit all buffers (useful for quitting all windows and buffers).

Additional Plugins for Buffer Navigation

Here are some plugins that offer advanced buffer management features, which can be mapped to custom keybindings:

    bufferline.nvim: Provides a tab-like interface to switch between buffers.
        <leader>1 to <leader>9: Switch to buffer 1 through 9.
        <leader>bb: Open buffer list to switch between buffers.

    barbar.nvim: Another popular buffer/tabline plugin.
        <leader>bb: Switch between buffers.
        <leader>bp: Switch to the previous buffer.
        <leader>bn: Switch to the next buffer.

    vim-buffet: A simpler plugin to manage buffers.
        <leader>bb: Toggle between buffers.
        <leader>bd: Close the current buffer.

Summary of Common Buffer Navigation Keymaps
Built-in Commands

    :bnext, :bn`: Next buffer.
    :bprev, :bp`: Previous buffer.
    :bd: Close current buffer.
    :bw: Close current buffer and window.

Custom or Plugin-based

    <Tab>: Next buffer.
    <S-Tab>: Previous buffer.
    <leader>1 to <leader>9: Switch to the respective buffer by number.
    <leader>bb: Open buffer list.
    <leader>bd: Close current buffer (commonly mapped).

These keymaps for buffer navigation help improve efficiency when switching between multiple files, especially in larger projects. If you're using plugins like bufferline.nvim or barbar.nvim, they offer additional ways to manage and navigate buffers more visually and intuitively.
