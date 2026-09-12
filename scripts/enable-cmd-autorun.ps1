$ErrorActionPreference = 'Stop'

$profile = Join-Path $HOME 'AppData\Local\hardik-dotfiles\cmd\profile.cmd'
if (-not (Test-Path -LiteralPath $profile)) {
    throw "CMD profile does not exist yet: $profile"
}

$key = 'HKCU:\Software\Microsoft\Command Processor'
$managed = '"' + $profile + '"'
New-Item -Path $key -Force | Out-Null
$current = (Get-ItemProperty -Path $key -Name AutoRun -ErrorAction SilentlyContinue).AutoRun

if ([string]::IsNullOrWhiteSpace($current)) {
    Set-ItemProperty -Path $key -Name AutoRun -Value $managed
} elseif ($current -notlike '*hardik-dotfiles*') {
    Set-ItemProperty -Path $key -Name AutoRun -Value ($current + ' & ' + $managed)
}

Write-Host "CMD AutoRun now includes: $profile"
