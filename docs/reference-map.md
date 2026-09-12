# Reference mapping: kunchenguid/dotfiles → hardik-dotfiles

The reference repo is a Mac setup built with nix-darwin + Home Manager. This repo keeps its useful architecture without copying the Mac-specific implementation.

| Reference | hardik-dotfiles |
|---|---|
| `bootstrap.sh` | chezmoi install/init + `run_onchange_` provisioning |
| `flake.nix` | `.chezmoiignore.tmpl`, templates, scripts, local chezmoi config |
| `configuration.nix` | Windows `winget` / WSL package bootstrap and other OS-specific scripts |
| `home.nix` | target files + templates managed by chezmoi |
| `home/` actual config files | chezmoi source state itself |
| `rebuild.sh` | `chezmoi apply` / `chezmoi update` |
| `mkOutOfStoreSymlink` edit-in-place model | chezmoi source state + `chezmoi edit` |
| shared `AGENTS.md` | `.chezmoitemplates/AGENTS.md` rendered into Claude/Codex/OpenCode |
| Homebrew/Nix packages | Windows `winget`, WSL `apt`, tool-specific official installers |

The reference explicitly keeps runtime/authentication state out of the managed authored files. This repo follows the same boundary.
