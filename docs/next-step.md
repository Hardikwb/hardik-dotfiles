# Next step

1. Initialize chezmoi against the GitHub repo.
2. Import the actual current PowerShell, WezTerm, Herdr, and Neovim configuration.
3. Review `chezmoi diff` and apply only after the diff is correct.
4. Commit the real imported files to GitHub.
5. Add WSL/Linux targets after the Windows source of truth is stable.

Do not invent replacements for working configuration: import the live state first, then refactor it.
