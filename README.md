# 💤 LazyVim - Full‑Stack Web Dev Setup

A tailored LazyVim configuration optimized for **full‑stack web development**, with a focus on **Angular**, **Node.js**, and modern JavaScript/TypeScript workflows.

## ✨ Features
- Angular‑friendly LSP, formatting, and diagnostics
- Node.js debugging and tooling integrations
- Git enhancements with diffs, signs, and inline blame
- Fuzzy finding, file navigation, and AI‑assisted coding
- Sensible defaults from LazyVim, extended for real‑world dev work

## 🚀 Getting Started
Clone this config into your Neovim directory:
```
git clone https://github.com/dfox97/lazyvim ~/.config/nvim
```
Open Neovim and Lazy will automatically install plugins and set up the environment.

## 🛠 Technologies Supported
- **Angular** (TS Server / Angular Language Service)
- **Node.js** (debugging, linting, formatting)
- **TypeScript & JavaScript**
- HTML, CSS, JSON, Markdown, and API workflows

## 📁 Structure Overview
Key config files inside `lua/`:
- `config/` – options, keymaps, autocmds, Lazy setup
- `plugins/` – custom plugin configs like LSP, DAP, Git tools, AI helpers

## 💡 Usage
- `<leader>ff` – find files
- `<leader>fg` – live grep
- `<leader>gd` – git diff view
- `<leader>rn` – rename symbol
- `<leader>ca` – code actions
- `<F5>` – start Node.js debug session

## 🤝 Notes
This setup is meant as a strong starting point for building Angular/Node projects efficiently. Feel free to extend it as your stack evolves.

Based on [LazyVim](https://github.com/LazyVim/LazyVim). Refer to the [documentation](https://lazyvim.github.io/installation) to get started.
