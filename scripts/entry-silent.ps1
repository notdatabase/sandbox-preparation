$scriptUrl = "https://raw.githubusercontent.com/notdatabase/sandbox-preparation/main/scripts/silent.ps1"

Invoke-WebRequest -Uri $scriptUrl -OutFile $env:temp\sandboxprimer.ps1

Set-ExecutionPolicy Bypass -Scope Process -Force

Start-Process powershell -ArgumentList "-File $env:temp\sandboxprimer.ps1"