Start

function Start() {
  Clear-Host
  CreateRestorePoint
  Set-ExecutionPolicy RemoteSigned
  Install-Updates
  Install-Sophia
  Customize-Sophia
  Call-Sophia
}

function Log-Error($message) {
  Write-Host -ForegroundColor Red $message
  pause
  exit
}

function Install-Updates() {
  Install-Module -Name PSWindowsUpdate -confirm:$false

  Import-Module PSWindowsUpdate
  Get-WindowsUpdate -Install -AcceptAll
}

function Exit() {
  Set-ExecutionPolicy Restricted
  exit
}

function Install-Sophia() {
  $SophiaUrl = "https://github.com/farag2/Windows-10-Sophia-Script/releases/download/5.10.8/Sophia.Script.v5.10.8.zip"
  $SophiaHash = '6716E08E06B509AC3AD3F07FB6A3368318D6F6922F1BC817F41CEA6A8AB259A1'
  $PathToDownload = "C:\temp\sophia.zip"
  $WebClient = New-Object System.Net.WebClient
  $WebClient.DownloadFile($SophiaUrl, $PathToDownload)
  $FileHash = Get-FileHash $PathToDownload.Hash

  if($FileHash -ne $SophiaHash){
    Remove-Item $PathToDownload
    Log-Error("Filehash not matching")
  }

  Expand-Archive $PathToDownload
}

function Customize-Sophia() {
  $SophiaUrl = "https://github.com/Cuupa/windows-setup/Sophia.ps1"
  $PathToDownload = "C:\temp\Sophia\Sophia.Script.v5.10.8"
  $WebClient = New-Object System.Net.WebClient
  $WebClient.DownloadFile($SophiaUrl, $PathToDownload)
}

function Call-Sophia() {
  Invoke-Expression -Command "C:\temp\Sophia\Sophia.Script.v5.10.8\Sophia.ps1"
}

function Install-Chocolatey() {
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}




$entertainmentSoftware = "vlc", "spotify"
$developmentSoftware = "jetbrainstoolbox", "camunda-modeler", "unity", "git", "maven", "openjdk", "python3", "blender", "docker-cli", "docker-desktop"
$communicationsSoftware = "discord", "teamspeak"
$gamingSoftware = "steam-client", "epicgameslauncher", "origin"
$tools = "atom", "1password", "nvidia-display-driver", "7zip", "teamviewer", "cloudstation", "openvpn", "etcher", "obs-studio", "handbrake", "virtualbox"
$browser = "googlechrome"

choco install $entertainmentSoftware
choco install $developmentSoftware
choco install $communicationsSoftware
choco install $gamingSoftware
choco install $tools
choco install $browser
