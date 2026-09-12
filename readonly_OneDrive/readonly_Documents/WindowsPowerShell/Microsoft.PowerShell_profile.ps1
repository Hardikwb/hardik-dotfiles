function prompt {

    $desktop = "C:\Users\hghar\OneDrive\Desktop"
    $path = (Get-Location).Path

    # Replace Desktop with ~
    if ($path.StartsWith($desktop)) {
        $path = "~" + $path.Substring($desktop.Length)
    }

    # Show only the last two folders
    if ($path -like "~\*") {
        $parts = $path -split "\\"

        if ($parts.Count -gt 3) {
            $path = "~\" + ($parts[-2..-1] -join "\")
        }
    }

    Write-Host $path -ForegroundColor Cyan -NoNewline
    Write-Host " >" -ForegroundColor DarkGray -NoNewline

    return " "
}