# Architecture

This repo follows the useful architecture of `kunchenguid/dotfiles`, but replaces its Mac-only nix-darwin/Home Manager layer with chezmoi so the same repository can serve Windows today and WSL/Linux later.

## Reference concepts retained

- One Git repository is the source of truth.
- A bootstrap path takes a fresh machine to a working environment.
- Common user configuration is separated from platform-specific machine setup.
- Terminal, editor, shell, and coding-agent configuration are first-class parts of the environment.
- Runtime/authentication state is deliberately not managed.
- Changes are made in the source state and then applied to the live home directory.

The reference repo uses nix-darwin + Home Manager and links authored files from its repo into the home directory. It also shares one `AGENTS.md` across Claude, Codex, and OpenCode. See:
https://github.com/kunchenguid/dotfiles

## How chezmoi maps the same idea

```text
GitHub repo
    |
    v
chezmoi source state (~/.local/share/chezmoi)
    |
    +-- templates / platform conditionals
    +-- authored config
    +-- run_onchange_ bootstrap scripts
    |
    v
live home directory
```

Unlike the reference repo's `mkOutOfStoreSymlink` approach, this setup uses chezmoi as the source-of-truth/edit/apply mechanism. This avoids depending on a fixed `~/.dotfiles` path and works cleanly across Windows and Linux.
