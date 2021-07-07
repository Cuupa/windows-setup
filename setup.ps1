$EntertainmentSoftware = "vlc", "spotify"
$DevelopmentSoftware = "jetbrainstoolbox", "camunda-modeler", "unity", "git", "maven", "openjdk", "python3", "blender", "docker-cli", "docker-desktop"
$CommunicationsSoftware = "discord", "teamspeak"
$GamingSoftware = "steam-client", "epicgameslauncher", "origin"
$Tools = "atom", "1password", "nvidia-display-driver", "7zip", "teamviewer", "openvpn", "etcher", "obs-studio", "handbrake", "virtualbox", "filezilla", "microsoft-windows-terminal", "makemkv", "hot-chocolatey", "powertoys"
$Browser = "googlechrome"

$DefaultBrowser = "chrome"

$SophiaUrl = "https://github.com/farag2/Windows-10-Sophia-Script/releases/download/5.10.8/Sophia.Script.v5.10.8.zip"
$SophiaHash = '6716E08E06B509AC3AD3F07FB6A3368318D6F6922F1BC817F41CEA6A8AB259A1'
$InstallPath = "C:\temp"
$SophiaUrlCustomized = "https://raw.githubusercontent.com/Cuupa/windows-setup/main/Sophia.ps1"

$WallpaperURL = "https://github.com/Cuupa/windows-setup/raw/main/wanderer_bonus_5120x2880.png"

$SetDefaultBrowserURL = "https://kolbi.cz/SetDefaultBrowser.zip"
$SetDefaultBrowserHash = '6A4EE8731BBE780D547163E8FE17003F66CEADA8B528278E7E74274E71CAA1D8'

function Start-Setup() {
  Clear-Host
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]'Tls11,Tls12'
  Set-ExecutionPolicy RemoteSigned
  New-Item -ItemType "directory" -Path $InstallPath -Force
  Install-Updates
  Install-Sophia
  Customize-Sophia
  Call-Sophia
  Set-Wallpaper
  Install-Chocolatey
  Install-Choco-Packages
  Set-Default-Browser
  Install-Third-Party-Software
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
  Stop-Service wuauserv
  Remove-Item "C:\Windows\SoftwareDistribution" -Recurse -Force
  Start-Service wuauserv
  Log-Step("Cleared Update Cache")
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

  Expand-Archive $PathToDownload -DestinationPath $InstallPath -Force
  Remove-Item $PathToDownload
  Log-Step("Successfully installed Sophia")
}

function Customize-Sophia() {
  $PathToDownload = $InstallPath + "\Sophia Script v5.10.8\Sophia.ps1"
  $WebClient = New-Object System.Net.WebClient
  $WebClient.DownloadFile($SophiaUrlCustomized, $PathToDownload)
  Log-Step("Successfully downloaded custom Sophia script")
}

function Call-Sophia() {
  $cmd =  "& '" + $InstallPath + "\Sophia Script v5.10.8\Sophia.ps1'"
  Invoke-Expression -Command
}

function Install-Chocolatey() {
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  Log-Step("Successfully installed chocolatey")
}

function Install-Choco-Packages() {
  choco install $EntertainmentSoftware -y
  choco install $DevelopmentSoftware -y
  choco install $CommunicationsSoftware -y
  choco install $GamingSoftware -y
  choco install $Tools -y
  choco install $Browser -y
}

function Set-Default-Browser() {
  $SetDefaultBrowserURL = "https://kolbi.cz/SetDefaultBrowser.zip"
  $PathToDownload = $InstallPath + "\SetDefaultBrowser.zip"
  $WebClient = New-Object System.Net.WebClient
  $WebClient.DownloadFile($SetDefaultBrowserURL, $PathToDownload)
  $FileHash = Get-FileHash $PathToDownload

  if($FileHash.Hash -ne $SetDefaultBrowserHash) {
    Remove-Item $PathToDownload
    Log-Error("Filehash not matching")
  }

  Expand-Archive $PathToDownload -DestinationPath $InstallPath -Force
  Remove-Item $PathToDownload

  $cmd =  "& '" + $InstallPath + "\SetDefaultBrowser\SetDefaultBrowser.exe chrome"
  Invoke-Expression -Command $cmd
  Log-Step("Set default Browser to " + $DefaultBrowser)
}

function Install-Third-Party-Software() {
  $PathToDownload = $InstallPath + "\lghub_installer.exe"
  $URL = "https://download01.logi.com/web/ftp/pub/techsupport/gaming/lghub_installer.exe"
  $WebClient = New-Object System.Net.WebClient
  $WebClient.DownloadFile($URL, $PathToDownload)

  $PathToDownload = $InstallPath + "\GHL-Control-Center-V1.1.3.3.zip"
  $URL = "https://www.aquariumcomputer.com/de/download/get/file/GHL-Control-Center-V1.1.3.3.zip"
  $WebClient.DownloadFile($URL, $PathToDownload)

  $PathToDownload = $InstallPath + "\Synology_Drive_Client-3.0.1-12664.exe"
  $URL = "https://global.download.synology.com/download/Utility/SynologyDriveClient/3.0.1-12664/Windows/Installer/Synology%20Drive%20Client-3.0.1-12664.exe"
  $WebClient.DownloadFile($URL, $PathToDownload)
}

Start-Setup
