# Neovim Event Matrix (Autocmds)

A complete, scannable reference guide for Neovim automation, plugin lazy-loading, and configuration lifecycle triggers.

---

## 1. Startup & Initialization
Use these events to optimize startup timing or lazy-load heavy UI elements without blocking the initial screen paint.

| Event | Trigger Sequence & Timing | Primary Use Cases |
| :--- | :--- | :--- |
| `UIEnter` | Fires the exact millisecond a user interface (TUI, Neovide, VSCode) connects to the Neovim core engine. | **The best trigger for UI plugins** (Telescope, Neo-tree, dressing.nvim, dashboard). Runs right after the screen draws. |
| `VimEnter` | Fires after all startup processing is complete, `init.lua` is fully parsed, and CLI-passed files are loaded. | Broad post-startup settings, opening a file explorer fallback if Neovim is opened without files, setting up terminal titles. |
| `OptionSet` | Fires immediately after any Neovim option (`background`, `shiftwidth`, etc.) is changed. | Hooking reactive behaviors to configuration toggles (e.g., dynamically matching a theme when switching `background=light/dark`). |

---

## 2. Buffer & File Lifecycle
These events handle file handling mechanics, file-type specific configurations, and save-time automations.

| Event | Trigger Sequence & Timing | Primary Use Cases |
| :--- | :--- | :--- |
| `BufNewFile` | Triggers when editing a path that does not exist yet. | Injecting skeleton templates, copyright headers, or boilerplate structures for fresh files. |
| `BufReadPre` | Fires right *before* Neovim parses and reads a file's content into a buffer memory block. | Checking file sizes to disable heavy features (like treesitter) on huge log files. |
| `BufReadPost` | Fires right *after* file contents are loaded into a buffer. | Restoring cursor position from the last session, setting local text wraps. |
| `FileType` | Fires when Neovim successfully matches a file extension or content pattern to a language. | **The absolute gold standard for language-specific lazy loading.** Load snippets, linters, or custom formatters. |
| `BufWritePre` | Fires right *before* the buffer buffer content is flushed and written to disk. | Formatting code on save, removing trailing white spaces, updating file modification tags. |
| `BufWritePost` | Fires right *after* file writes successfully complete on disk. | Triggering hot-reloads, compiling assets, reloading configurations on save. |
| `BufDelete` | Fires just before a buffer is completely wiped out from memory. | State cleanup, tracking workspace files, closing floating companion windows. |

---

## 3. Real-time Interactions & Editing Lifecycle
Enhance day-to-day text-manipulation, diagnostics, or modal editing mechanics.

| Event | Trigger Sequence & Timing | Primary Use Cases |
| :--- | :--- | :--- |
| `InsertEnter` | Instantly upon entering Insert mode. | Lazy loading completion engines (`blink.cmp`, `nvim-cmp`), active bracket pair matchers, or auto-pairing engines. |
| `InsertLeave` | The millisecond you exit back into Normal mode. | Instantly cleaning up trailing whitespaces, hiding autocompletion popups, or triggering auto-saves. |
| `TextYankPost` | Immediately after text is yanked or copied. | Creating a brief flash visual highlight over the yanked region to give visual feedback. |
| `CursorHold` | Triggers when the cursor is kept entirely stationary for a configured duration (`set updatetime`). | Triggering LSP hover windows, showing inline signature parameters, displaying Git blame logs. |
| `LspAttach` | Fires as soon as an LSP client safely attaches to the current active buffer. | Creating buffer-local keymaps for LSP actions (Go-To-Definition, Rename, Code Actions). |

---

## 4. Teardown & Exit
Preserve application layouts, workspaces, or clear out locks before terminating.

| Event | Trigger Sequence & Timing | Primary Use Cases |
| :--- | :--- | :--- |
| `VimLeavePre` | Triggers right before Neovim initializes its final closing procedures. | Generating workspace sessions (`possession.nvim`), preserving global project flags. |
| `VimLeave` | The very final instruction phase before the Neovim process officially terminates. | Restoring your main host system terminal cursor shape, wiping out system lockfiles. |

---

### 💡 Pro-Tips
* **Check Live Autocmds:** Run `:autocmd` within Neovim to inspect every currently registered listener and discover hidden event hooks.
* **Avoid Duplication:** Always wrap custom events inside an explicit `nvim_create_augroup` with `clear = true` to prevent memory leaks when reloading configurations.
