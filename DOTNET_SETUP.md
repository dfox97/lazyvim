# C# / .NET / Blazor / Razor Configuration for Neovim

## ⚠️ Neovim Version Compatibility

This configuration is designed for **Neovim 0.11.x**. The roslyn.nvim plugin has been pinned to a compatible version (`f2ec6ee`) that works with Neovim 0.11.x.

If you upgrade to Neovim 0.12+ in the future, you can remove the `commit = "f2ec6ee"` line from `lua/plugins/roslyn.lua` to get the latest features.

## Overview
Your Neovim is now configured with **Roslyn** (Microsoft's official C# LSP) instead of the legacy OmniSharp. This provides:

- ✅ **Faster performance** and better responsiveness
- ✅ **Full Razor/Blazor/CSHTML support** via co-hosted Razor LSP
- ✅ **Modern C# features** (.NET 8/9, source generators)
- ✅ **Better code actions** and refactoring
- ✅ **Organize imports on format**
- ✅ **Inlay hints** (type hints and parameter names)
- ✅ **Code lens** (reference counts)

## Files Modified

1. **`lua/plugins/roslyn.lua`** (NEW)
   - Main Roslyn LSP configuration
   - Razor/Blazor support setup
   - Inlay hints, code lens, completion settings

2. **`lua/plugins/core.lua`**
   - Added custom Mason registry for Roslyn/rzls
   - Added `roslyn`, `rzls`, `csharpier` to ensure_installed
   - Added `razor` to treesitter parsers
   - Registered `.razor` and `.cshtml` filetypes

3. **`lua/plugins/lsp.lua`**
   - Removed conflicting OmniSharp configuration
   - Added comment noting Roslyn usage

4. **`lua/plugins/lint.lua`**
   - Added CSharpier formatter for C# files

## First-Time Setup

### 1. Open Neovim and Install Dependencies
```bash
nvim
```

Inside Neovim:
```vim
:Mason
```

Install these packages:
- `roslyn` (Microsoft's C# LSP)
- `rzls` (Razor language server)
- `csharpier` (C# formatter)

Or run:
```vim
:MasonInstall roslyn rzls csharpier
```

### 2. Verify Installation
Open any `.cs`, `.razor`, or `.cshtml` file. You should see:
- LSP attaching notification (bottom right)
- Completions working
- Diagnostics showing

## Available Commands

### Roslyn Commands
- `:Roslyn target` - Switch between multiple solution files
- `:Roslyn restart` - Restart the LSP
- `:Roslyn start` - Start the LSP
- `:Roslyn stop` - Stop the LSP

### Standard LSP (works with C#)
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>f` - Format document (uses CSharpier)

## Configuration Highlights

### Inlay Hints (Type Hints)
Enabled by default. Shows types for:
- Implicit variable types (`var`)
- Lambda parameters
- Object creation (`new` expressions)
- Method parameters

**Toggle:** Use your Neovim inlay hint toggle (check your keymaps)

### Code Lens
Shows reference counts above methods/classes (e.g., "3 references")

### Formatting
- **CSharpier** is configured as the formatter
- **Organize imports** happens automatically on format
- **Format on save** is enabled (LazyVim default)

### Razor/Blazor Support
- `.razor` files: Full LSP support (completions, diagnostics, go-to-definition)
- `.cshtml` files: Same support via `razor` filetype
- Cohosted with Roslyn for seamless integration

## Troubleshooting

### "Roslyn not found"
1. Run `:MasonInstall roslyn`
2. Verify custom registry is loaded (check `lua/plugins/core.lua`)

### "Razor files not working"
1. Install `rzls` via Mason: `:MasonInstall rzls`
2. Check that `.razor` files show filetype as `razor` (run `:set filetype?`)

### Multiple Solutions
If you have multiple `.sln` files:
- Roslyn will ask which to use on first open
- Use `:Roslyn target` to switch anytime
- Set `lock_target = true` in `roslyn.lua` to always use first found

### Performance Issues
In `roslyn.lua`, you can change:
```lua
filewatching = "off"  -- Disable all file watching
```

## Next Steps

1. **Open a C# project** and test:
   - Open a `.cs` file
   - Check completions with `<C-Space>`
   - Try `gd` on a type

2. **Open a Razor/Blazor file**:
   - Open `.razor` or `.cshtml`
   - Verify Razor syntax highlighting
   - Test completions inside `@code` blocks

3. **Customize if needed**:
   - Edit `lua/plugins/roslyn.lua` to adjust inlay hints, code lens, etc.
   - Add keybindings for C#-specific actions

## Resources

- [roslyn.nvim documentation](https://github.com/seblyng/roslyn.nvim)
- [LazyVim Dotnet Extra](https://www.lazyvim.org/extras/lang/dotnet) (uses OmniSharp, not needed with this setup)
- [CSharpier documentation](https://csharpier.com/)

## Migration from OmniSharp

If you had OmniSharp configs elsewhere:
- This setup **replaces** all OmniSharp functionality
- Old OmniSharp extensions/plugins may conflict
- Remove any other `omnisharp` references in your config

## Questions?

Check `:checkhealth lsp` to verify LSP status
Run `:LspInfo` to see attached language servers
