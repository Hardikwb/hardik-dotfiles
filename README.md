# hardik-dotfiles

Hardik's cross-platform developer environment, managed with **chezmoi**.

The design is intentionally aligned with [kunchenguid/dotfiles](https://github.com/kunchenguid/dotfiles): one repository, a repeatable bootstrap path, shell/editor/terminal/agent configuration in the same source of truth, and a clear boundary between authored configuration and runtime state. The original repo is Mac-specific and uses nix-darwin + Home Manager; this repo uses chezmoi so the same source can serve Windows today and WSL/Linux later.

## Target architecture

```text
Windows
├── WezTerm          (native Windows app)
├── PowerShell       (native Windows shell)
├── CMD              (native Windows shell)
├── Herdr            (native Windows app/CLI)
└── chezmoi
    └── config source state

WSL / Linux
├── bash / zsh
├── Neovim
├── Git + CLI tools
├── Herdr
└── chezmoi
    └── same Git repo, Linux-specific targets
```

WezTerm stays on Windows when you use WSL: WezTerm is the terminal application, while the process/shell it starts can be inside WSL.

## First machine: bootstrap chezmoi

Install chezmoi with the official Windows installer:

```powershell
iex "&{$(irm 'https://get.chezmoi.io/ps1')}"
```

Or use your package manager if you prefer.

Then initialize this repository. Replace the URL with your actual GitHub repository:

```powershell
chezmoi init https://github.com/YOUR_USERNAME/hardik-dotfiles.git
```

**Do not apply yet.** First inspect:

```powershell
chezmoi status
chezmoi diff
```

This is intentional: the current laptop already has working PowerShell/CMD/WezTerm/Herdr configuration, so we import it instead of overwriting it with guessed defaults.

## Import the existing configuration

Use chezmoi to capture the configuration that is already working on this laptop. This is safer than replacing it with a guessed template.

```powershell
chezmoi add $PROFILE
chezmoi add "$HOME\.config\wezterm\wezterm.lua"
chezmoi add "$env:APPDATA\herdr\config.toml"
chezmoi add "$HOME\.config\nvim"
```

Then review:

```powershell
chezmoi status
chezmoi diff
```

The important rule is: **import your real current files first; do not replace working configuration with placeholders.**

## Daily workflow

Reference-repo equivalent:

```text
edit → rebuild
```

chezmoi equivalent:

```text
edit source / `chezmoi edit` → `chezmoi diff` → `chezmoi apply`
```

Useful commands:

```powershell
chezmoi edit $PROFILE
chezmoi diff
chezmoi apply
chezmoi status
chezmoi doctor
chezmoi cd
```

Use normal Git commands inside the chezmoi source directory:

```powershell
chezmoi cd
git status
git add .
git commit -m "Update terminal config"
git push
exit
```

## New laptop

After installing Git and chezmoi on the new Windows laptop:

```powershell
chezmoi init --apply https://github.com/YOUR_USERNAME/hardik-dotfiles.git
```

For a safer first run, prefer:

```powershell
chezmoi init https://github.com/YOUR_USERNAME/hardik-dotfiles.git
chezmoi diff
chezmoi apply
```

The official chezmoi workflow supports this exact `init --apply` pattern for a fresh machine.

## WSL / Linux

Install chezmoi inside WSL using its official installer, then initialize the **same repository**:

```bash
sh -c "$(curl -fsLS https://get.chezmoi.io)"
chezmoi init https://github.com/YOUR_USERNAME/hardik-dotfiles.git
```

Review before applying:

```bash
chezmoi diff
```

Then:

```bash
chezmoi apply
```

The repo uses `.chezmoiignore.tmpl` so Windows-only provisioning is skipped on Linux/WSL and vice versa.

## What is shared vs platform-specific?

Shared examples:

- Starship baseline
- Neovim configuration
- AI-agent policy (`AGENTS.md`)
- WezTerm configuration where the same file can be portable

Windows-specific:

- PowerShell profile
- CMD AutoRun helper
- Windows package installation
- Windows Herdr config path (`%APPDATA%\\herdr\\config.toml`)

Linux/WSL-specific:

- bash/zsh
- apt bootstrap
- Linux Herdr config path (`~/.config/herdr/config.toml`)

## Important boundary: installed software vs configuration

chezmoi manages the **desired state of your files and scripts**. It is not a universal package manager.

This repo therefore uses:

- `winget` for the Windows terminal/dev baseline
- `apt` for the WSL/Linux baseline
- official installers where a tool is intentionally distributed that way (for example, Herdr)

Herdr currently publishes native Windows, Linux, and macOS binaries. The Windows installer is documented by Herdr as the normal stable Windows installation path.

## Safety rules

Do not put secrets into this repository. Do not manage agent sessions, caches, downloaded package trees, or authentication databases. See `docs/secrets.md`.

The high-agency aliases from the reference repo (`claude --dangerously-skip-permissions` and `codex --full-auto`) are **commented out by default** here. Add them only after you explicitly decide you want that behavior.
