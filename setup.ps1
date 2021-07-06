$entertainmentSoftware = "vlc", "spotify"
$developmentSoftware = "jetbrainstoolbox", "camunda-modeler", "unity", "git", "maven", "openjdk", "python3", "blender", "docker-cli", "docker-desktop"
$communicationsSoftware = "discord", "teamspeak"
$gamingSoftware = "steam-client", "epicgameslauncher", "origin"
$tools = "atom", "1password", "nvidia-display-driver", "7zip", "teamviewer", "cloudstation", "openvpn", "etcher", "obs-studio", "handbrake", "virtualbox", "filezilla"
$browser = "googlechrome"

$SophiaUrl = "https://github.com/farag2/Windows-10-Sophia-Script/releases/download/5.10.8/Sophia.Script.v5.10.8.zip"
$SophiaHash = '6716E08E06B509AC3AD3F07FB6A3368318D6F6922F1BC817F41CEA6A8AB259A1'
$InstallPath = "C:\temp"
$SophiaUrlCustomized = "https://raw.githubusercontent.com/Cuupa/windows-setup/main/Sophia.ps1"

$WallpaperURL = "https://github.com/Cuupa/windows-setup/raw/main/wanderer_bonus_5120x2880.png"

function Start-Setup() {
  Clear-Host
  Set-ExecutionPolicy RemoteSigned
  New-Item -ItemType "directory" -Path $InstallPath -Force
  Install-Updates
  Install-Sophia
  Customize-Sophia
  Call-Sophia
  Set-Wallpaper
  Install-Chocolatey
  Install-Choco-Packages
  End-Install
}

function Set-Wallpaper() {
  $WebClient = New-Object System.Net.WebClient
  $PathToDownload = $InstallPath + "\wallpaper.png"
  $WebClient.DownloadFile($WallpaperURL, $PathToDownload)
  Set-Wallpaper-Invoke($PathToDownload)
}

function Set-Wallpaper-Invoke($Image) {
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Params
{
    [DllImport("User32.dll",CharSet=CharSet.Unicode)]
    public static extern int SystemParametersInfo (Int32 uAction,
                                                   Int32 uParam,
                                                   String lpvParam,
                                                   Int32 fuWinIni);
}
"@

    $SPI_SETDESKWALLPAPER = 0x0014
    $UpdateIniFile = 0x01
    $SendChangeEvent = 0x02

    $fWinIni = $UpdateIniFile -bor $SendChangeEvent

    $ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)
}

function Log-Error($message) {
  Write-Host -ForegroundColor Red $message
  End-Install
}

function Log-Step($message) {
  Write-Host $message
}

function Install-Updates() {
  Install-Module -Name PSWindowsUpdate -confirm:$false
  Log-Step("Installed PSWindowsUpdate")
  Import-Module PSWindowsUpdate
  Log-Step("Installing Windows Updates")
  Get-WindowsUpdate -Install -AcceptAll
}

function End-Install() {
  Set-ExecutionPolicy Restricted
  pause
  exit
}

function Install-Sophia() {
  New-Item -Path $InstallPath -ItemType "directory" -Force
  $PathToDownload = $InstallPath + "\sophia.zip"
  $WebClient = New-Object System.Net.WebClient
  $WebClient.DownloadFile($SophiaUrl, $PathToDownload)
  $FileHash = Get-FileHash $PathToDownload

  if($FileHash.Hash -ne $SophiaHash) {
    Remove-Item $PathToDownload
    Log-Error("Filehash not matching")
  }

  Expand-Archive $PathToDownload -DestinationPath $InstallPath
  Log-Step("Successfully installed Sophia")
}

function Customize-Sophia() {
  $PathToDownload = $InstallPath + "\Sophia Script v5.10.8\Sophia.ps1"
  $WebClient = New-Object System.Net.WebClient
  $WebClient.DownloadFile($SophiaUrlCustomized, $PathToDownload)
  Log-Step("Successfully downloaded custom Sophia script")
}

function Call-Sophia() {
  Invoke-Expression -Command "& 'C:\temp\Sophia Script v5.10.8\Sophia.ps1'"
}

function Install-Chocolatey() {
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  Log-Step("Successfully installed chocolatey")
}

function Install-Choco-Packages() {
  choco install $entertainmentSoftware -y
  choco install $developmentSoftware -y
  choco install $communicationsSoftware -y
  choco install $gamingSoftware -y
  choco install $tools -y
  choco install $browser -y
}

Start-Setup
