# CMD

CMD has no profile file equivalent to PowerShell. This repo treats a CMD helper script as the source of truth and optionally wires it into `HKCU\Software\Microsoft\Command Processor\AutoRun`.

First import your existing CMD customizations into:

`%USERPROFILE%\AppData\Local\hardik-dotfiles\cmd\profile.cmd`

Then run:

```powershell
.\scripts\enable-cmd-autorun.ps1
```

This preserves an existing AutoRun value and appends the managed profile once.
