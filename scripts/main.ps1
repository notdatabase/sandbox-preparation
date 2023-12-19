$installMusic = "https://files.catbox.moe/4cnb5v.mp3"

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $installMusic -OutFile $env:temp\installmusic.mp3

Add-Type -AssemblyName presentationCore
$mediaPlayer = New-Object System.Windows.Media.MediaPlayer
$mediaPlayer.Open("$env:temp\installmusic.mp3")
$mediaPlayer.Play()

$ascii = @"
___       __       ________       ________     
|\  \     |\  \    |\   ____\     |\   __  \    
\ \  \    \ \  \   \ \  \___|_    \ \  \|\ /_   
 \ \  \  __\ \  \   \ \_____  \    \ \   __  \  
  \ \  \|\__\_\  \   \|____|\  \    \ \  \|\  \ 
   \ \____________\    ____\_\  \    \ \_______\
    \|____________|   |\_________\    \|_______|
                      \|_________|              
                                                
                                                                                                                       
"@

$introText = @"

Windows Sandbox Preparation Script
Made with <3 by Database
v1.0.0

--------------------------------------------------------------

"@

taskkill /f /im explorer.exe > $null 2>&1

Write-Host $ascii -ForegroundColor DarkCyan

Write-Host $introText


Add-Type @"
using System;
using System.Runtime.InteropServices;
using Microsoft.Win32;
namespace Wallpaper
{
   public enum Style : int
   {
       Tile, Center, Stretch, NoChange
   }
   public class Setter {
      public const int SetDesktopWallpaper = 20;
      public const int UpdateIniFile = 0x01;
      public const int SendWinIniChange = 0x02;
      [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
      private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);
      public static void SetWallpaper ( string path, Wallpaper.Style style ) {
         SystemParametersInfo( SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange );
         RegistryKey key = Registry.CurrentUser.OpenSubKey("Control Panel\\Desktop", true);
         switch( style )
         {
            case Style.Stretch :
               key.SetValue(@"WallpaperStyle", "2") ; 
               key.SetValue(@"TileWallpaper", "0") ;
               break;
            case Style.Center :
               key.SetValue(@"WallpaperStyle", "1") ; 
               key.SetValue(@"TileWallpaper", "0") ; 
               break;
            case Style.Tile :
               key.SetValue(@"WallpaperStyle", "1") ; 
               key.SetValue(@"TileWallpaper", "1") ;
               break;
            case Style.NoChange :
               break;
         }
         key.Close();
      }
   }
}
"@

$sevenZipDownloadUrl = "https://7-zip.org/a/7z2301-x64.exe"
$braveDownloadUrl = "https://referrals.brave.com/latest/BraveBrowserSetup.exe"
$sysInternalsDownloadUrl = "https://download.sysinternals.com/files/SysinternalsSuite.zip"
$pythonDownloadUrl = "https://www.python.org/ftp/python/3.12.1/python-3.12.1-amd64.exe"
$dnspyDownloadUrl = "https://github.com/dnSpy/dnSpy/releases/download/v6.1.8/dnSpy-net-win64.zip"
$notepadPlusPlusDownloadUrl = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6/npp.8.6.Installer.x64.exe"
$x64dbgDownloadUrl = "https://sourceforge.net/projects/x64dbg/files/latest/download"
$wallpaper = "https://files.catbox.moe/6m28vc.png"
$nirsoft = "https://download.nirsoft.net/nirsoft_package_enc_1.30.8.zip"
$nirsoftReferer = "https://launcher.nirsoft.net/"



echo "Stage 1/11: Downloading software..."


$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $braveDownloadUrl -OutFile $env:temp\BraveBrowserSetup.exe

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $sevenZipDownloadUrl -OutFile $env:temp\7zSetup.exe

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $sysInternalsDownloadUrl -OutFile $env:temp\SysinternalsSuite.zip

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $wallpaper -OutFile $env:temp\wallpaper.png

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $nirsoft -Headers @{"Referer" = $nirsoftReferer } -OutFile $env:temp\nirsoft.zip

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $pythonDownloadUrl -OutFile $env:temp\pythonInstaller.exe

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $dnspyDownloadUrl -OutFile $env:temp\dnSpy.zip

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $notepadPlusPlusDownloadUrl -OutFile $env:temp\nppInstaller.exe

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $x64dbgDownloadUrl -Headers @{"User-Agent" = "Wget x64"} -OutFile $env:temp\x64dbg.zip

echo "Stage 2/11: Installing Brave..."

Start-Process -FilePath $env:temp\BraveBrowserSetup.exe -ArgumentList "/silent /install" -Wait

echo "Stage 3/11: Installing 7-Zip..."

Start-Process -FilePath $env:temp\7zSetup.exe -ArgumentList '/S /D="C:\Program Files\7-Zip"' -Wait

echo "Stage 4/11: Installing Sysinternals suite..."
$DesktopPath = [Environment]::GetFolderPath("Desktop")
New-Item $DesktopPath\Sysinternals -ItemType Directory > $null 2>&1
Expand-Archive $env:temp\SysinternalsSuite.zip -DestinationPath $DesktopPath\Sysinternals

echo "Stage 5/11: Installing Nirsoft Launcher..."

$archivePassword = "nirsoft9876$"
$7ZipPath = "C:\Program Files\7-Zip\7z.exe"
New-Item $env:temp\NirsoftLauncher -ItemType Directory > $null 2>&1
$OutputDirectory = $env:temp + "\NirsoftLauncher"
$cmd = '& $7ZipPath x $env:temp\nirsoft.zip -o"$OutputDirectory" -p"$archivePassword"'
iex $cmd > $null 2>&1

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($DesktopPath + "\Nirsoft Utilities.lnk")
$Shortcut.TargetPath = $env:temp + "\NirsoftLauncher\NirLauncher.exe"
$Shortcut.Save()

echo "Stage 6/11: Installing Python..."

Start-Process -FilePath $env:temp\pythonInstaller.exe -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait

echo "Stage 7/11: Installing dnSpy..."

New-Item $env:temp\dnSpy -ItemType Directory > $null 2>&1
Expand-Archive $env:temp\dnSpy.zip -DestinationPath $env:temp\dnSpy

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($DesktopPath + "\dnSpy.lnk")
$Shortcut.TargetPath = $env:temp + "\dnSpy\dnSpy.exe"
$Shortcut.Save()


echo "Stage 8/11: Installing Notepad++..."
Start-Process -FilePath $env:temp\nppInstaller.exe -ArgumentList "/S" -Wait


echo "Stage 9/11: Installing x64dbg..."
New-Item $env:temp\x64dbg -ItemType Directory > $null 2>&1
Expand-Archive $env:temp\x64dbg.zip -DestinationPath $env:temp\x64dbg

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($DesktopPath + "\x64dbg.lnk")
$Shortcut.TargetPath = $env:temp + "\x64dbg\release\x64\x64dbg.exe"
$Shortcut.Save()


echo "Stage 10/11: Changing system settings..."

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0

$explorerOptions = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty -Path $explorerOptions -Name "HideFileExt" -Value 0
Set-ItemProperty -Path $explorerOptions -Name "Hidden" -Value 1
[Wallpaper.Setter]::SetWallpaper("C:\Users\WDAGUtilityAccount\AppData\Local\Temp\wallpaper.png", 2)


echo "Stage 11/11: Done! Cleaning up..."

$mediaPlayer.Stop()
Remove-Item $env:temp\installmusic.mp3
Remove-Item $env:temp\BraveBrowserSetup.exe
Remove-Item $env:temp\7zSetup.exe
Remove-Item $env:temp\SysinternalsSuite.zip
Remove-Item $env:temp\nirsoft.zip
Remove-Item $env:temp\nppInstaller.exe
Remove-Item $env:temp\dnSpy.zip
Remove-Item $env:temp\x64dbg.zip
Remove-Item $env:temp\pythonInstaller.exe


Start-Process explorer.exe
Remove-Item $PSCommandPath -Force