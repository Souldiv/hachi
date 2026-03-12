# macos-setup

Declarative macOS system configuration using [nix-darwin](https://github.com/LnL7/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager).

## What's included

**System (nix-darwin)**
- Nushell as default shell
- JetBrains Mono Nerd Font
- Homebrew integration
- Startup chime disabled, auto-restart on freeze

**Terminal stack**
- [Ghostty](https://ghostty.org/) terminal with Monokai Soda theme
- [Zellij](https://zellij.dev/) multiplexer with custom "hachi" purple theme and full keybind configuration
- [Nushell](https://www.nushell.sh/) shell
- [Starship](https://starship.rs/) prompt with nerd font symbols, git status, Kubernetes context, and Docker info

**Dev tools**
- VS Code with extensions (Claude Code, Nix IDE, Terraform, Markdown)
- kubectl, kubecolor, k9s

## Structure

```
flake.nix          # Flake definition — single darwin system "hachi"
configuration.nix  # System-level nix-darwin config
home.nix           # Home-manager — shell, editor, terminal, prompt
zellij.nix         # Zellij keybindings, plugins, and theme
```

## Usage

### Prerequisites

Install [Nix](https://nixos.org/download/) with flakes enabled.

### Apply

```sh
darwin-rebuild switch --flake .
```

### Update dependencies

```sh
nix flake update
darwin-rebuild switch --flake .
```

## Adapting for your own use

1. Replace `amrutphadke` with your macOS username in `configuration.nix` and `home.nix`
2. Update `homeDirectory` in `home.nix` to match your home path
3. Change the hostname from `hachi` in `flake.nix` if desired
4. Adjust packages and program configs to your preference
