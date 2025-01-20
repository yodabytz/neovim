# Neovim Configuration with Tokyo Night Theme

This repository contains a modern and feature-rich Neovim configuration using the **Tokyo Night** colorscheme (Night variant). It is built with the **lazy.nvim** plugin manager and includes features like LSP, Treesitter, Telescope, and more. The configuration is designed to provide an intuitive development environment with advanced syntax highlighting, intelligent auto-completion, powerful file search, and modern aesthetics.

## Prerequisites

Before using this configuration, ensure the following are installed on your system:

1. **Neovim** (v0.8 or later)
2. **Git** for cloning repositories
3. **Node.js** (required for some LSP servers like TypeScript/JavaScript)
4. **Python** with the `pynvim` package installed
5. **Go** (required for the `gopls` LSP server)
6. **GCC/Build tools** (required for compiling Treesitter parsers)

## Installation

To set up this configuration, follow these steps:

1. Install Neovim using your system's package manager or from the official website. For Ubuntu/Debian, run `sudo apt update && sudo apt install neovim`. For Arch Linux, run `sudo pacman -S neovim`. For macOS, use Homebrew with `brew install neovim`. For Windows, download the latest release from the [Neovim GitHub page](https://github.com/neovim/neovim/releases).

2. Clone this repository into your Neovim configuration directory by running `git clone https://github.com/yodabytz/neovim.git ~/.config/nvim`.

3. Install Node.js. For Ubuntu/Debian, run `sudo apt install nodejs npm`. For macOS, use `brew install node`. For Windows, download Node.js from [https://nodejs.org](https://nodejs.org).

4. Install Python and ensure the `pynvim` module is available by running `python3 -m pip install --user pynvim`.

5. Install Go from the [official Go website](https://go.dev/dl/) and verify the installation by running `go version`.

6. Open Neovim by typing `nvim` in your terminal. The `lazy.nvim` plugin manager will automatically initialize and install all required plugins. Once inside Neovim, run `:Lazy sync` to ensure all plugins are properly installed.

## Features and Key Mappings

This configuration includes the following features:

1. **Tokyo Night Theme**: A vibrant and sleek colorscheme with multiple variants (Night, Storm, Moon, and Day).
2. **LSP Support**: Preconfigured for popular languages like Lua, Python, TypeScript, Rust, and more.
3. **Treesitter**: Advanced syntax highlighting and better code parsing.
4. **Telescope**: A fuzzy finder for files, text, and more.
5. **Neo-tree**: A modern file explorer.
6. **Alpha**: A custom startup screen for Neovim.

Key mappings are provided for quick and efficient navigation:

- `<Space>ff`: Open Telescope and find files in the current project.
- `<Space>fg`: Perform a live grep search for text across files.
- `<Space>fb`: Switch between open buffers.
- `<Space>fh`: Open Neovim's help documentation.
- `gd`: Go to the definition of a symbol.
- `gr`: List all references to a symbol.
- `K`: Hover to view documentation for the symbol under the cursor.
- `<leader>rn`: Rename a symbol across the project.

To open the file explorer, use the `:Neotree` command.

## Troubleshooting

If you encounter issues with this configuration, refer to the following tips:

1. If you see `Undefined global 'vim'` warnings, ensure your Lua LSP server is properly configured to recognize Neovim's runtime. This is handled automatically in this setup.
2. For errors related to Treesitter, run `:TSUpdate` inside Neovim to update parsers.
3. If plugins are missing or not working, run `:Lazy sync` to reinstall and sync all plugins.

## Contributing

If you'd like to contribute to this project, feel free to open issues or submit pull requests. Suggestions for improvements, additional features, or bug fixes are always welcome.

## License

This configuration is open-source and is distributed under the MIT License.
