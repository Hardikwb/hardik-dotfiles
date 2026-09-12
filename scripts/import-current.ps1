$ErrorActionPreference = 'Stop'

if (-not (Get-Command chezmoi -ErrorAction SilentlyContinue)) {
    throw 'chezmoi is not installed. Install it first, then rerun this script.'
}

Write-Host '==> Importing existing Windows configuration into chezmoi'

$targets = @(
    $PROFILE,
    (Join-Path $HOME '.config\wezterm\wezterm.lua'),
    (Join-Path $env:APPDATA 'herdr\config.toml'),
    (Join-Path $HOME '.config\nvim')
)

foreach ($target in $targets) {
    if (Test-Path -LiteralPath $target) {
        Write-Host "    chezmoi add: $target"
        & chezmoi add --follow $target
    } else {
        Write-Host "    skip (not present): $target"
    }
}

Write-Host ''
Write-Host 'Review the result with:'
Write-Host '  chezmoi status'
Write-Host '  chezmoi diff'
Write-Host ''
Write-Host 'Do NOT add secrets, API keys, private keys, tokens, or agent runtime/cache directories.'
