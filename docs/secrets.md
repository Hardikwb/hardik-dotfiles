# Secrets policy

Never commit:

- API keys
- OAuth tokens
- SSH private keys
- cloud credentials
- AI provider credentials
- database passwords
- machine-specific authentication state
- Claude/Codex/Pi session databases, caches, or credential stores

For secrets, use your password manager / OS credential store or chezmoi's encryption features once the baseline is stable.
